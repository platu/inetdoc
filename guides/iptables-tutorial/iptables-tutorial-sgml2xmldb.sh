#!/bin/bash

for file in $(find /home/phil/src/home/mb/traduc/appendices -type f -name "*.sgml"); do
	echo $(basename $file .sgml)
	iconv -f iso-8859-1 -t utf-8 $file -o appendices/$(basename $file .sgml).xml
done

for file in $(find /home/phil/src/home/mb/traduc/chapters -type f -name "*.sgml"); do
	echo $(basename $file .sgml)
	iconv -f iso-8859-1 -t utf-8 $file -o chapters/$(basename $file .sgml).xml
done

for file in $(find /home/phil/src/home/mb/traduc/licensing -type f -name "*.sgml"); do
	echo $(basename $file .sgml)
	iconv -f iso-8859-1 -t utf-8 $file -o licensing/$(basename $file .sgml).xml
done

for file in $(find /home/phil/src/home/mb/traduc/images -type f -name "*.jpg"); do
	echo $(basename $file .jpg)
	cp $file images/
	mogrify -format png images/$(basename $file)
done

rm images/*.jpg
