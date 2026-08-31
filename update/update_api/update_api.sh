#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../.env"

BOLD=$(tput setaf 5)
QSTN=$(tput setaf 6)
INFO=$(tput setaf 2)
DFLT=$(tput sgr0)

echo "${INFO}Iniciando atualizacao do hermes_api em producao...${DFLT}"

echo "${INFO}Parando container...${DFLT}"
docker stop $API 2>/dev/null

echo "${INFO}Removendo container...${DFLT}"
docker container rm $API 2>/dev/null

echo "${INFO}Removendo imagem...${DFLT}"
docker rmi $REGISTRY/$API:latest 2>/dev/null

echo "${INFO}Login no ambiente de containers...${DFLT}"
docker login -u $LOGIN_REGISTRY -p "$PASSWD_REGISTRY" $REGISTRY 2>/dev/null

echo "${INFO}Inicializando novo container...${DFLT}"
docker run -d \
--privileged=true \
--name $API \
--restart always \
--log-driver json-file \
--log-opt max-size=10m \
--log-opt max-file=3 \
--ulimit nofile=262144:262144 \
--ulimit memlock=819200000:819200000 \
-p 9080:9080 \
-v $V1 \
-v $V2 \
-v $V3 \
$REGISTRY/$API:latest
