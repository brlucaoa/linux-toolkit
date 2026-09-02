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

echo "CIOT=$CIOT_NAME"
echo "REGISTRY=$REGISTRY"
echo "Atualizando $CIOT_NAME..."

docker stop $CIOT_NAME 2>/dev/null
docker rm $CIOT_NAME 2>/dev/null
docker rmi $REGISTRY_HERMES/$CIOT:latest 2>/dev/null

docker login -u $LOGIN_REGISTRY -p $PASSWD_REGISTRY $REGISTRY 2>/dev/null

docker run -d \
    --name $CIOT_NAME \
    --restart always \
    --log-driver json-file \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    -p 8580:8580 \
    -v "$V1" \
    -v "$V2" \
    $REGISTRY_HERMES/$CIOT:latest