#!/bin/bash

set -e

LOG="/var/log/log_$(date +'%Y_%m_%d_%H_%M_%S').log"

exec > >(tee -a "$LOG") 2>&1

COMMAND="$1"
ENTRY_1="$2"
ENTRY_2="$3"

FOLDER="$(pwd)"

case "$COMMAND" in
    update)
        sh "$FOLDER/update/update_main.sh" "$ENTRY_1" "$ENTRY_2"
        ;;
    backup)
        sh "$FOLDER/psql/psql.sh" "$ENTRY_1"
        ;;
    *)
        echo "Comando inválido: $COMMAND"
        exit 1
        ;;
esac