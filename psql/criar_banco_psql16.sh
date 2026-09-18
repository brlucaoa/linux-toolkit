#!/bin/bash
set -euo pipefail

# Uso:
#   PGPASSWORD="sua_senha" ./criar_banco.sh -n "db46053026000107" [opções]
#
# Opções:
#   -h HOST       Host do PostgreSQL (padrão: localhost)
#   -p PORTA      Porta do PostgreSQL (padrão: 5432)
#   -u USUARIO    Usuário com privilégio para criar bancos (padrão: postgres)
#   -a ADMINDB    Banco usado para a conexão administrativa (padrão: postgres)
#   -t TEMPLATE   Banco que servirá de template (padrão: interno)
#   -o OWNER      Owner do novo banco (padrão: dba_hermes)
#   -n NOVODB     Nome do novo banco a ser criado (obrigatório)
#   -s SSLMODE    Modo SSL (padrão: disable)
#
# A senha deve ser definida na variável de ambiente PGPASSWORD antes de rodar.

HOST="localhost"
PORT="5432"
ADMIN_USER="postgres"
ADMIN_DB="postgres"
TEMPLATE_DB="interno"
OWNER="dba_hermes"
NEW_DB=""
SSLMODE="disable"

while getopts "h:p:u:a:t:o:n:s:" opt; do
  case "$opt" in
    h) HOST="$OPTARG" ;;
    p) PORT="$OPTARG" ;;
    u) ADMIN_USER="$OPTARG" ;;
    a) ADMIN_DB="$OPTARG" ;;
    t) TEMPLATE_DB="$OPTARG" ;;
    o) OWNER="$OPTARG" ;;
    n) NEW_DB="$OPTARG" ;;
    s) SSLMODE="$OPTARG" ;;
    *)
      echo "Opção inválida." >&2
      exit 1
      ;;
  esac
done

if [ -z "$NEW_DB" ]; then
  echo "Erro: informe o nome do novo banco com -n \"nome_do_banco\"" >&2
  exit 1
fi

if [ -z "${PGPASSWORD:-}" ]; then
  echo "Erro: defina a variável de ambiente PGPASSWORD antes de executar" >&2
  exit 1
fi

if ! command -v psql >/dev/null 2>&1; then
  echo "Erro: o cliente 'psql' não foi encontrado no PATH" >&2
  exit 1
fi

export PGPASSWORD

PSQL_BASE=(psql -h "$HOST" -p "$PORT" -U "$ADMIN_USER" -d "$ADMIN_DB" -v ON_ERROR_STOP=1 --set=sslmode="$SSLMODE")

echo "Finalizando conexões ativas no banco \"$TEMPLATE_DB\"..."
"${PSQL_BASE[@]}" -c "
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = '${TEMPLATE_DB}'
  AND pid <> pg_backend_pid();
"

echo "Criando banco \"$NEW_DB\" a partir do template \"$TEMPLATE_DB\" (owner: $OWNER)..."
"${PSQL_BASE[@]}" -c "
CREATE DATABASE \"${NEW_DB}\"
WITH TEMPLATE \"${TEMPLATE_DB}\" OWNER \"${OWNER}\";
"

echo "Banco \"$NEW_DB\" criado com sucesso."