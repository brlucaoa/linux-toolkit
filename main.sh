#!/bin/bash

set -e

COMMAND="$1"
ENTRY_1="$2"
ENTRY_2="$3"

FOLDER="$(pwd)"

case "$COMMAND" in
    update)
        sh "$FOLDER/update/update_main.sh" "$ENTRY_1" "$ENTRY_2"
        ;;
    *)
        echo "Comando inválido: $COMMAND"
        exit 1
        ;;
esac