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

echo "NFSE=$NFSE"
echo "REGISTRY=$REGISTRY"

BOLD=$(tput setaf 5)
QSTN=$(tput setaf 6)
INFO=$(tput setaf 2)
DFLT=$(tput sgr0)

echo "${INFO}Iniciando atualizacao do $NFSE_NAME em producao...${DFLT}"

echo "${INFO}Parando container...${DFLT}"
docker stop $NFSE_NAME 2>/dev/null

echo "${INFO}Removendo container...${DFLT}"
docker container rm $NFSE_NAME 2>/dev/null

echo "${INFO}Removendo imagem...${DFLT}"
docker rmi $REGISTRY/$NFSE:latest 2>/dev/null

echo "${INFO}Login no ambiente de containers...${DFLT}"
docker login -u $LOGIN_REGISTRY -p "$PASSWD_REGISTRY" $REGISTRY 2>/dev/null

echo "${INFO}Inicializando novo container...${DFLT}"
echo "NFSE=[$NFSE]"
echo "REGISTRY=[$REGISTRY]"
echo "V1=[$V1]"
echo "V2=[$V2]"
echo "V3=[$V3]"
echo "IMAGE=[$REGISTRY/$NFSE:latest]"

docker run -d \
    --privileged=true \
    --name "$NFSE_NAME" \
    --restart always \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    -p 8380:8380 \
    -v "$V1" \
    -v "$V2" \
    -v "$V3" \
    "$REGISTRY/$NFSE:latest"
