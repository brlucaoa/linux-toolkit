#!/bin/sh

SCRIPT_DIR=$(dirname "$0")
PROJECT_DIR=$(cd "$SCRIPT_DIR/../.." && pwd)
ENV_FILE="$PROJECT_DIR/.env"

echo "Script: $0"
echo "Script dir: $SCRIPT_DIR"
echo "Project dir: $PROJECT_DIR"
echo "Env file: $ENV_FILE"

if [ ! -r "$ENV_FILE" ]; then
    echo "ERRO: erro ao abrir $ENV_FILE"
    exit 1
fi

. "$ENV_FILE"

#!/bin/bash
BOLD=$(tput setaf 5)
QSTN=$(tput setaf 6)
INFO=$(tput setaf 2)
DFLT=$(tput sgr0)
echo "${INFO}Iniciando atualizagco do www php...${DFLT}"
echo "${INFO}Parando container...${DFLT}"
docker stop $EDICUSTOM
echo "${INFO}Removendo container...${DFLT}"
docker container rm $EDICUSTOM
echo "${INFO}Removendo imagem...${DFLT}"
docker rmi $REGISTRY_PHP
echo "${INFO}Login no ambiente de containers...${DFLT}"
docker login -u $LOGIN_SULMOVEIS -p $PASSWD_SULMOVEIS $REGISTRY 2>/dev/null
echo "${INFO}Inicializando novo container...${DFLT}"
docker run -d \
    --privileged=true \
    --name $EDICUSTOM \
    --restart always  \
    -p 8099:80 \
    -v /var/www/html/edicustom:/var/www/html \
    -v /opt/edicustom_prod:/opt/edicustom_prod \
    -v /home/hermes_prod/clientes:/home/hermes_prod/clientes \
    $REGISTRY_PHP:latest