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
    edicustom)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - EDICUSTOM"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_edicustom/update_edicustom.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    actions)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - ACTIONS"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_actions/update_actions.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    ciot)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - CIOT"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_ciot/update_ciot.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    emissor)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - EMISSOR"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_emissor/update_emissor.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    hotfix)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - HOTFIX"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_hotfix/update_hotfix.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    local)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - LOCAL"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_local/update_local.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    nfse)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - NFSE"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_nfse/update_nfse.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    portal)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - PORTAL"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_portal/update_portal.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    tasker)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - TASKER"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_tasker/update_tasker.sh"
                ;;
            n|N|"")
                echo "Operação cancelada"
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
        ;;
    wsint)
        echo "Atenção! Esta operação irá atualizar o ambiente de produção - WSINT"
        read -p "Deseja executar o script? [s/N]: " REPLY

        case "$REPLY" in
            s|S)
                sh "$SCRIPT_DIR/update_wsint/update_wsint.sh"
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
