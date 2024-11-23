#!/usr/bin/env python3

# Read the DocBook article XML file given as the first argument

import os
import re
import sys


# A function that reads the DocBook XML file
def read_file(filename):
    with open(filename, "r") as f:
        return f.read()


# A function that extracts all XML contentes between <article> and </article>
def extract_article(xml):
    article = re.search(r"<article.*</article>", xml, re.DOTALL)
    if article:
        return article.group(0)
    else:
        return None


# A function that removes the "&author;" entity called in the article
def remove_author_entity(article):
    return re.sub(r"&author;", "", article)


# A function that removes all occurrences of the "<?custom-pagebreak?>" tag
def remove_custom_pagebreak(article):
    return re.sub(r"<\?custom-pagebreak\?>", "", article)


# A function that removes the sect1 which contains ".*meta" in its xml:id
# attribute
def remove_meta_section(article):
    return re.sub(r"<sect1[^>]*meta.*?</sect1>", "", article, flags=re.DOTALL)


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 script.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]
    # Test if the file exists
    try:
        os.stat(filename)
    except FileNotFoundError:
        print(f"File {filename} not found")
        sys.exit(1)

    # Process the file
    content = read_file(filename)
    article = extract_article(content)
    if article:
        article = remove_author_entity(article)
        article = remove_custom_pagebreak(article)
        article = remove_meta_section(article)
        print(article)
    else:
        print("No article found")


if __name__ == "__main__":
    main()
