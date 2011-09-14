# Makefile
# Copyright 2011 Philipp Stephani
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3c
# of this license or (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3c or later is part of all distributions of LaTeX
# version 2009/09/24 or later.
#
# This work has the LPPL maintenance status `maintained'.
# The Current Maintainer of this work is Philipp Stephani.
# This work consists of all files listed in MANIFEST.

SHELL := /bin/sh

ZIP := zip -v

name := lualatex-math
tds_arch := $(name).tds.zip


all: $(tds_arch)

$(tds_arch): $(tds_child_files)
	$(ZIP) -p $@ $^

.PHONY: all
.SUFFIXES:
