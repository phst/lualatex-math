#!/usr/bin/env texlua

-- Build script for lualatex-math

module = "lualatex-math"

installfiles = {"*.lua", "*.sty"}
sourcefiles  = {"*.cls", "*.dtx", "*.ins"}
tdsroot      = "lualatex"
txtfiles     = {"*.rst"}
typesetexe   = "lualatex"

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))