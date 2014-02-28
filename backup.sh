#! /bin/bash
#
# Script that backups pres/ onto the UW hard drive.
#
# ===============================================================================

# Address of UW server
UW='etienne@cyclone.atmos.washington.edu'

# Path to hard drive
PATH1='/home/disk/p/etienne/pres/'

# Thesis path on laptop 
# (with trailing '/' to copy content and but not the parent folder)
IN='/home/etienne/documents/proj/pres/'

# Find today's date and make final out folder 
DATE=`date +"%m-%d"`
OUT='pres_'$DATE'/'
ZIP='pres_'$DATE.zip

# Destination
DESTINATION="$UW:$PATH1$OUT"

# -------------------------------------------------------------------------------

## 1) clean up 'pres/' folder
latexmk -c 
rm pres.dvi
rm pres.ps
rm pres.bbl

## 2) zip '.tex' files 
zip -R $ZIP content/* pres_references.bib pres_font.sty beamerthemepres.sty pres_macros.tex pres.pdf 

## 3) Backups files using rsync
echo -e "\nBackuping $IN to ... \n\t $DESTINATION"
rsync -ah --info=progress2 "$IN" "$DESTINATION"

# -a (archives) , perfect for backups (see rsync -help)
# -h (human-readable) 

rm $ZIP

# -------------------------------------------------------------------------------
