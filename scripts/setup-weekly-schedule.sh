#!/bin/bash

# Script de agendamento semanal do inventário
# Este script configura um cron job para executar a atualização semanal

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPDATE_SCRIPT="$SCRIPT_DIR/update-inventory.sh"

echo "========================================="
echo "Configuração de Agendamento Semanal"
echo "========================================="
echo ""

# Verificar se o script de atualização existe
if [ ! -f "$UPDATE_SCRIPT" ]; then
    echo "❌ Erro: Script de atualização não encontrado em $UPDATE_SCRIPT"
    exit 1
fi

# Tornar o script executável
chmod +x "$UPDATE_SCRIPT"

echo "📅 Configurando agendamento semanal..."
echo ""
echo "Este script irá adicionar um cron job para executar toda segunda-feira às 9:00"
echo ""
echo "Comando cron que será adicionado:"
echo "0 9 * * 1 $UPDATE_SCRIPT >> /var/log/inventory-update.log 2>&1"
echo ""

read -p "Deseja continuar? (s/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Ss]$ ]]; then
    # Verificar se já existe entrada no crontab
    if crontab -l 2>/dev/null | grep -q "$UPDATE_SCRIPT"; then
        echo "⚠️  Agendamento já existe no crontab"
        echo ""
        crontab -l | grep "$UPDATE_SCRIPT"
        echo ""
        read -p "Deseja substituir? (s/n) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Ss]$ ]]; then
            echo "❌ Operação cancelada"
            exit 0
        fi
        # Remover entrada antiga
        crontab -l 2>/dev/null | grep -v "$UPDATE_SCRIPT" | crontab -
    fi
    
    # Adicionar ao crontab
    (crontab -l 2>/dev/null; echo "# Atualização semanal do inventário cloud - Toda segunda às 9:00"; echo "0 9 * * 1 $UPDATE_SCRIPT >> /var/log/inventory-update.log 2>&1") | crontab -
    
    echo "✅ Cron job adicionado com sucesso!"
    echo ""
    echo "Para verificar, execute: crontab -l"
    echo "Para remover, execute: crontab -e e delete a linha correspondente"
else
    echo "❌ Operação cancelada"
    echo ""
    echo "💡 Você pode executar o script manualmente quando necessário:"
    echo "   $UPDATE_SCRIPT"
fi

echo ""
echo "========================================="
echo "Alternativa: Execução Manual"
echo "========================================="
echo ""
echo "Se preferir executar manualmente quando houver grandes mudanças:"
echo "   cd $SCRIPT_DIR"
echo "   ./update-inventory.sh"
echo ""
