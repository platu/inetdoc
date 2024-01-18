#!/bin/bash

set -e

#/*--------------------------------------------------------------------------
#* Traitement des pages de vues d'une présentation OpenDocument (ODP)
#*---------------------------------------------------------------------------*/
#
# Liste des paramètres définis à partir des règles Makefile.Rules
# $1 -> $(BASENAME)
# $2 -> $(OUTPUT)

slideNumber=`ls -lAh $1-*[0-9].png | wc -l|tr -d '\n'`;
slideCounter=0

for file in `ls $1-*[0-9].png`; do \

slideFile=`basename $file .png`.html

cat >> "$2/$slideFile" <<-EOF
<h4>
  <a href='index.html'>[index]</a> \
  <a href='$1-00.html'>[&#60;&#60;début]</a>
EOF

if [ $slideCounter -gt 0 ]; then
  printf "<a href='$1-%02d.html'>[&#60;précédent]</a>\n" $((slideCounter - 1)) >> $2/$slideFile
fi

if [ $slideCounter -lt $((slideNumber - 1)) ]; then
  printf "<a href='$1-%02d.html'>[suivant&#62;]</a>\n" $((slideCounter + 1)) >> $2/$slideFile
fi

printf "<a href='$1-%02d.html'>[fin&#62;&#62;]</a></h4>\n" $((slideNumber - 1)) >> $2/$slideFile

printf "<p><em>Page (%2d/%2d)</em></p>\n" $((slideCounter + 1)) $slideNumber >> $2/$slideFile

printf "<img src='$1-%02d.png' width='640' alt='Page %2d' /><br />\n" $slideCounter $slideCounter >> $2/$slideFile

slideCounter=$((slideCounter + 1))

done

exit 0
