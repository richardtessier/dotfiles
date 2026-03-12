# /// script
# requires-python = ">=3.12"
# dependencies = ["iterm2"]
# ///
"""Switch iTerm2 workspace tabs to a new project directory.

Finds tabs in the current window by their user.tabRole variable,
sends /exit + relaunch to the Claude tab, and cd to the Terminal tab.

If the current window doesn't have a workspace structure (Claude + Terminal
tabs), it bootstraps one by treating the current tab as Terminal and creating
a new Claude tab in front of it.
"""

import asyncio
import os
import sys

import iterm2


async def _wait_for_prompt(connection, session, timeout=15):
    """Wait for a shell prompt using iTerm2's PromptMonitor (event-driven)."""
    async with iterm2.PromptMonitor(
        connection, session.session_id, modes=[iterm2.PromptMonitor.Mode.PROMPT]
    ) as mon:
        try:
            await asyncio.wait_for(mon.async_get(), timeout=timeout)
        except asyncio.TimeoutError:
            print("Warning: timed out waiting for shell prompt", file=sys.stderr)


async def _set_user_vars(session, project, role):
    """Set project and tabRole user vars directly via the API."""
    await session.async_set_variable("user.project", project)
    await session.async_set_variable("user.tabRole", role)


async def main(connection):
    if len(sys.argv) < 2:
        print("Usage: iterm2-switch-workspace.py <target_dir>", file=sys.stderr)
        sys.exit(1)

    target_dir = os.path.abspath(os.path.expanduser(sys.argv[1]))
    project = os.path.basename(os.path.normpath(target_dir))

    app = await iterm2.async_get_app(connection)
    window = app.current_window

    if not window:
        print("No current iTerm2 window found", file=sys.stderr)
        sys.exit(1)

    # Discover existing workspace roles
    claude_tab = None
    terminal_tab = None
    for tab in window.tabs:
        session = tab.current_session
        role = await session.async_get_variable("user.tabRole")
        if role == "Claude":
            claude_tab = tab
        elif role == "Terminal":
            terminal_tab = tab

    # Bootstrap missing workspace structure
    if not claude_tab:
        # Treat current tab as Terminal if it doesn't have a role yet
        if not terminal_tab:
            terminal_tab = window.current_tab

        # Create Claude tab, then reorder to first position via
        # async_set_tabs to properly update Cmd+N shortcuts
        claude_tab = await window.async_create_tab(profile="AI")
        await _wait_for_prompt(connection, claude_tab.current_session)
        other_tabs = [t for t in window.tabs if t.tab_id != claude_tab.tab_id]
        await window.async_set_tabs([claude_tab] + other_tabs)

    if not terminal_tab:
        if window.current_tab.tab_id == claude_tab.tab_id:
            # Only Claude tab exists, create a new Terminal tab
            terminal_tab = await window.async_create_tab(profile="AI")
            await _wait_for_prompt(connection, terminal_tab.current_session)
        else:
            terminal_tab = window.current_tab

    # Switch Claude tab
    claude_session = claude_tab.current_session
    existing_role = await claude_session.async_get_variable("user.tabRole")
    if existing_role == "Claude":
        await claude_session.async_send_text("/exit\r")
        await _wait_for_prompt(connection, claude_session)
    await _set_user_vars(claude_session, project, "Claude")
    await claude_session.async_send_text(f"cd '{target_dir}' && clear && claude\r")

    # Switch Terminal tab
    terminal_session = terminal_tab.current_session
    await _set_user_vars(terminal_session, project, "Terminal")
    await terminal_session.async_send_text(f"cd '{target_dir}'\r")

    # Select Claude tab
    await claude_tab.async_select()


iterm2.run_until_complete(main)
