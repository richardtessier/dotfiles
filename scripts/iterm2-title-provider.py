#!/usr/bin/env python3

import asyncio
import iterm2

async def main(connection):
    @iterm2.TitleProviderRPC
    async def project_title(
        project=iterm2.Reference("user.project?"),
        tab_role=iterm2.Reference("user.tabRole?"),
        auto_name=iterm2.Reference("autoName?"),
        profile_name=iterm2.Reference("profileName?")):

        if project and tab_role:
            return f"{project} - {tab_role}"

        if auto_name and auto_name != profile_name:
            return auto_name
        return profile_name or ""

    await project_title.async_register(
        connection,
        display_name="Project Title",
        unique_identifier="com.richardtessier.project-title")

    # Run both monitors concurrently
    await asyncio.gather(
        _sync_on_tab_switch(connection),
        _sync_on_project_set(connection))


async def _sync_window_title(connection, tab):
    """Set the window title to match a tab's title."""
    title = await tab.async_get_variable("title")
    if title and tab.window:
        await tab.window.async_set_title(title)


async def _sync_on_tab_switch(connection):
    """Update window title whenever the active tab changes."""
    async with iterm2.FocusMonitor(connection) as mon:
        while True:
            update = await mon.async_get_next_update()
            if update.selected_tab_changed:
                tab_id = update.selected_tab_changed.tab_id
                app = await iterm2.async_get_app(connection)
                for window in app.terminal_windows:
                    for tab in window.tabs:
                        if tab.tab_id == tab_id:
                            await _sync_window_title(connection, tab)
                            break


async def _sync_on_project_set(connection):
    """When user.project is set on an AI session, update the window title."""
    async with iterm2.NewSessionMonitor(connection) as mon:
        while True:
            session_id = await mon.async_get()
            asyncio.create_task(_watch_session(connection, session_id))


async def _watch_session(connection, session_id):
    app = await iterm2.async_get_app(connection)
    session = app.get_session_by_id(session_id)
    if not session:
        return

    try:
        profile = await session.async_get_profile()
        if profile.name != "AI":
            return
    except Exception:
        return

    async with iterm2.VariableMonitor(
        connection,
        iterm2.VariableScopes.SESSION,
        "user.project",
        session_id
    ) as mon:
        project = await mon.async_get()
        if not project:
            return
        # Find the window and set title from its active tab
        app = await iterm2.async_get_app(connection)
        for window in app.terminal_windows:
            for tab in window.tabs:
                if session in tab.sessions:
                    active_tab = window.current_tab
                    if active_tab:
                        await _sync_window_title(connection, active_tab)
                    return


iterm2.run_forever(main)
