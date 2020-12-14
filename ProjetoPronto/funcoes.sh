#!/bin/bash

# Funções

function user () {
	mkdir $(whoami)
	cd ./$(whoami)
}

function dir () {
	cont=0
	for i in $(ls);do
		if [ -d ${i} ]; then
			cont=$(( ${cont} + 1 ))
			echo " [${cont}] ${i} "
		fi
	done
	echo -e "\nTotal de dretórios: ${cont}\n"
}

function arq () {
	cont=0
	for i in $(ls);do
		if [ -f ${i} ];then
			cont=$(( ${cont} + 1 ))
			echo " [${cont}] ${i} "
		fi
	done
	echo -e "\nTotal de arquivos: ${cont}\n"
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
				busca=$(find /home -name $dir | tr ' ' '\n') 2>> /dev/null
				if [ -z $busca ] ;
				then
					echo -e "\nEste diretório não existe"
				fi
				echo -e "\nO diretório se encontra no: \n${busca}" 2>> /dev/null
				;;
			"a")
				echo -e "\n--> Opção 'a' selecionada"
			       	read -p "Digite o arquivo que deseja buscar: " arq
		       		busca=$(find /home -name $arq | tr ' ' '\n') 2>> /dev/null
		 		if [ -z $busca ] ;
				then
					echo -e "Este arquivo não existe"		
				fi
				echo -e "\nO arquivo se encontra no: \n${busca}" 2> /dev/null
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
	if [ -f ${arq} ];then
		while true; do
			echo -e "\n--> Submenu de Arquivos"
			echo -e "\na) Ler arquivo"
			echo "b) Editar com VIM"
			echo "c) Editar com NANO"
			echo "d) Apagar"
			echo "e) Copiar"
			echo "f) Mover"
			echo "g) Renomear"
			echo "h) Propriedades"
			echo "i) Criar novo arquivo"
			echo "j) Mudar permissões"
			echo "k) Ordenar"
			echo "l) Filtrar"
			echo -e "q) Sair\n"
			read -p "Escolha uma opção: " opt

			case ${opt} in
				"a")	
					echo -e "\nMostrando o arquivo ${arquivo}\n"
					read -p "Nome do arquivo: " arquivo
					echo -e "===== Começo do arquivo =====\n" 
					cat ${arquivo} 
					echo -e "\n===== Fim do Arquivo =====";;
				"b")	
					read -p "Nome do arquivo: " arquivo
					vim ${arquivo} ;;
				"c")
					read -p "Nome do arquivo: " arquivo
					nano ${arquivo} ;;
				"d")
					echo -e "\nApagando o arquivo ${arquivo}"
					read -p "Nome do arquivo: " arquivo
					rm ${arquivo}
					echo -e "\nArquivo ${arquivo} apagado" ;;
				"e")
					echo -e "\nCopiando o arquivo "
					read -p "Nome do arquivo: " arquivo
					read -p "Qual o caminho do destino: " dest
					cp ${arquivo} ${dest} ;;
				"f")
					echo -e "\nMovendo o arquivo"
					read -p "Nome do arquivo: " arquivo
					read -p "Qual o caminho do destino: " dest
					mv ${arquivo} ${dest} ;;
				"g")
					echo -e "\nRenomeando o arquivo"
					read -p "Nome do arquivo: " arquivo
					read -p "Novo nome: " name
					mv ${arquivo} ${name} 
					arquivo=${name} ;;
				"h")
					echo -e "\nPropriedades do arquivo"
					read -p "Nome do arquivo: " arquivo
					propriedades ;;
				"i")
					read -p "Nome do arquivo: " arquivo
					touch ${arquivo}
					echo -e "Arquivo criado:\n $(ls -l ${arquivo})" ;;
				"j") 
					echo -e "\nMudando permissões do arquivo"
					read -p "Nome do arquivo: " arquivo
					read -p "Digite as permissões em forma binária: " permi
					chmod ${permi} ${arquivo}
					echo -e "Permissões modificadas:\n $(ls -l ${arquivo})" ;;
				
				"k") subOrd ;;

				"l") Filter ;;

				"q")
					break
			esac

		done
	else
		echo "${arquivo} não é um arquivo"
	fi
}

function subDir () {
	while true; do
		
		caminhoOriginal=$((pwd))
		echo -e "\n--> Submenu de Diretórios"
		echo -e "\na) Entrar"
		echo "b) Apagar"
		echo "c) Criar Novo"
		echo "d) Digitar o caminho do diretório"
		echo -e "q) Sair\n"
		read -p "Escolha uma opção: " opt

		case ${opt} in

			"a") 
				echo -e "\nEntrar selecionado"
				read -p "Nome do diretório: " dir
				cd ${dir}
				menu ;;
			"b") 
				echo -e "\nApagar selecionado"
				read -p "Nome do diretório a ser apagado: " dir
				rm -rf ${dir} ;;
			"c") 
				echo -e "\nCriar Novo selecionado"
				read -p "Nome para o novo diretório: " dir
				mkdir ${dir}
				echo -e "Criado! Verifique na lista abaixo:\n"
				dir ;;

			"d") 
				read -p "Digite o caminho do diretório (ex: /home/user): " caminho
				cd ${caminho} 
				menu ;;

			"q")
			       	break ;;
		esac
	done
}


