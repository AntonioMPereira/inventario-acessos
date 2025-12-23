# Inventário de Infraestrutura Cloud

Este documento mantém o inventário completo dos recursos e acessos de infraestrutura cloud (AWS e GCP).

**Última atualização:** 2025-12-23

---

## 📋 Índice

- [AWS Services](#aws-services)
- [GCP Services](#gcp-services)
- [Self-Hosted Services](#self-hosted-services)
- [Third-Party Services](#third-party-services)
- [Automação e CI/CD](#automação-e-cicd)

---

## AWS Services

### AWS Account Principal
- **URL:** https://console.aws.amazon.com/
- **Tipo de Acesso:** Console Web / CLI / API
- **Credenciais:** IAM Users / SSO
- **MFA:** ✅ Habilitado
- **Região Principal:** us-east-1

### Amplify
- **URL:** https://console.aws.amazon.com/amplify/
- **Descrição:** Hosting e deployment de aplicações frontend
- **Tipo de Acesso:** Console Web / CLI
- **Credenciais:** IAM via Console
- **MFA:** ✅ Habilitado
- **Projetos:**
  - Frontend principal
  - Aplicações serverless

### Databases (AWS)
- **RDS**
  - **URL:** https://console.aws.amazon.com/rds/
  - **Tipo de Acesso:** Console Web / CLI
  - **Credenciais:** IAM + Database credentials
  - **MFA:** ✅ Habilitado
  - **Instâncias:** [Listar instâncias específicas]

- **DynamoDB**
  - **URL:** https://console.aws.amazon.com/dynamodb/
  - **Tipo de Acesso:** Console Web / API
  - **Credenciais:** IAM
  - **MFA:** ✅ Habilitado
  - **Tabelas:** [Listar tabelas específicas]

### Lambda / Serverless
- **URL:** https://console.aws.amazon.com/lambda/
- **Descrição:** Salesforce serverless functions
- **Tipo de Acesso:** Console Web / CLI
- **Credenciais:** IAM
- **MFA:** ✅ Habilitado
- **Funções principais:**
  - Salesforce integrations
  - checkout-events processors
  - automation triggers

---

## GCP Services

### GCP Account Principal
- **URL:** https://console.cloud.google.com/
- **Tipo de Acesso:** Console Web / CLI / API
- **Credenciais:** Google Account / Service Accounts
- **MFA:** ✅ Habilitado
- **Projeto Principal:** [Nome do projeto]

### Compute Engine / GKE
- **URL:** https://console.cloud.google.com/compute/
- **Descrição:** VMs e clusters Kubernetes
- **Tipo de Acesso:** Console Web / gcloud CLI
- **Credenciais:** Google Account / Service Accounts
- **MFA:** ✅ Habilitado
- **Clusters/VMs:**
  - [Listar recursos específicos]

### Cloud Storage
- **URL:** https://console.cloud.google.com/storage/
- **Tipo de Acesso:** Console Web / gsutil / API
- **Credenciais:** Service Accounts
- **MFA:** ✅ Habilitado
- **Buckets principais:** [Listar buckets]

---

## Self-Hosted Services

### Apache Nifi
- **URL:** [URL do servidor Nifi]
- **Descrição:** Data flow automation
- **Tipo de Acesso:** Web UI
- **Credenciais:** User/Password
- **MFA:** ⚠️ Verificar
- **Porta:** 8080 (padrão)
- **Host:** [Hostname/IP]

### Apache AirFlow
- **URL:** [URL do servidor Airflow]
- **Descrição:** Workflow orchestration
- **Tipo de Acesso:** Web UI / API
- **Credenciais:** User/Password
- **MFA:** ⚠️ Verificar
- **Porta:** 8080 (padrão)
- **Host:** [Hostname/IP]
- **DAGs principais:** [Listar DAGs]

### Prefect
- **URL:** [URL do servidor Prefect]
- **Descrição:** Modern workflow orchestration
- **Tipo de Acesso:** Web UI / API
- **Credenciais:** API Key
- **MFA:** ⚠️ Verificar
- **Host:** [Hostname/IP]
- **Flows principais:** [Listar flows]

### DBT (Data Build Tool)
- **URL:** [URL se aplicável]
- **Descrição:** Data transformation tool
- **Tipo de Acesso:** CLI / Git
- **Credenciais:** Database credentials
- **MFA:** N/A
- **Repositório:** [GitHub repo URL]
- **Profiles:** [Listar profiles]

### Streamlit
- **URL:** [URL das aplicações Streamlit]
- **Descrição:** Data apps e dashboards
- **Tipo de Acesso:** Web UI
- **Credenciais:** [Autenticação configurada]
- **MFA:** ⚠️ Verificar
- **Apps:**
  - [Listar aplicações]

### Agentes
- **URL:** [URL do sistema de agentes]
- **Descrição:** Sistema de agentes automatizados
- **Tipo de Acesso:** API / Web UI
- **Credenciais:** API Keys
- **MFA:** ⚠️ Verificar
- **Agentes ativos:** [Listar agentes]

### Marketplace
- **URL:** [URL do marketplace]
- **Descrição:** Marketplace interno
- **Tipo de Acesso:** Web UI / API
- **Credenciais:** OAuth / API Keys
- **MFA:** ⚠️ Verificar

### Backend v2
- **URL:** [URL do backend v2]
- **Descrição:** Backend principal da aplicação
- **Tipo de Acesso:** API
- **Credenciais:** API Keys / JWT
- **MFA:** N/A (API)
- **Endpoints:** [Listar endpoints principais]

---

## Third-Party Services

### GitHub
- **URL:** https://github.com/
- **Organização:** [Nome da organização]
- **Tipo de Acesso:** Web / Git / API
- **Credenciais:** OAuth / Personal Access Tokens
- **MFA:** ✅ Habilitado
- **Repositórios principais:**
  - femps
  - automation
  - checkout-events
  - [Outros repositórios]

### Salesforce
- **URL:** https://login.salesforce.com/
- **Descrição:** CRM e automações
- **Tipo de Acesso:** Web / API
- **Credenciais:** User/Password + Security Token
- **MFA:** ✅ Habilitado
- **Integrações:**
  - Serverless functions (AWS Lambda)
  - API integrations

---

## Automação e CI/CD

### Terraform
- **URL:** N/A (ferramenta CLI)
- **Descrição:** Infrastructure as Code
- **Tipo de Acesso:** CLI / Git
- **Credenciais:** AWS/GCP credentials
- **MFA:** Herda do provider
- **Repositórios:**
  - terraform/seed
  - [Outros módulos]
- **Workspaces:** [Listar workspaces]

### Pipelines
- **Descrição:** CI/CD pipelines
- **Plataformas:**
  - GitHub Actions
  - [Outras plataformas]
- **Repositórios com pipelines:**
  - [Listar repositórios]

### Bitrise
- **URL:** https://app.bitrise.io/
- **Descrição:** Mobile CI/CD
- **Tipo de Acesso:** Web UI / API
- **Credenciais:** OAuth (GitHub)
- **MFA:** ✅ Habilitado
- **Apps:**
  - [Listar aplicações mobile]

---

## 🔐 Notas de Segurança

1. **MFA obrigatório** para todos os acessos de console/web quando disponível
2. **Rotação de credenciais** deve ser feita a cada 90 dias
3. **API Keys e tokens** devem ser armazenados em gerenciador de secrets
4. **Least privilege principle** deve ser aplicado em todos os acessos
5. **Auditoria de acessos** deve ser revisada mensalmente

---

## 📝 Processo de Atualização

Este inventário deve ser atualizado:
- **Semanalmente:** Verificação de mudanças menores
- **Imediatamente:** Quando houver grandes mudanças (novos serviços, migrações, etc.)
- **Mensalmente:** Revisão completa e validação de todos os itens

Para atualizar o inventário:
1. Execute o script `scripts/update-inventory.sh`
2. Revise as mudanças detectadas
3. Atualize manualmente informações que não podem ser automatizadas
4. Commit e push das alterações

---

## 📞 Contatos

- **Responsável pelo inventário:** [Nome]
- **Time de infraestrutura:** [Contato]
- **Emergências:** [Contato de emergência]
