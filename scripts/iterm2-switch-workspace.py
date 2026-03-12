#!/usr/bin/env python3
"""Switch iTerm2 workspace tabs to a new project directory.

Finds tabs in the current window by their user.tabRole variable,
sends /exit + relaunch to the Claude tab, and cd to the Terminal tab.
User vars are set via the API directly to keep the terminal clean.
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

    for tab in window.tabs:
        session = tab.current_session
        role = await session.async_get_variable("user.tabRole")

        if role == "Claude":
            await session.async_send_text("/exit\r")
            await _wait_for_prompt(connection, session)
            await _set_user_vars(session, project, "Claude")
            await session.async_send_text(f"cd '{target_dir}' && clear && claude\r")
        elif role == "Terminal":
            await _set_user_vars(session, project, "Terminal")
            await session.async_send_text(f"cd '{target_dir}'\r")


iterm2.run_until_complete(main)
