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
	echo " $(ls -l ${arq}) "
	
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

function pesquisa () {
	while true;
	do
		echo -e "\n--> Submenu de Pesquisa"
		echo -e "\na) Arquivo"
		echo "b) Diretório"
		echo -e "q) Sair\n"
		read -p "Escolha uma opção: " opt

		case $opt in
			"b") 
				echo -e "\n--> Opção 'b' selecionada"
				read -p "Digite o diretório que deseja buscar: " dir
				busca=$(find / -name $dir | tr ' ' '\n' 2>> /dev/null)
				if [ -z $busca ];
				then
					echo -e "\nEste diretório não existe"
				fi 2> /dev/null  
				echo -e "\nO diretório se encontra no: \n${busca}"
				;;
			"a")
				echo -e "\n--> Opção 'a' selecionada"
			       	read -p "Digite o arquivo que deseja buscar: " arq
		       		busca=$(find / -name $arq | tr ' ' '\n')
		 		if [ -z $busca ];
				then
					echo -e "Este arquivo não existe"		
				fi 2> /dev/null
				echo -e "\nO arquivo se encontra no: \n${busca}"
				;;
			"q") break ;;
		esac
	done
}

function propriedades () {
	echo -e "\nPropriedades\n"
	echo "Tamanho do arquivo: $(du -hsm ${arq})"
	echo "Quantidade de linhas: $(cat ${arq} | wc -l)"
	echo "Permissões: "
	permissoes
	
}


function subArq () {
	read -p "Nome do arquivo: " arq
	while true; do
		echo -e "\n"
		# read -p "Nome do arquivo: " arq
		echo -e "\n--> Submenu de Arquivos"
		echo -e "\na) Ler arquivo"
		echo "b) Editar o arquivo com VIM"
		echo "c) Editar o arquivo com NANO"
		echo "d) Deletar o arquivo"
		echo "e) Copiar o arquivo"
		echo "d) Mover o arquivo"
		echo "f) Renomear o arquivo"
		echo "g) Propriedades do arquivo"
		echo "q) Sair"
		read -p "Escolha uma opção: " opt

		case ${opt} in
			"a")
				echo -e "\nMostrando o arquivo ${arq}\n"
				cat ${arq} ;;
			"b")
				vim ${arq} ;;
			"c")
				nano ${arq} ;;
			"d")
				echo -e "\nRemovendo o arquivo ${arq}"
				rm ${arq}
				echo -e "\nArquivo apagado: \n ls" ;;
			"e")
				echo -e "\nCopiando o arquivo "
				read -p "Qual o caminho do destino: " dest
				cp ${arq} ${dest} ;;
			"d")
				echo -e "\nMovendo o arquivo"
				read -p "Qual o caminho do destino: " dest
				mv ${arq} ${dest} ;;
			"f")
				echo -e "\nRenomeando o arquivo"
				read -p "Novo nome: " name
				mv ${arq} ${name} ;;
			"g")
				echo -e "\nPropriedades do arquivo"
				propriedades ;;
			"q")
				break
		esac
	done

}

# Settings

touch backupSettings.sh
echo -e "#!/bin/bash\nmkdir Backup\nmkdir ./Backup/$(date '+%d.%m.%y')" > backupSettings.sh
chmod u+x backupSettings.sh

# Cabeçalho

echo -e "\nEXPLORADOR DE ARQUIVOS - LINUX\nVersão 1.0.0\nUsuário corrente: $(whoami)\nData: $(date '+%d/%m/%y')\n"

while true; 
do
	echo -e "\n--> Menu\n"
	echo "a) Arquivos"
	echo "b) Diretórios"
	echo "c) Tudo"
	echo "d) Fazer Backup para outra máquina na rede"
	echo "e) Limpar tela"
	echo "p) Pesquisar"
	echo -e "q) Sair\n"
	read -p "Escolha uma opção: " opt

	if [ ${opt} ==  a ]; then	
		echo -e "\n--> Opção 'a' selecionada"
		echo -e  "Mostrando arquivos locais\n"
		arq
		subArq

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
	
	elif [ ${opt} == p ];then
		pesquisa

	elif [ ${opt} == e ];then
		clear

	elif [ ${opt} ==  q ];then
       		break
	fi
done
