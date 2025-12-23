#!/bin/bash

# Script de atualização do inventário de infraestrutura cloud
# Autor: Sistema de Inventário
# Data: 2025-12-23

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INVENTORY_FILE="$PROJECT_DIR/INVENTORY.md"
BACKUP_DIR="$PROJECT_DIR/backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

echo "========================================="
echo "Atualização do Inventário Cloud"
echo "========================================="
echo "Data: $(date)"
echo ""

# Criar diretório de backup se não existir
mkdir -p "$BACKUP_DIR"

# Backup do inventário atual
if [ -f "$INVENTORY_FILE" ]; then
    echo "📋 Criando backup do inventário atual..."
    cp "$INVENTORY_FILE" "$BACKUP_DIR/INVENTORY_${TIMESTAMP}.md"
    echo "   ✅ Backup salvo em: $BACKUP_DIR/INVENTORY_${TIMESTAMP}.md"
fi

echo ""
echo "🔍 Verificando serviços AWS..."
echo "   (Requer AWS CLI configurado)"

# Verificar se AWS CLI está instalado
if command -v aws &> /dev/null; then
    echo "   ✅ AWS CLI encontrado"
    
    # Verificar configuração AWS
    if aws sts get-caller-identity &> /dev/null; then
        echo "   ✅ AWS CLI configurado corretamente"
        echo "   👤 Conta: $(aws sts get-caller-identity --query Account --output text)"
        
        # Listar recursos AWS (exemplos)
        echo ""
        echo "   📊 Resumo de recursos AWS:"
        
        # Lambda functions
        if aws lambda list-functions &> /dev/null; then
            LAMBDA_COUNT=$(aws lambda list-functions --query 'length(Functions)' --output text)
            echo "   - Lambda Functions: $LAMBDA_COUNT"
        fi
        
        # S3 buckets
        if aws s3 ls &> /dev/null; then
            S3_COUNT=$(aws s3 ls | wc -l)
            echo "   - S3 Buckets: $S3_COUNT"
        fi
        
        # RDS instances
        if aws rds describe-db-instances &> /dev/null; then
            RDS_COUNT=$(aws rds describe-db-instances --query 'length(DBInstances)' --output text)
            echo "   - RDS Instances: $RDS_COUNT"
        fi
    else
        echo "   ⚠️  AWS CLI não configurado. Execute: aws configure"
    fi
else
    echo "   ⚠️  AWS CLI não instalado"
    echo "   💡 Instale com: pip install awscli"
fi

echo ""
echo "🔍 Verificando serviços GCP..."
echo "   (Requer gcloud CLI configurado)"

# Verificar se gcloud CLI está instalado
if command -v gcloud &> /dev/null; then
    echo "   ✅ gcloud CLI encontrado"
    
    # Verificar configuração GCP
    if gcloud config get-value project &> /dev/null; then
        PROJECT=$(gcloud config get-value project 2>/dev/null)
        echo "   ✅ gcloud CLI configurado"
        echo "   📁 Projeto: $PROJECT"
        
        # Listar recursos GCP (exemplos)
        echo ""
        echo "   📊 Resumo de recursos GCP:"
        
        # Compute instances
        if gcloud compute instances list --format="value(name)" &> /dev/null; then
            COMPUTE_COUNT=$(gcloud compute instances list --format="value(name)" 2>/dev/null | wc -l)
            echo "   - Compute Instances: $COMPUTE_COUNT"
        fi
        
        # Storage buckets
        if gsutil ls &> /dev/null; then
            BUCKET_COUNT=$(gsutil ls 2>/dev/null | wc -l)
            echo "   - Storage Buckets: $BUCKET_COUNT"
        fi
    else
        echo "   ⚠️  gcloud CLI não configurado. Execute: gcloud init"
    fi
else
    echo "   ⚠️  gcloud CLI não instalado"
    echo "   💡 Instale de: https://cloud.google.com/sdk/docs/install"
fi

echo ""
echo "🔍 Verificando serviços self-hosted..."

# Verificar Nifi (porta 8443 HTTPS ou 8080 com path /nifi)
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8443/nifi 2>/dev/null | grep -q "200\|302" || \
   curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/nifi 2>/dev/null | grep -q "200\|302"; then
    echo "   ✅ Apache Nifi: Ativo"
else
    echo "   ⚠️  Apache Nifi: Não detectado"
fi

# Verificar Airflow (porta 8080 padrão)
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health 2>/dev/null | grep -q "200\|302"; then
    echo "   ✅ Apache Airflow: Ativo"
else
    echo "   ⚠️  Apache Airflow: Não detectado"
fi

# Verificar Prefect
if curl -s -o /dev/null -w "%{http_code}" http://localhost:4200 2>/dev/null | grep -q "200\|302"; then
    echo "   ✅ Prefect: Ativo"
else
    echo "   ⚠️  Prefect: Não detectado"
fi

# Verificar Streamlit
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8501 2>/dev/null | grep -q "200\|302"; then
    echo "   ✅ Streamlit: Ativo"
else
    echo "   ⚠️  Streamlit: Não detectado"
fi

echo ""
echo "📝 Atualizando timestamp do inventário..."

# Atualizar data no arquivo de inventário
CURRENT_DATE=$(date +%Y-%m-%d)
if sed -i "s/^\*\*Última atualização:\*\* [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}$/\*\*Última atualização:\*\* $CURRENT_DATE/" "$INVENTORY_FILE"; then
    echo "   ✅ Timestamp atualizado para $CURRENT_DATE"
else
    echo "   ⚠️  Não foi possível atualizar o timestamp automaticamente"
fi

echo ""
echo "========================================="
echo "✅ Atualização concluída!"
echo "========================================="
echo ""
echo "📌 Próximos passos:"
echo "   1. Revise o arquivo $INVENTORY_FILE"
echo "   2. Atualize manualmente informações específicas"
echo "   3. Commit as alterações: git add . && git commit -m 'Update inventory'"
echo ""
echo "💾 Backup anterior disponível em:"
echo "   $BACKUP_DIR/INVENTORY_${TIMESTAMP}.md"
echo ""
