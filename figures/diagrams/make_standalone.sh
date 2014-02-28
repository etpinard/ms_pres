#! /bin/bash
#
# Make '.eps' and '.png' standalone versions of LaTeX Tikz diagrams.
#
# ===============================================================================

## Input argument $1 is the name of the diagram (and the name of its '.tex')

in=$1
name=${in%.*}
# -------------------------------------------------------------------------------

# 1) Make temporary '.tex' file
tmp='./make_standalone.tex'
(	echo '\documentclass[crop]{standalone}'
	echo '\usepackage[svgnames]{xcolor}'				
	echo '\usepackage{tikz}'	
  echo '\usetikzlibrary{arrows,calc,decorations.pathmorphing,shapes}'
  echo '\usepackage{amsmath,amsfonts,amssymb,wasysym}'
  echo '\input{../../pres_macros}'
  echo '\usepackage{../../pres_font}'
  echo '\begin{document}'
  echo "\input{$name}"
	echo '\end{document}' ) > $tmp

# 2) call 'pdflatex' (w/ shell-escape) 
cmd="pdflatex -shell-escape $tmp"
eval $cmd
eval $cmd

# 3a) convert to an '.eps'
pdftops -eps make_standalone.pdf
cp make_standalone.eps $name.eps

# 3b) convert to a '.png' (w/ density ---)
convert -density 1200 make_standalone.eps $name.png

# 4) remove temporary files
rm -f make_standalone.{tex,aux,log,pdf,eps}

# 5) move outputs to figure folders ( not necessary )
# mv "$1"

# -------------------------------------------------------------------------------
