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

echo "PORTAL=$PORTAL"
echo "REGISTRY=$REGISTRY"

BOLD=$(tput setaf 5)
QSTN=$(tput setaf 6)
INFO=$(tput setaf 2)
DFLT=$(tput sgr0)

echo "${INFO}Iniciando atualizacao do $PORTAL_NAME em producao...${DFLT}"

echo "${INFO}Parando container...${DFLT}"
docker stop $PORTAL_NAME 2>/dev/null

echo "${INFO}Removendo container...${DFLT}"
docker container rm $PORTAL_NAME 2>/dev/null

echo "${INFO}Removendo imagem...${DFLT}"
docker rmi $REGISTRY/$PORTAL:latest 2>/dev/null

echo "${INFO}Login no ambiente de containers...${DFLT}"
docker login -u $LOGIN_REGISTRY -p "$PASSWD_REGISTRY" $REGISTRY 2>/dev/null

echo "${INFO}Inicializando novo container...${DFLT}"
echo "PORTAL=[$PORTAL]"
echo "REGISTRY=[$REGISTRY]"
echo "V1=[$V1]"
echo "V2=[$V2]"
echo "V3=[$V3]"
echo "IMAGE=[$REGISTRY/$PORTAL:latest]"

docker run -d \
    --privileged=true \
    --name "$PORTAL_NAME" \
    --restart always \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    --ulimit nofile=262144:262144 \
    --ulimit memlock=819200000:819200000 \
    -p 8180:8180 \
    -v "$V1" \
    -v "$V2" \
    -v "$V3" \
    "$REGISTRY/$PORTAL:latest"
