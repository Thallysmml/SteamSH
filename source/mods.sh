#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SCRIPT_DIR/config.sh"

echo "I'm sorry, i'm still working in that"
sleep 5
clear
exec "$FIRST"

