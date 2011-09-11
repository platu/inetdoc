#!/bin/bash

../scripts/startup.sh client.raw 512 10 
../scripts/startup.sh serveur.raw 512 11 

if [[ -z "`pidof dynamips | tr -d '\n'`" ]]
then
	echo "Launching dynamips"
	dynamips -H 7200 & >/dev/null
	sleep 5
	echo '.'
fi

dynagen lab.net

echo "The End"

exit 0
