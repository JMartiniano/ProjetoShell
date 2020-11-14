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

