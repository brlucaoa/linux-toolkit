# Linux Toolkit

Kit de ferramentas para automação de operações de infraestrutura e deploy em ambiente Linux. Gerencia containers Docker, backups de banco PostgreSQL e atualizações de serviços.

## Estrutura do Projeto

```
linux-toolkit/
├── main.sh                    # Script principal (entrypoint)
├── .env                       # Variáveis de ambiente (não versionado)
├── .gitignore
├── update/                    # Scripts de atualização de containers
│   ├── update_main.sh         # Roteador dos comandos de update
│   ├── update_prod/           # Serviço principal (prod)
│   ├── update_api/            # API
│   ├── update_actions/        # Actions
│   ├── update_ciot/           # CIOT
│   ├── update_emissor/        # Emissor
│   ├── update_wsint/          # WSIntegração
│   ├── update_tasker/         # Tasker
│   ├── update_portal/         # Portal
│   ├── update_nfse/           # NFSe
│   ├── update_hotfix/         # Hotfix via registry local
│   ├── update_local/          # Deploy local via arquivo .tar
│   ├── edi_custom/            # EDI Custom (PHP)
│   └── update_all/            # Atualização em massa
├── psql/
│   └── psql.sh                # Backup de banco PostgreSQL
├── backup/
│   └── backup_ltk.sh          # Script de backup (em desenvolvimento)
└── docker/
    └── docker_ltk.sh          # Utilitários Docker
```

## Pré-requisitos

- Linux (Ubuntu/Debian ou equivalente)
- Docker instalado e configurado
- Acesso ao registry de containers
- Permissões de sudo (para operações Docker)
- PostgreSQL (para operações de backup)

## Configuração

### 1. Variáveis de Ambiente

Crie o arquivo `.env` na raiz do projeto:

```bash
# Registry e Credenciais
REGISTRY="seu-registry.com"

```

### 2. Tornar os scripts executáveis

```bash
chmod +x main.sh
chmod +x update/update_main.sh
chmod +x update/*/*.sh
chmod +x psql/psql.sh
chmod +x docker/docker_ltk.sh
```

## Uso

### Comando Principal

```bash
./main.sh <comando> <argumento>
```

---

### Atualização de Containers

```bash
./main.sh update <servico>
```

Cada execução solicita confirmação interativa antes de prosseguir.

#### Serviços disponíveis

| Comando     | Descrição               | Porta  |
|-------------|-------------------------|--------|
| `prod`      | Serviço principal       | 8081   |
| `api`       | API                     | 9080   |
| `actions`   | Actions                 | 9083   |
| `ciot`      | CIOT                    | 8580   |
| `emissor`   | Emissor                 | 8980   |
| `wsint`     | WSIntegração            | 8780   |
| `tasker`    | Tasker                  | 8280   |
| `portal`    | Portal                  | 8180   |
| `nfse`      | NFSe                    | 8380   |
| `edicustom` | EDI Custom (PHP)        | 8099   |
| `hotfix`    | Hotfix via registry local | 8081 |
| `local`     | Deploy local via .tar   | 8081   |

#### Exemplos

```bash
# Atualizar a API
./main.sh update api

# Atualizar o serviço principal
./main.sh update prod

# Hotfix (usa registry local)
./main.sh update hotfix

# Deploy local (carrega imagem de arquivo .tar)
./main.sh update local
```

---

### Backup de Banco PostgreSQL

```bash
./main.sh backup <nome_do_banco>
```

Executa `pg_dump` no banco informado e salva compactado (gzip) em `/tmp/<nome_do_banco>.gz`.

#### Exemplo

```bash
./main.sh backup meu_banco
```

---

### Utilitários Docker

```bash
./docker/docker_ltk.sh ctr <subcomando> <container>
```

| Subcomando | Descrição                                              |
|------------|--------------------------------------------------------|
| `logs`     | Exibe logs do container (últimas 300 linhas, follow)   |
| `insp`     | Exibe inspect do container                             |
| `stats`    | Exibe stats de todos os containers                     |

#### Exemplos

```bash
./docker/docker_ltk.sh ctr logs meu_container
./docker/docker_ltk.sh ctr insp meu_container
./docker/docker_ltk.sh ctr stats
```

## Fluxo de Atualização

Cada script de atualização segue o mesmo padrão:

1. Detecta o diretório do projeto
2. Carrega as variáveis do arquivo `.env`
3. Para o container em execução
4. Remove o container antigo
5. Remove a imagem antiga do registry
6. Faz login no registry Docker
7. Inicia um novo container com a imagem atualizada

## Logs

Os logs de execução do `main.sh` são salvos em:

```
/var/log/toolkit_log_<data_hora>.log
```

## Notas de Segurança

- O arquivo `.env` contém credenciais e **não deve ser versionado**
- O `.gitignore` já está configurado para ignorar o `.env`
- Nunca exponha senhas em scripts ou logs
- Considere usar variáveis de ambiente do sistema em produção
