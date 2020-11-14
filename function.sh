#!/bin/bash

function dir (){
	for i in $(ls);do
		if [ -d ${i} ]; then
			echo " <> ${i} <> "
		fi
	done
	
}

dir
