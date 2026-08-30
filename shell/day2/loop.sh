#!/bin/bash

#this is the while loops

<<comment
1. is argument 1 which is folder name
2. this is devops journey
3. lets do it

comment

for (( num=$2 ; num<=$3; num++ )) 
do 
	mkdir "$1$num" 
done
