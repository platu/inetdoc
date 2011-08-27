#!/bin/bash

set -e

#/*--------------------------------------------------------------------------
#* Traitement de la page d'index d'une présentation OpenDocument (ODP)
#*---------------------------------------------------------------------------*/
#
# Liste des paramètres définis à partir des règles Makefile.Rules
# $1 -> $(BASENAME)
# $2 -> $(OUTPUT)/$@.tmp

cat >> "$2" <<-EOF
<div id='presentation'>
EOF

for file in `ls $1-*[0-9].png`; do \
cat >> "$2" <<-EOF
<a href='`basename $file .png`.html'>
<img src='`basename $file .png`.idx.png' width='200' height='150'
     alt='Page `echo $file |sed 's/[-,a-z,A-Z,.]*//g'`' />
</a>
EOF
done

cat >> "$2" <<-EOF
</div><!-- /presentation div -->
EOF

exit 0
