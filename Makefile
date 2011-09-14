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

ZIP := zip -v
MKTEXLSR := mktexlsr
TEX := tex
LATEX := lualatex
MAKEINDEX := makeindex

name := lualatex-math

texmf := $(shell kpsewhich --var-value=TEXMFHOME)
branch := lualatex/$(name)
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
tests := test-kernel-alloc test-kernel-style test-amsmath test-unicode test-icomma test-icomma-unicode
tests_src := $(addsuffix .tex,$(tests))
tests_dest := $(addsuffix .pdf,$(tests))
class := $(shell kpsewhich phst-doc.cls)
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
tds_root := texmf-dist
tds_arch := $(tds_root)/$(name).tds.zip
tds_destdir := tex/$(branch)
tds_docdir := doc/$(branch)
tds_srcdir := source/$(branch)
tds_dest := $(addprefix $(tds_destdir)/,$(destination))
tds_doc := $(addprefix $(tds_docdir)/,$(manual))
tds_source := $(addprefix $(tds_srcdir)/,$(source) $(driver))
export tds_child_files := $(tds_dest) $(tds_doc) $(tds_source)
tds_files := $(addprefix $(tds_root)/,$(tds_child_files))
ctan_arch := $(name).zip
ctan_files := $(tds_arch) README MANIFEST Makefile $(source) $(driver) $(destination) $(test_src) $(class) $(manual) $(auctex_style)


all: $(destination) $(auctex_style)

check: $(tests_dest)

pdf: $(manual)

complete: all check pdf

ctan: $(ctan_arch)

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

$(tds_root)/$(tds_destdir)/% $(tds_root)/$(tds_docdir)/% $(tds_root)/$(tds_srcdir)/%: %
	$(INSTALL) -d $(dir $@)
	$(INSTALL_DATA) $< $(dir $@)

$(tds_arch): $(tds_files)
	$(MAKE) -C $(tds_root)

$(ctan_arch): $(ctan_files)
	$(ZIP) -j $@ $^

.PHONY: all check pdf complete ctan install install-pdf install-complete
.SUFFIXES:
