#!/bin/bash

ENTRY="$1"

su - postgres pg_dump $1 | gzip > /tmp/$1.gz

if [ $? -eq 0 ] then
    echo "Arquivo salvo em /tmp/$1"
else
    echo "Falha ao realizar backup"
fi
