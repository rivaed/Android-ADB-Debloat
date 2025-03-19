# !/bin/bash
# Android ADB Debloat Script - Versão Profissional
# Script para remover bloatware via ADB em dispositivos Android.
# Requisitos:
#   - ADB instalado e configurado no PATH.
#   - Dispositivo Android conectado com depuração USB ativada.

# Função para encerrar o script com mensagem de erro
function error_exit {
    echo "Erro: $1" >&2
    exit 1
}

# Verifica se o ADB está disponível
if ! command -v adb &> /dev/null; then
    error_exit "ADB não encontrado. Instale o ADB e tente novamente."
fi

# Verifica se há dispositivo conectado
device_count=$(adb devices | sed '1d' | grep -w "device" | wc -l)
if [[ $device_count -eq 0 ]]; then
    error_exit "Nenhum dispositivo Android conectado. Conecte um dispositivo e ative a depuração USB."
fi

echo "Dispositivo(s) detectado(s):"
adb devices

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
    result=$(adb shell pm uninstall --user 0 "$pkg" 2>&1)
    if echo "$result" | grep -qi "Success"; then
        echo "Pacote '$pkg' removido com sucesso."
    else
        echo "Falha ao remover '$pkg'. Mensagem: $result"
    fi
done

echo "Processo de Debloat concluído. Reinicie o dispositivo se necessário."
