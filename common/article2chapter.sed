/<article/,/<\/article/!d
s/<article/<chapter/
s/<\/article/<\/chapter/
/\&author;/d
/<?custom-pagebreak?>/d
/<sect1.*meta/,/<\/sect1/d
s/xml:id=['"]/&chapter-/g
s/endterm=['"]/&chapter-/g
s/arearefs='/&chapter-/g
s/linkend='/&chapter-/g
