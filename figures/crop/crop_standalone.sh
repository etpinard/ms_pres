#! /bin/bash
#
# Make '.eps' and '.png' cropped standalone figures of exiting PDF files
# using LaTeX
#
# ===============================================================================

## Definitions

#
file="$HOME/documents/proj/refs/seneviratne10_review.pdf"
page='10'
borders='10.5cm 17.5cm 1.2cm 1.8cm'
name='sene10_loops1'

#
file="$HOME/documents/proj/refs/seneviratne10_review.pdf"
page='11'
borders='10.5cm 1.3cm 1cm 18.7cm'
name='sene10_loops2'

#
file="$HOME/documents/proj/refs/seneviratne10_review.pdf"
page='15'
borders='1cm 3cm 1cm 13cm'
name='ipcc_soil_mois'

#
file="$HOME/documents/proj/refs/schar04_increased-temp-var.pdf"
page='3'
borders='10.5cm 9.6cm 2cm 13.5cm'
name='schar04_pdf'

#
file="$HOME/documents/proj/refs/schar04_increased-temp-var.pdf"
page='3'
borders='10.5cm 0.9cm 2cm 18.3cm'
name='schar04_map'

# 
file="$HOME/documents/proj/refs/seneviratne06_landatmcoupling.pdf"
page='2'
borders='0.5cm 9.5cm 2cm 9.7cm'
name='sene06_sig_T'

# -------------------------------------------------------------------------------

## code

# 00) make temporary files 
tmp_pdf='./crop_standalone_tmp.pdf'
tmp_tex='./crop_standalone.tex'

# 0) select page
pdftk $file cat $page output $tmp_pdf

# 1) file up temporary '.tex' file
(	echo '\documentclass[crop]{standalone}'
  echo '\usepackage{graphicx}'
  echo '\usepackage{amsmath,amsfonts,amssymb,wasysym}'
  echo '\input{../../pres_macros}'
  echo '\usepackage{../../pres_font}'
  echo '\begin{document}'
  echo "\includegraphics[trim=$borders,clip]{$tmp_pdf}"
	echo '\end{document}' ) > $tmp_tex

# 2) call 'pdflatex' (w/ shell-escape) 
cmd="pdflatex -shell-escape $tmp_tex"
eval $cmd
eval $cmd

# 3a) convert to an '.eps'
pdftops -eps crop_standalone.pdf
cp crop_standalone.eps $name.eps

# 3b) convert to a '.png' (w/ density --- & white background)
convert -density 600 crop_standalone.eps $name.png
convert -flatten $name.png $name.png

# 4) remove temporary files
rm -f crop_standalone.{tex,aux,log,pdf,eps}
rm $tmp_pdf 

# 5) move outputs to figure folders ( not necessary )
# mv "$1"

# -------------------------------------------------------------------------------
