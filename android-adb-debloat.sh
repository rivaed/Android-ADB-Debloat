#!/bin/bash
# Android ADB Debloat
# Script para listar e remover bloatware via ADB

# Verifica se o ADB está disponível
if ! command -v adb &> /dev/null; then
    echo "ADB não encontrado. Instale o ADB e tente novamente."
    exit 1
fi

echo "Listando pacotes instalados no dispositivo Android..."
adb shell pm list packages

# Array com os pacotes que serão removidos
packages=(
    "com.exemplo.bloat1"
    "com.exemplo.bloat2"
)

echo "Iniciando processo de remoção..."
for pkg in "${packages[@]}"; do
    echo "Removendo: $pkg"
    adb shell pm uninstall --user 0 "$pkg"
done

echo "Processo de Debloat concluído."
