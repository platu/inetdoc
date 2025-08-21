#!/bin/bash

set -e

#/*--------------------------------------------------------------------------
#* Traitement des pages de vues d'une présentation OpenDocument (ODP)
#*---------------------------------------------------------------------------*/
#
# Liste des paramètres définis à partir des règles Makefile.Rules
# $1 -> $(BASENAME)
# $2 -> $(OUTPUT)

# Count the number of slide files
slideNumber=0
for f in "$1"-*[0-9].png; do
	[[ -e ${f} ]] && ((slideNumber++))
done
slideCounter=0

for file in "$1"-*[0-9].png; do
	# Skip if no files match the pattern
	[[ -e ${file} ]] || continue

	slideFile=$(basename "${file}" .png).html

	cat >>"$2/${slideFile}" <<-EOF
		<h4>
		  <a href='index.html'>[index]</a> \
		  <a href='$1-00.html'>[&#60;&#60;début]</a>
	EOF

	{
		if [[ ${slideCounter} -gt 0 ]]; then
			printf "<a href='%s-%02d.html'>[&#60;précédent]</a>\n" "$1" $((slideCounter - 1))
		fi

		if [[ ${slideCounter} -lt $((slideNumber - 1)) ]]; then
			printf "<a href='%s-%02d.html'>[suivant&#62;]</a>\n" "$1" $((slideCounter + 1))
		fi

		printf "<a href='%s-%02d.html'>[fin&#62;&#62;]</a></h4>\n" "$1" $((slideNumber - 1))

		printf "<p><em>Page (%2d/%2d)</em></p>\n" $((slideCounter + 1)) "${slideNumber}"

		printf "<img src='%s-%02d.png' width='640' alt='Page %2d' /><br />\n" "$1" "${slideCounter}" "${slideCounter}"
	} >>"$2/${slideFile}"

	slideCounter=$((slideCounter + 1))

done

exit 0
