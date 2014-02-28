#! /bin/bash
#
# Make '.eps' and '.png' cropped standalone figures in this directory
#
# ===============================================================================

## Definitions

# 
borders1='5cm 10cm 20cm 15cm'
borders2='0cm 0cm 0cm 0cm'
borders3='0cm 0cm 0cm 0cm'
fig1='2003.jpg'
fig2='2010.gif'
fig3='2012.gif'
name='intro_fig'

# -------------------------------------------------------------------------------

## code

# 00) convert .gif to jpg
convert $fig2 ${fig2%.gif}.jpg
fig2=${fig2%.gif}.jpg
convert $fig3 ${fig3%.gif}.jpg
fig3=${fig3%.gif}.jpg

# 0) make temporary file
tmp_tex='./convert_standalone.tex'

# 1) file up temporary '.tex' file
(	echo '\documentclass[crop]{standalone}'
  echo '\usepackage{graphicx}'
  echo '\usepackage{amsmath,amsfonts,amssymb,wasysym}'
  echo '\input{../../../pres_macros}'
  echo '\usepackage{../../../pres_font}'
  echo '\begin{document}'
  echo "\includegraphics[trim=$borders2,clip,width=0.5\linewidth]{$fig2}"
  echo '\hspace{-3cm}\raisebox{5cm}{'
  echo "\includegraphics[trim=$borders1,clip,width=0.5\linewidth]{$fig1}}"
  echo '\hspace{-3cm}'
  echo "\includegraphics[trim=$borders3,clip,width=0.5\linewidth]{$fig3}"
	echo '\end{document}' ) > $tmp_tex

# 2) call 'pdflatex' (w/ shell-escape) 
cmd="pdflatex -shell-escape $tmp_tex"
eval $cmd
eval $cmd

# 3a) convert to an '.eps'
pdftops -eps convert_standalone.pdf
cp convert_standalone.eps $name.eps

# 3b) convert to a '.png' (w/ density --- & white background)
convert -density 600 convert_standalone.eps $name.png
convert -flatten $name.png $name.png

# 4) remove temporary files
rm -f convert_standalone.{tex,aux,log,pdf,eps}
rm $fig2 $fig3

# 5) move outputs to figure folders 
mv $name.{eps,png} ..

# -------------------------------------------------------------------------------
