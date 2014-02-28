#! /bin/bash

sec="$1"
pres="pres.pdf"

# case split $sec - combine/move to parts/
case "$sec" in
  01) pdftk $pres cat 1-20 output pres_01.pdf
      mv -f pres_01.pdf parts/
      ;;
  02) pdftk $pres cat 2-12 output pres_02.pdf
      mv -f pres_02.pdf parts/
      ;;
  03) pdftk $pres cat 2-24 output pres_03.pdf
      mv -f pres_03.pdf parts/
      ;;
  04) pdftk $pres cat 2-16 output pres_04.pdf
      mv -f pres_04.pdf parts/
      ;;
  05-06) pdftk $pres cat 2-10 output pres_05-06.pdf
      mv -f pres_05-06.pdf parts/
      ;;
  full) cd parts/
       pdftk pres_{01,02,03,04,05-06}.pdf cat output pres_full.pdf
       mv -f pres_full.pdf ..
       ;;
  *) echo '*** Invalid input ***'
     exit 1
     ;;
esac

#ls -l parts/
# ===============================================================================
