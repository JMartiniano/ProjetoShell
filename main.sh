#!/bin/bash

while true;
do
	echo "a) Opção a"
	echo "b) Opção b"
	echo "c) Opção c"
	echo "d) Opção d"
	echo "q) Sair"
	read -p "Escolha uma opção: " opt
	
	case $opt in
		"a") echo "Opção 'a' escolhida" ;;
		"b") echo "Opção 'b' escolhida" ;;
		"c") echo "Opção 'c' escolhida" ;;
		"d") echo "Opção 'd' escolhida" ;;
		"q") break ;;
	esac
done
