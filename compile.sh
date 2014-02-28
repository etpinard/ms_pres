#! /bin/bash
#
# Script that compiles 'pres.tex' with 'latexmk'.
# 
# -- By default, it modifies 'pres.tex' if 'draft' option is not set.
#
# Options: '-final' (non 'draft' mode)
#
# ===============================================================================

## 2) call 'latexmk' with 'pdfdvi' option
latexmk -pdfdvi pres.tex

exit 0

# Input option

opt="$1"
# -------------------------------------------------------------------------------

# String definitions 

thesis="thesis.tex"

str_comm="%"				
str_draft="\documentclass[twoside,10pt,draft]{uwthesis}[2012/06/19]"
str_final="\documentclass[twoside,10pt]{uwthesis}[2012/06/19]"

case "$opt" in
  -final) str_name="$str_final"
          ;;
  *) str_name="$str_draft"
     ;;
esac

# sed -e with overwrite command
sed_O()
{ 
  tmptmp='/tmp/sed_O'
  mv $2 $tmptmp
  key=$(echo $1 | sed -e 's/\\/\\\\/g' | sed -e 's/\[/\\[/g' | sed -e 's/\]/\\]/g')
#  echo $key
#  sed -e "$key" $tmptmp > $2
  sed -i "$1" $tmptmp > $2
}
# -------------------------------------------------------------------------------

# initialize temporary files
tmp="compile.tmp"
cp $thesis $tmp

# 1.a) comment both '\documentclass' lines
cmd_comm()
{
  flag=$(fgrep -c "$str_comm$1" $tmp)
  if [ $flag -eq 0 ]; then
    sed_O "s/$1/$str_comm$1/" $tmp
    cat $tmp | head 
  fi
}
cmd_comm "$str_draft"
cmd_comm "$str_final"

# 1.b)

exit 0

## 2) call 'latexmk' with 'pdfdvi' option
latexmk -pdfdvi thesis.tex

