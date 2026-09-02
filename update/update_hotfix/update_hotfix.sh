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

echo "LOCAL_IMAGE=$LOCAL_IMAGE"
echo "REGISTRY_LOCAL=$REGISTRY_LOCAL"

BOLD=$(tput setaf 5)
QSTN=$(tput setaf 6)
INFO=$(tput setaf 2)
DFLT=$(tput sgr0)

echo "${INFO}Iniciando atualizacao do hermes em producao (HOTFIX)...${DFLT}"

echo "${INFO}Parando container...${DFLT}"
docker stop $PROD_NAME 2>/dev/null

echo "${INFO}Removendo container...${DFLT}"
docker container rm $PROD_NAME 2>/dev/null

echo "${INFO}Removendo imagem...${DFLT}"
docker rmi $REGISTRY_LOCAL/$LOCAL_IMAGE:latest 2>/dev/null

echo "${INFO}Inicializando novo container...${DFLT}"
echo "LOCAL_IMAGE=[$LOCAL_IMAGE]"
echo "REGISTRY_LOCAL=[$REGISTRY_LOCAL]"
echo "HOTFIX_TAG=[$HOTFIX_TAG]"
echo "V1=[$V1]"
echo "V2=[$V2]"
echo "V3=[$V3]"
echo "IMAGE=[$REGISTRY_LOCAL/$LOCAL_IMAGE:$HOTFIX_TAG]"

docker run -d \
    --privileged=true \
    --name "$PROD_NAME" \
    --restart always \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    --ulimit nofile=262144:262144 \
    --ulimit memlock=819200000:819200000 \
    -p 8081:8080 \
    -v "$V1" \
    -v "$V2" \
    -v "$V3" \
    "$REGISTRY_LOCAL/$LOCAL_IMAGE:$HOTFIX_TAG"
