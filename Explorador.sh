#!/bin/bash

# Funções

function dir () {
	for i in $(ls);do
		if [ -d ${i} ]; then
			echo " <> ${i} "
		fi
	done
	
}

function arq () {
	cont=0
	for i in $(ls);do
		cont=$(( ${cont} + 1 ))
		if [ -f ${i} ];then
			echo " [${cont}] ${i} "
		fi
	done
}

function arqtxt () {
	cont=0
	for i in $(ls | grep ".txt");do
		cont=$(( ${cont} + 1 ))
		if [ -f ${i} ];then
			echo " [${cont}] ${i} "
		fi
	done
}

function arqsh () {
	cont=0
	for i in $(ls | grep ".sh");do
		cont=$(( ${cont} + 1 ))
		if [ -f ${i} ] ;then
			echo " [${cont}] ${i} "
		fi
	done
}

function permissoes () {
	echo " $(ls ${arq}) "
	
}

function tamanho () {
	du -hsm ${arq}
}

function caminhoArq () {
	echo "$(pwd)/${arq}"
}

function numLinhas () {
	cat ${arq} | wc -l
}

function executar () {
	./${arq}
}

# Settings

touch backupSettings.sh
echo -e "#!/bin/bash\nmkdir Backup\nmkdir ./Backup/$(date '+%d.%m.%y')" > backupSettings.sh
chmod u+x backupSettings.sh

# Cabeçalho

echo -e "\nEXPLORADOR DE ARQUIVOS - LINUX\nVersão 1.0.0\nUsuário corrente: $(whoami)\nData: $(date '+%d/%m/%y')\n"

while true; 
do
	echo -e "--> Menu\n"
	echo "a) Arquivos"
	echo "b) Diretórios"
	echo "c) Tudo"
	echo "d) Fazer Backup para outra máquina na rede"
	echo "e) Limpar tela"
	echo -e "q) Sair\n"
	read -p "Escolha uma opção: " opt

	if [ ${opt} ==  a ]; then	
		echo -e "\n--> Opção 'a' selecionada"
		echo -e  "Mostrando arquivos locais\n"
		arq

	elif [ ${opt} == b ];then
	       	echo -e "\n--> Opção 'b' selecionada"
		echo -e "Mostrando diretórios locais\n"
		dir 
	
	elif [ ${opt} == c ];then 
	       	echo -e "\n--> Opção 'c' selecionada"
		echo -e "Mostrando todos os arquivos e diretórios locais\n"
		ls -a | tr ' ' '\n'

	elif [ ${opt} == d ];then 
		echo -e "\n--> Opção 'd' selecionada"
		echo -e "\nBackup em rede\nCadastrando máquina de backup\nAperte q a qualquer momento para sair\n"
		read -p "Usuário da máquina: " user
		
		if [ ${user} == q ];then
			echo "Saindo do cadastro de backup"
		else
			read -p "Ip da máquina: " ip			
			echo -e "\nInstalando SSH para acesso"
			apt-get install openssh-server &>> /dev/null
			scp ./backupSettings.sh ${user}@${ip}:/home/projeto
			echo -e "\nTutorial:\n[1] Digite a senha do usuário\n[2] Use o comando ./backupSettngs.sh para executar o arquivo backupSettings.sh\n[3] Digite exit e aperte enter para sair da máquina\n[5] Ao sair aperte enter para continuar o backup.\n"
			ssh ${user}@${ip}
			echo -e "\nCopiando arquivos locais para máquina remota ${user}\n"
			data=$(date '+%d.%m.%y')
			scp ./* ${user}@${ip}:/home/${user}/Backup/${data} && echo -e "\nBackup concluído no caminho: /home/${user}/backup/${data}" || echo -e "\nAlgo deu errado, tente novamente!"
			
		fi
	elif [ ${opt} == e ];then
		clear

	elif [ ${opt} ==  q ];then
       		break
	fi
done
