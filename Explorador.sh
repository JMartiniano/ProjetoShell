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
	if [ -f ${arq} ];then
		while true; do
			echo -e "\n--> Submenu de Arquivos"
			echo -e "\na) Ler arquivo"
			echo "b) Editar com VIM"
			echo "c) Editar com NANO"
			echo "d) Apagar"
			echo "e) Copiar"
			echo "d) Mover"
			echo "f) Renomear"
			echo "g) Propriedades"
			echo "h) Criar novo arquivo"
			echo "i) Mudar permissões"
			echo -e "q) Sair\n"
			read -p "Escolha uma opção: " opt

			case ${opt} in
				"a")	
					echo -e "\nMostrando o arquivo ${arq}\n"
					read -p "Nome do arquivo: " arq
					echo -e "===== Começo do arquivo =====\n" 
					cat ${arq} 
					echo -e "\n===== Fim do Arquivo =====";;
				"b")	
					read -p "Nome do arquivo: " arq
					vim ${arq} ;;
				"c")
					read -p "Nome do arquivo: " arq
					nano ${arq} ;;
				"d")
					echo -e "\nApagando o arquivo ${arq}"
					read -p "Nome do arquivo: " arq
					rm ${arq}
					echo -e "\nArquivo ${arq} apagado" ;;
				"e")
					echo -e "\nCopiando o arquivo "
					read -p "Nome do arquivo: " arq
					read -p "Qual o caminho do destino: " dest
					cp ${arq} ${dest} ;;
				"d")
					echo -e "\nMovendo o arquivo"
					read -p "Nome do arquivo: " arq
					read -p "Qual o caminho do destino: " dest
					mv ${arq} ${dest} ;;
				"f")
					echo -e "\nRenomeando o arquivo"
					read -p "Nome do arquivo: " arq
					read -p "Novo nome: " name
					mv ${arq} ${name} 
					arq=${name} ;;
				"g")
					echo -e "\nPropriedades do arquivo"
					read -p "Nome do arquivo: " arq
					propriedades ;;
				"h")
					read -p "Nome do arquivo: " arq
					touch ${arq}
					echo -e "Arquivo criado:\n $(ls -l ${arq})" ;;
				"i") 
					echo -e "\nMudando permissões do arquivo"
					read -p "Nome do arquivo: " arq
					read -p "Digite as permissões em forma binária: " permi
					chmod ${permi} ${arq}
					echo -e "Permissões modificadas:\n $(ls -l ${arq})" ;;
					
				"q")
					break
			esac

		done
	else
		echo "${arq} não é um arquivo"
	fi
}

function subDir () {
	while true; do
		
		caminhoOriginal=$((pwd))
		echo -e "\n--> Submenu de Diretórios"
		echo -e "\na) Entrar"
		echo "b) Apagar"
		echo "c) Criar Novo"
		echo "d) Pesquisa"
		echo -e "q) Sair\n"
		read -p "Escolha uma opção: " opt

		case ${opt} in

			"a") 
				echo -e "\nEntrar selecionado"
				read -p "Nome do diretório: " dir
				cd ${dir}
				echo -e "\nVocê está no diretório ${dir}.\nCaminho: $(pwd)"
				while true; do

					echo -e "\n--> Submenu do diretório ${dir}"
					echo -e "\na) Criar novo arquivo"
					echo "b) Criar novo dirétório"
					echo "c) Listar arquivos"
					echo "d) Listar diretórios"
					echo "e) Listar tudo" 
					echo "f) Apagar arquivo"
					echo "g) Apagar diretório"
					echo "h) Apagar tudo"
					echo "i) Pesquisar"
					echo -e "q) Sair\n"
					read -p "Escolha uma opção: " opt

					case ${opt} in

						"b")
							echo -e "\nCriar novo diretório"
							read -p "Nome para o novo diretório: " name
							mkdir ${name} ;;
						"a")
							echo -e "\nCriar novo arquivo"
							read -p "Name para o novo arquivo: " name
							read -p "Formato do novo arquivo (sem o ponto): " formato
						       	touch ${name}.${formato} ;;
						"c")
							echo -e "\nListar arquivos"
							arq ;;
						"d")
							echo -e"\nListar diretórios"
							dir ;;

						"e")
							echo -e"\nListar tudo"
							ls -l ;;

						"f") 
							echo -e "\nApagar arquivo"
							read -p "Nome do arquivo a ser apagado: " arq
							rm ${arq} ;;

						"g")
							echo -e "\nApagar diretório"
							read -p "Nome do diretório a ser apagado: " dir
							rm -rf ${dir} ;;

						"h")
							echo -e "\nApagando tudo"
							read -p "Digite S para apagar tudo e N para cancelar" opt
							if [ ${opt} == "S" ];then
								rm *
							else
								break
							fi ;;
						"i")
							echo -e "\nPesquisa"
							pesquisa ;;
						"q")
							read -p "Digite o caminho do dirétório inicial: " caminho
							cd ${caminho}
							dir
							break
					esac
				done ;;
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
				echo -e "\nPesquisa"
				pesquisa ;;
			"q")
			       	break ;;
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
		subDir	
	
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
