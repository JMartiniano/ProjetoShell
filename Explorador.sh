#!/bin/bash

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

while true; 
do
	echo -e "\n"
	echo "a) Arquios"
	echo "b) Diretórios"
	echo "c) Tudo"
	echo "d) Fazer Backup para outra máquina na rede"
	echo "e) Limpar tela"
	echo "q) Sair"
	read -p "Escolha uma opção: " opt

	if [ ${opt} ==  a ]; then	
		echo -e "\nOpção 'a' selecionada"
		echo -e  "Mostrando arquivos locais\n"
		arq

	elif [ ${opt} == b ];then
	       	echo -e "\nOpção 'b' escolhida"
		echo -e "Mostrando diretórios locais\n"
		dir 
	
	elif [ ${opt} == c ];then 
	       	echo -e "\nOpção 'c' escolhida"
		echo -e "Mostrando todos os arquivos e diretórios locais\n"
		ls -a | tr ' ' '\n'

	elif [ ${opt} == d ];then 
		echo -e "\nOpção 'd' escolhida"
		echo -e "Backup em rede\nCadastrando máquina de backup\nAperte q a qualquer momento para sair"
		read -p "Usuário da máquina: " user
		
		if [ ${user} == q ];then
			echo "Saindo do cadastro de backup"
		else
			read -p "Ip da máquina: " ip
			echo -e "Instalando SSH para acesso"
			apt-get install openssh-server
			echo -e "Acessando máquina de backup"
			ssh ${user}@${ip}
		fi
	elif [ ${opt} == e ];then
		clear

	elif [ ${opt} ==  q ];then
       		break
	fi
done
