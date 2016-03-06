#!/usr/bin/env texlua

-- Build script for lualatex-math

module = "lualatex-math"

checkengines = {"luatex"}
installfiles = {"*.lua", "*.sty"}
packtdszip   = true
sourcefiles  = {"*.cls", "*.dtx", "*.ins"}
stdengine    = "luatex"
tdsroot      = "lualatex"
textfiles    = {"MANIFEST", "README"}
typesetexe   = "lualatex"

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
