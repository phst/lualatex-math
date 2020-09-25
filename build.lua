-- Build script for lualatex-math.
-- Use the l3build tool to build and test this package.

module = "lualatex-math"

checkengines = {"luatex"}
installfiles = {"*.lua", "*.sty"}
packtdszip   = true
sourcefiles  = {"*.cls", "*.dtx", "*.ins"}
stdengine    = "luatex"
tdsroot      = "lualatex"
textfiles    = {"MANIFEST", "README"}
typesetexe   = "lualatex"
