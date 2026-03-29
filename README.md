# inetdoc.net Source Repository

This repository contains the source and generated static assets for
[inetdoc.net](https://inetdoc.net), a documentation website dedicated to
internetworking and system/network administration topics.

The project is built around long-lived static publishing:

- DocBook XML sources
- XSLT transformations to XHTML and XSL-FO
- PDF generation with Apache FOP
- Nanoblogger-based site structure and publication workflow

## Repository Overview

Main top-level directories and files:

- `articles/`: technical articles (DocBook XML sources, generated pages)
- `guides/`: longer guides and tutorials
- `travaux_pratiques/`: labs and practical exercises
- `presentations/`: slide decks and related material
- `dev/`: development-focused notes and examples
- `common/`: shared build rules, stylesheets, scripts, metadata entities
- `styles/`, `templates/`, `images/`: web presentation assets
- `xml/`, `pdf/`, `odp/`: exported distribution artifacts
- `archives/`, `data/`, `cache/`: generated content and nanoblogger data/cache
- `index.html`, `rss.xml`, `atom.xml`, `robots.txt`: site entry points/feeds

## Build System

The build is driven by GNU Make.

- Root [Makefile](Makefile) orchestrates subdirectories.
- Shared logic lives in [common/Makefile.Rules](common/Makefile.Rules).
- Section-specific `Makefile`s define `SUBDIRS`, source lists, and processing
  targets.

Typical processing steps include:

1. XML validation with `xmllint`
2. XHTML generation with `xsltproc`
3. PDF generation via XSL-FO + Apache FOP
4. Page wrapping/publication steps through nanoblogger tooling

## Prerequisites

The toolchain expected by the current Makefiles includes:

- GNU Make
- `xmllint` (libxml2)
- `xsltproc` (libxslt)
- Apache FOP
- LibreOffice (for ODP/ODG conversions)
- ImageMagick (`convert`)
- Nanoblogger (`nb` command)
- standard Unix tools (`sed`, `grep`, `find`, `rsync`, etc.)

The Makefiles assume this workspace path by default:

- `$HOME/inetdoc`

If needed, override `MAIN_DIR` when invoking `make`.

## Common Commands

From repository root:

```bash
make
```

Builds configured sections and creates/updates generated web and document
artifacts.

```bash
make clean
```

Removes intermediate/generated files according to each directory `.gitignore`
rules.

You can also build specific sections, for example:

```bash
cd articles && make
cd guides && make
cd travaux_pratiques && make
```

## Publication

The repository includes a publication helper script:

- [common/nb_publish.sh](common/nb_publish.sh)

It synchronizes the local workspace to `/var/www/` using `rsync` with project-
specific exclusions.

## Notes

- This repository intentionally contains both sources and generated static
  outputs.
- Some content and configuration are legacy by design to preserve long-term
  compatibility of published material.
