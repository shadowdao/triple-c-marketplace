#!/bin/sh
# Stop hook: ring the terminal bell and leave a line on stderr.
# Portable on purpose: no desktop notification tools exist in the container.
printf '\a' >&2
printf 'Claude finished at %s\n' "$(date '+%H:%M:%S')" >&2
exit 0
