#!/bin/sh

SCRIPT_DIR=$(dirname "$0")
PROJECT_DIR=$(cd "$SCRIPT_DIR/../.." && pwd)
ENV_FILE="$PROJECT_DIR/.env"

echo "Script: $0"
echo "Script dir: $SCRIPT_DIR"
echo "Project dir: $PROJECT_DIR"
echo "Env file: $ENV_FILE"

if [ ! -r "$ENV_FILE" ]; then
    echo "ERRO: não consigo ler $ENV_FILE"
    exit 1
fi

. "$ENV_FILE"

echo "API=$API"
echo "REGISTRY=$REGISTRY"

BOLD=$(tput setaf 5)
QSTN=$(tput setaf 6)
INFO=$(tput setaf 2)
DFLT=$(tput sgr0)

echo "${INFO}Iniciando atualizacao do hermes_api em producao...${DFLT}"

echo "${INFO}Parando container...${DFLT}"
docker stop $PROD 2>/dev/null

echo "${INFO}Removendo container...${DFLT}"
docker container rm $PROD 2>/dev/null

echo "${INFO}Removendo imagem...${DFLT}"
docker rmi $REGISTRY/$PROD:latest 2>/dev/null

echo "${INFO}Login no ambiente de containers...${DFLT}"
docker login -u $LOGIN_REGISTRY -p "$PASSWD_REGISTRY" $REGISTRY 2>/dev/null

echo "${INFO}Inicializando novo container...${DFLT}"
echo "API=[$API]"
echo "REGISTRY=[$REGISTRY]"
echo "V1=[$V1]"
echo "V2=[$V2]"
echo "V3=[$V3]"
echo "IMAGE=[$REGISTRY/$PROD:latest]"

docker run -d \
    --privileged=true \
    --name "$PROD_NAME" \
    --restart always \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    --ulimit nofile=262144:262144 \
    --ulimit memlock=819200000:819200000 \
    -p 9080:9080 \
    -v "$V1" \
    -v "$V2" \
    -v "$V3" \
    -v "$V4" \
    "$REGISTRY/$PROD:latest"