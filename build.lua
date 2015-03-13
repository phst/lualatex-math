#!/usr/bin/env texlua

-- Build script for lualatex-math

module = "lualatex-math"

installfiles = {"*.lua", "*.sty"}
packtdszip   = true
sourcefiles  = {"*.cls", "*.dtx", "*.ins"}
tdsroot      = "lualatex"
txtfiles     = {"*.rst"}
textfiles    = {"MANIFEST", "README"}
typesetexe   = "lualatex"

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))