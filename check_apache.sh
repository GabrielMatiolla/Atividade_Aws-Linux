#!/bin/bash

# Esse comando define a variável de ambiente TZ para o fuso horário de "America/Sao_Paulo".
# Isso garante que as informações de data e hora geradas posteriormente sejam baseadas   nesse fuso horário.
export TZ=America/Sao_Paulo

# Essa linha atribui à variável DATE o valor da data e hora atual formatada de acordo com o padrão especificado.
# No exemplo, a data e hora são formatadas como "dia-mês-ano hora:minuto:segundo".
DATE=$(date '+%d-%m-%Y %H:%M:%S')

# O bloco if verifica se o serviço httpd (Apache) está ativo usando o comando systemctl is-active --quiet httpd. 
# Se o serviço estiver ativo, a condição será verdadeira.

# Se o serviço httpd estiver ativo, as seguintes ações serão realizadas:
# STATUS="Online": A variável STATUS recebe o valor "online".
# MESSAGE="O apache está online.": A variável MESSAGE recebe uma mensagem personalizada informando que o apache está online.
# FILENAME="apache_online.txt": A variável FILENAME recebe o nome do arquivo de saída que será usado para armazenar o resultado da validação online.
if systemctl is-active --quiet httpd; then
	STATUS="Online"
	MESSAGE="O apache está online."
	FILENAME="apache_online.txt"
else
# Caso o serviço httpd não esteja ativo, as ações seguintes serão realizadas:
# STATUS="Offline": A variável STATUS recebe o valor "offline".
# MESSAGE="O apache está offline.": A variável MESSAGE recebe uma mensagem personalizada informando que o apache está offline.
# FILENAME="apache_offline.txt": A variável FILENAME recebe o nome do arquivo de saída que será usado para armazenar o resultado da validação offline.
	STATUS="Offline"
	MESSAGE="O apache está offline."
	FILENAME="apache_offline.txt"
fi
# echo "$DATE httpd $STATUS - $MESSAGE" | sudo tee -a /mnt/nfs/$FILENAME: Essa linha combina as variáveis DATE, STATUS e MESSAGE
# para criar uma linha de texto contendo a data, o serviço (httpd), o status e a mensagem personalizada. 
# O comando echo exibe essa linha de texto no terminal. Em seguida, o comando tee -a é usado para redirecionar a saída para um arquivo,
# adicionando-a ao final do arquivo especificado. O comando sudo é usado para executar o comando tee com privilégios de superusuário.
# O caminho /mnt/nfs/$FILENAME representa o diretório NFS no qual o arquivo de saída será armazenado. 
# O nome do arquivo é determinado com base no valor da variável FILENAME definida anteriormente.
echo "$DATE httpd $STATUS - $MESSAGE" | sudo tee -a /mnt/nfs/$FILENAME
