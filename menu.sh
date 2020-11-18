#!/bin/bash

while true;
do
	echo "a) Arquivos"
	echo "b) Diretórios"
	echo "c) Tudo"
	echo "d) Opção d"
	echo "q) Sair"
	read -p "Escolha uma opção: " opt
	case $opt in
		"a") echo "Arquivos" ;;
		"b") echo "Diretórios" ;;
		"c") echo "Tudo" ;;
		"d") echo "Opção 'd' escolhida" ;;
		"q") break ;;
	esac
done