function subOrd () {
	while true; do
		echo -e "\nOrdenando os arquivos!\n"
		echo "a) Ordenar por grupo"
		echo "b) Ordenar por extensão"
		echo "q) Sair"
		read -p "Escolha uma opção: " opt

		case ${opt} in
			"a") 
				echo -e "\nOrdenando os arquivos por grupos! \n"
				echo -e "Grupo	Arquivo\n"
				ls -lp | grep -v / | awk 'NR>2{print $3"	"$NF}' | sort ;;

			"b") 
				echo -e "\nOrdenando por extensão! \n"
				cont=0
				for i in $(ls -X);do
					if [ -f ${i} ];then
						cont=$(( ${cont} + 1 ))
						echo " [${cont}] ${i} "
					fi
				done
				echo -e "\nTotal de arquivos: ${cont}\n" ;;

			"q") break

		esac
	done
}

function Filter () {
	while true; do
		echo -e "\nFiltrando os arquivos!\n"
		echo "a) Filtrar por extensão"
		echo "b) Filtrar por grupo"
		echo "q) Sair"
		read -p "Escolha uma opção: " opt

		case ${opt} in

			"a") 
				read -p "Digite a extensão que deseja filtrar (sem o ponto): " ext
				echo -e "\nArquivos .${ext}: \n "
				arq | grep .${ext} ;;

			"b") 
				read -p "Digite o grupo que deseja filtrar: " grp
				echo -e "\nArquivos pertencentes ai grupo ${grp}: \n"
				find $(pwd) -group ${grp} | awk -F '/' '{print $NF}' ;;

			"q") break ;;
		esac
	done
}


function menu () {
	while true; 
	do
		echo -e "\nEXPLORADOR DE ARQUIVOS - LINUX\nVersão 1.0.0\nUsuário corrente: $(whoami)\nData: $(date '+%d/%m/%y')\nDiretório atual: $(pwd)\n"
		echo -e "\n--> Menu\n"
		echo "a) Arquivos"
		echo "b) Diretórios"
		echo "c) Tudo"
		echo "d) Fazer Backup para outra máquina na rede"
		echo "e) Limpar tela"
		echo "f) Voltar para o diretório anterior"
		echo "g) Encerrar o programa"
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
			subDir	
	
		elif [ ${opt} == c ];then 
		       	echo -e "\n--> Opção 'c' selecionada"
			echo -e "Mostrando todos os arquivos e diretórios locais\n"
			ls -a | tr ' ' '\n'

		elif [ ${opt} == d ];then

			touch backupSettings.sh
			echo -e '#!/bin/bash\nmkdir Backup\nmkdir ./Backup/$(date '+%d.%m.%y')' > backupSettings.sh
			chmod u+x backupSettings.sh

			echo -e "\n--> Opção 'd' selecionada"
			echo -e "\nBackup em rede\nCadastrando máquina de backup\nAperte q a qualquer momento para sair\n"
			read -p "Usuário da máquina: " user
		
			if [ ${user} == q ];then
				echo "Saindo do cadastro de backup"
			else
				read -p "Ip da máquina: " ip			
				echo -e "\nInstalando SSH para acesso"
				apt-get install openssh-server &>> /dev/null
				
				echo -e "\nInstalando Zip e Unzip"
				apt-get install zip &>> /dev/null
				apr-get install unzip &>> /dev/null

				echo -e "\nCompactando arquivos\nLista de arquivos compactados:\n"

				zip bkp.zip *

				scp ./backupSettings.sh ${user}@${ip}:/home/${user}/
				
				#scp ./backupSettings.sh ${user}@${ip}:/home
				
				echo -e "\nTutorial:\n[1] Digite a senha do usuário\n[2] Use o comando ./backupSettings.sh para executar o arquivo backupSettings.sh (Apenas se este o for o primeiro backup)\n[3] Digite exit e aperte enter para sair da máquina\n[5] Ao sair redigite a senha do usuário para continuar o backup.\n"
				
				ssh ${user}@${ip}
				
				echo -e "\nCopiando arquivos locais para máquina remota ${user}\n"
				data=$(date '+%d.%m.%y')
				#scp ./* ${user}@${ip}:/home/${user}/Backup/${data} && echo -e "\nBackup concluído no caminho: /home/${user}/backup/${data}" || echo -e "\nAlgo deu errado, tente novamente!"
				scp ./bkp.zip ${user}@${ip}:/home/${user}/Backup/${data} && echo -e "\nBackup concluído no caminho: /home/${user}/backup/${data}" || echo -e "\nAlgo deu errado, tente novamente!"
			
			fi
	
		elif [ ${opt} == p ];then
			pesquisa
		elif [ ${opt} == f ]; then
			echo -e "\nOpção 'f' selecionada"
			echo -e "Voltando para o diretório anterior\n"
			cd ../ && menu

		elif [ ${opt} == e ];then
			clear
			
		elif [ ${opt} == g ]; then
			exit 0
		

		elif [ ${opt} ==  q ];then
       			break
		fi
	done
}
