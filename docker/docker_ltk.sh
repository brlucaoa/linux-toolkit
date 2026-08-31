#!/bin/bash
set -e

$1
$2
$3

COMMAND=$1
SUBCOMMAND=$2
CONTAINER=$3

if [ $COMMAND -eq "ctr" ]; then 
    if [ $SUBCOMMAND -eq "logs" ]; then
        docker logs -f --tail 300 $CONTAINER
        elif [ $SUBCOMMAND -eq "insp"]; then
        docker inspect $CONTAINER
        elif [ $SUBCOMMAND -eq "stats"]; then
        docker stats
        else
        echo "Container não existe"

    else echo "Comando não existe"

