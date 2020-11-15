#!/bin/bash

while true;
do
	echo "a) Arquios"
	echo "b) Diretórios"
	echo "c) Tudo"
	echo "d) Opção d"
	echo "q) Sair"
	read -p "Escolha uma opção: " opt
	
	if [ $((  $opt ==  "a" )) ]; then 
		echo "Opção 'a' selecionada"
	fi

	if [ $(( $opt == "b")) ];then
	       	echo "Opção 'b' escolhida"
	if
	
	if [ $(( $opt == "c")) ];then 
	       	echo "Opção 'c' escolhida"
	fi

	fi [ $(( $opt == "d" )) ];then 
		echo "Opção 'd' escolhida"
	if

	if [ $(( $opt ==  "q" )) ];then
       		break
	fi
