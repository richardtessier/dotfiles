# /// script
# requires-python = ">=3.12"
# dependencies = ["iterm2"]
# ///
"""Launch a new iTerm2 workspace with Claude + Terminal tabs.

Creates a new window with the "AI" profile, sets up a Claude tab and a
Terminal tab, and sets user variables via the API directly.
"""

import asyncio
import os
import subprocess
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
        print("Usage: iterm2-launch-workspace.py <target_dir>", file=sys.stderr)
        sys.exit(1)

    target_dir = os.path.abspath(os.path.expanduser(sys.argv[1]))
    project = os.path.basename(os.path.normpath(target_dir))

    app = await iterm2.async_get_app(connection)

    # Create new window with AI profile
    window = await iterm2.Window.async_create(connection, profile="AI")
    if not window:
        print("Failed to create iTerm2 window", file=sys.stderr)
        sys.exit(1)

    # Set up Claude tab (first tab in new window)
    claude_session = window.current_tab.current_session
    await _wait_for_prompt(connection, claude_session)
    await _set_user_vars(claude_session, project, "Claude")
    await claude_session.async_send_text(f"cd '{target_dir}' && clear && claude\r")

    # Create Terminal tab
    new_tab = await window.async_create_tab(profile="AI")
    terminal_session = new_tab.current_session
    await _wait_for_prompt(connection, terminal_session)
    await _set_user_vars(terminal_session, project, "Terminal")
    await terminal_session.async_send_text(f"cd '{target_dir}'\r")

    # Select the Claude tab (first tab)
    await window.tabs[0].async_select()

    # Launch Obsidian if not running
    try:
        subprocess.run(["pgrep", "-xq", "Obsidian"], check=True)
    except subprocess.CalledProcessError:
        subprocess.run(["open", "-a", "Obsidian"])


iterm2.run_until_complete(main)
