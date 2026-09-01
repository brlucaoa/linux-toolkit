#!/bin/bash

ENTRY="$1"

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
case "$ENTRY" in

    hermes)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - HERMES_PROD"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_prod/update_prod.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;

    api)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - HERMES_API"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_api/update_api.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;

    *)
        echo "Comando inválido: $ENTRY"
        exit 1
        ;;

esac
