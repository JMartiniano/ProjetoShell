#!/bin/bash

function dir () {
	for i in $(ls);do
		if [ -d ${i} ]; then
			echo " <> ${i} "
		fi
	done
	
}

function arq () {
	for i in $(ls);do
		if [ -f ${i}  ];then
			echo " <> ${i} "
		fi
	done
}

function arqtxt () {
	for i in $(ls | grep ".txt");do
		if [ -f ${i} ];then
			echo " <> ${i} "
		fi
	done
}

function arqsh () {
	for i in $(ls | grep ".sh");do
		if [ -f ${i} ] ;then
			echo " <> ${i} "
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

function arqexe () {
	ls -F | grep -E '[*]'
}

function atualdir () {
	pwd
}
	 
function prev_dir () {
	cd ../
	ls
}

function enter_dir () {
	dir
	read -p "Digite o nome do diretório que deseja entrar" dir
	cd ./$dir
	ls
}

function rm_dir_not_empty () {
	read -p "Digite o diretório que deseja remover: " dir
	rm -rf $dir
}

function make_dir () {
	read -p "Digite o nome do diretório que deseja criar: " dir
	mkdir $dir
}



function pesquisa () {
	while true;
	do
		echo "a) Diretório"
		echo "b) Arquivo"
		echo "q) Sair"
		read -p "Escolha uma opção: " opt
		case $opt in
			"a") 
				read -p "Digite o diretório que deseja buscar: " dir
				busca=$(find /home -name $dir)
				if [ -z $busca ];
				then
					echo "Este diretório não existe"
				fi 2> /dev/null  
				echo "O diretório se encontra no: ${busca}"
				;;
			"b")
			       read -p "Digite o arquivo que deseja buscar: " arq
		       		busca=$(find /home -name $arq)
		 		if [ -z $busca ];
				then
					echo "Este arquivo não existe"		
				fi 2> /dev/null
				echo "O arquivo se encontra no: ${busca}"
				;;
			"q") break ;;
		esac
	done
}

function clear_terminal () {
	clear
}


