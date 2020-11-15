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

