#!/usr/bin/env bash
# Internal helper script, without help message or PATH magic

# Set some convenient defaults, but allow external overrides
X11VNC_RUN_OPT_DEFAULTS="-quiet -shared -forever"
X11VNC_RUN_OPT=${X11VN_RUN_OPT:-${X11VNC_RUN_OPT_DEFAULTS}}

# Hardcoded password better than no password. At least overrideable
X11VNC_PASSWD="${X11VNC_PASSWD:-whatever}"

# Export the current display as a VNC server, in the background
set -e  # exit on error
x11vnc -passwd "${X11VNC_PASSWD}" $X11VNC_RUN_OPT &
X11VNC_PID=$!

# Start the command and save its exit status.
set +e
"$@"
RETVAL=$?
set -e

# Kill x11vnc now that the command has exited.
kill $X11VNC_PID

# Preserve the payload command's exit status.
exit $RETVAL
