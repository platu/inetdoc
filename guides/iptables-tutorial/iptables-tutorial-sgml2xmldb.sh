#!/bin/bash
set -euo pipefail

# Appendices
find /home/phil/src/home/mb/traduc/appendices -type f -name "*.sgml" -print0 |
	while IFS= read -r -d '' file; do
		base="$(basename "${file}" .sgml)"
		echo "${base}"
		iconv -f iso-8859-1 -t utf-8 "${file}" -o "appendices/${base}.xml"
	done

# Chapters
find /home/phil/src/home/mb/traduc/chapters -type f -name "*.sgml" -print0 |
	while IFS= read -r -d '' file; do
		base="$(basename "${file}" .sgml)"
		echo "${base}"
		iconv -f iso-8859-1 -t utf-8 "${file}" -o "chapters/${base}.xml"
	done

# Licensing
find /home/phil/src/home/mb/traduc/licensing -type f -name "*.sgml" -print0 |
	while IFS= read -r -d '' file; do
		base="$(basename "${file}" .sgml)"
		echo "${base}"
		iconv -f iso-8859-1 -t utf-8 "${file}" -o "licensing/${base}.xml"
	done

# Images
find /home/phil/src/home/mb/traduc/images -type f -name "*.jpg" -print0 |
	while IFS= read -r -d '' file; do
		base="$(basename "${file}" .jpg)"
		echo "${base}"
		cp "${file}" images/
		mogrify -format png "images/${base}.jpg"
	done

rm -f images/*.jpg
