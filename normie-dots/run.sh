#!/bin/sh
export LD_LIBRARY_PATH="$HOME/bitwig/opt/bitwig-studio/bin:$HOME/bitwig/opt/bitwig-studio/lib/bitwig-studio"
exec steam-run "$HOME/bitwig/opt/bitwig-studio/bitwig-studio" "$@"
