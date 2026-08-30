#!/bin/bash

create_directory() {
	mkdir demo
}

if  ! create_directory; then
	echo "the code is exited as the direcotry already exists"
	exit 1
fi

echo "this should not work because the code is interruped"

