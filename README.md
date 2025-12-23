# Inventário de Acessos - Cloud Infrastructure

Sistema completo de gerenciamento e documentação de infraestrutura cloud (AWS e GCP), incluindo serviços self-hosted e integrações de terceiros.

## 📋 Visão Geral

Este repositório mantém um inventário organizado de todos os recursos de infraestrutura cloud da organização, incluindo:

- **AWS Services**: Amplify, Lambda, RDS, DynamoDB, S3, EC2, etc.
- **GCP Services**: Compute Engine, Cloud Storage, Cloud SQL, GKE, etc.
- **Self-Hosted Services**: Apache Nifi, Airflow, Prefect, DBT, Streamlit, Agentes, etc.
- **Third-Party Services**: GitHub, Salesforce, Bitrise, etc.
- **CI/CD & IaC**: Terraform, GitHub Actions, Pipelines

## 🚀 Quick Start

### 1. Visualizar o Inventário

O inventário completo está disponível em: [`INVENTORY.md`](./INVENTORY.md)

Este arquivo contém:
- URLs de acesso para cada serviço
- Tipos de acesso (Console, CLI, API)
- Informações sobre credenciais
- Status de MFA
- Notas de segurança

### 2. Importar Bookmarks para Chrome

Para facilitar o acesso aos serviços:

1. Abra o Chrome
2. Vá em: `Configurações` → `Favoritos` → `Gerenciar favoritos`
3. Clique nos três pontos (⋮) → `Importar favoritos`
4. Selecione o arquivo: `bookmarks/cloud-infrastructure.html`
5. Os favoritos serão organizados em uma pasta "Inventário Cloud" com subpastas:
   - AWS Services
   - GCP Services
   - Data Engineering
   - Development & CI/CD
   - Third-Party Services
   - Internal Services

### 3. Executar Atualização Manual

Para atualizar o inventário manualmente:

```bash
# Dar permissão de execução ao script
chmod +x scripts/update-inventory.sh

# Executar atualização
./scripts/update-inventory.sh
```

O script irá:
- ✅ Criar backup do inventário atual
- 🔍 Verificar serviços AWS (se AWS CLI configurado)
- 🔍 Verificar serviços GCP (se gcloud CLI configurado)
- 🔍 Verificar serviços self-hosted locais
- 📝 Atualizar timestamp no inventário

## ⚙️ Configuração de Automação

### Opção 1: GitHub Actions (Recomendado)

O repositório já está configurado com GitHub Actions para atualização semanal automática.

**Configuração necessária:**

1. Configure os seguintes secrets no GitHub:
   - `AWS_ACCESS_KEY_ID` (opcional)
   - `AWS_SECRET_ACCESS_KEY` (opcional)
   - `GCP_SA_KEY` (opcional)
   - `GCP_PROJECT_ID` (opcional)

2. O workflow roda automaticamente toda segunda-feira às 9:00 UTC

3. Para executar manualmente:
   - Vá em `Actions` → `Weekly Inventory Update` → `Run workflow`

### Opção 2: Cron Job Local

Para configurar agendamento local:

```bash
# Executar script de configuração
chmod +x scripts/setup-weekly-schedule.sh
./scripts/setup-weekly-schedule.sh
```

Isso configura um cron job para executar toda segunda-feira às 9:00.

## 📁 Estrutura do Projeto

```
inventario-acessos/
├── INVENTORY.md                    # Documento principal do inventário
├── README.md                       # Este arquivo
├── .gitignore                      # Ignora credenciais e arquivos sensíveis
├── bookmarks/
│   └── cloud-infrastructure.html   # Bookmarks organizados para Chrome
├── scripts/
│   ├── update-inventory.sh         # Script de atualização do inventário
│   └── setup-weekly-schedule.sh    # Configura agendamento semanal
├── .github/
│   └── workflows/
│       └── weekly-inventory.yml    # GitHub Actions para automação
└── backup/                         # Backups automáticos (criado automaticamente)
```

## 🔐 Segurança

### Boas Práticas

1. **Nunca commite credenciais** - Use o `.gitignore` para proteger arquivos sensíveis
2. **MFA obrigatório** - Habilite MFA em todos os serviços que suportam
3. **Least Privilege** - Use apenas as permissões necessárias
4. **Rotação de Credenciais** - Rode credenciais a cada 90 dias
5. **Auditoria Regular** - Revise acessos mensalmente

### Arquivos Protegidos

O `.gitignore` já está configurado para proteger:
- Credenciais AWS/GCP
- Chaves privadas (.key, .pem)
- Arquivos .env
- Service account keys
- Terraform state files

## 📅 Processo de Atualização

### Atualização Semanal (Automática)

- **Quando:** Toda segunda-feira às 9:00 UTC
- **Como:** GitHub Actions ou cron job
- **Objetivo:** Verificar mudanças menores e atualizar timestamps

### Atualização Imediata (Manual)

Execute quando houver:
- Novos serviços adicionados
- Migrações de infraestrutura
- Mudanças significativas em URLs ou acessos
- Alterações de credenciais

```bash
./scripts/update-inventory.sh
git add INVENTORY.md
git commit -m "Update inventory: [descrição da mudança]"
git push
```

### Revisão Mensal (Manual)

Uma vez por mês, faça uma revisão completa:
1. Verifique todos os serviços listados
2. Confirme URLs e tipos de acesso
3. Valide status de MFA
4. Remova serviços descontinuados
5. Adicione novos serviços
6. Atualize notas de segurança

## 🛠️ Pré-requisitos

### Para uso completo do script de atualização:

- **AWS CLI** (opcional): Para verificar recursos AWS
  ```bash
  pip install awscli
  aws configure
  ```

- **gcloud CLI** (opcional): Para verificar recursos GCP
  ```bash
  # Instruções em: https://cloud.google.com/sdk/docs/install
  gcloud init
  ```

- **curl**: Para verificar serviços self-hosted (geralmente já instalado)

## 📞 Suporte

Para questões ou problemas:
1. Abra uma issue neste repositório
2. Entre em contato com o time de infraestrutura
3. Em emergências, use os contatos listados em `INVENTORY.md`

## 📝 Contribuindo

Para adicionar ou atualizar informações no inventário:

1. Edite o arquivo `INVENTORY.md`
2. Atualize os bookmarks em `bookmarks/cloud-infrastructure.html` se necessário
3. Execute `./scripts/update-inventory.sh` para validar
4. Commit e crie um PR com descrição clara das mudanças

## 📄 Licença

Este é um repositório interno. Não compartilhe informações sensíveis externamente.
