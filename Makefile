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
INSTALL := install
INSTALL_PROGRAM := $(INSTALL) -c -m 755
INSTALL_DATA := $(INSTALL) -c -m 644

MKTEXLSR := mktexlsr
TEX := tex
LATEX := lualatex
MAKEINDEX := makeindex

name := lualatex-math
bundle := phst

texmf := $(shell kpsewhich --var-value=TEXMFHOME)
branch := latex/$(bundle)
destdir := $(texmf)/tex/$(branch)
docdir := $(texmf)/doc/$(branch)
auctexdir := ~/.emacs.d/auctex/style

LATEXFLAGS := --file-line-error --interaction=scrollmode
LATEXFLAGS_DRAFT := $(LATEXFLAGS) --draftmode
LATEXFLAGS_FINAL := $(LATEXFLAGS) --synctex=1

source := $(name).dtx
driver := $(name).ins
dest_sty := $(name).sty
dest_lua := $(name).lua
destination := $(dest_sty) $(dest_lua)
tests := test-kernel test-amsmath
tests_src := $(addsuffix .tex, $(tests))
tests_dest := $(addsuffix .pdf, $(tests))
manual := $(name).pdf
auctex_style := $(name).el
index_src := $(name).idx
index_dest := $(name).ind
index_log := $(name).ilg
index_sty := gind.ist
changes_src := $(name).glo
changes_dest := $(name).gls
changes_log := $(name).glg
changes_sty := gglo.ist


all: $(destination) $(auctex_style)

check: $(tests_dest)

pdf: $(manual)

complete: all check pdf

install: all
	$(INSTALL) -d $(destdir)
	$(INSTALL_DATA) $(destination) $(destdir)
	$(INSTALL) -d $(auctexdir)
	$(INSTALL_DATA) $(auctex_style) $(auctexdir)
	$(MKTEXLSR)

install-pdf: pdf
	$(INSTALL) -d $(docdir)
	$(INSTALL_DATA) $(manual) $(docdir)
	$(MKTEXLSR)

install-complete: install install-pdf

$(destination) $(tests_src): $(driver) $(source)
	$(TEX) $<

$(tests_dest): %.pdf: %.tex $(destination)
	$(LATEX) $(LATEXFLAGS_FINAL) $<

$(manual): $(source) $(destination)
	$(LATEX) $(LATEXFLAGS_DRAFT) $<
	$(MAKEINDEX) -s $(index_sty) -o $(index_dest) -t $(index_log) $(index_src)
	$(MAKEINDEX) -s $(changes_sty) -o $(changes_dest) -t $(changes_log) $(changes_src)
	$(LATEX) $(LATEXFLAGS_DRAFT) $<
	$(LATEX) $(LATEXFLAGS_FINAL) $<

.PHONY: all check pdf complete install install-pdf install-complete
.SUFFIXES:
