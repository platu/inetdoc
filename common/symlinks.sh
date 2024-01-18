#!/bin/bash

if [ -n $1 ]
then
    echo "Usage: $0 $(SYMLINKS)"
    exit 1
fi

for link in $1
do 
	if [ -f "$link" ] && [ ! -h "$(basename "$link")" ]
    then 
		ln -sf "$link" . 
	fi 
done

exit 0