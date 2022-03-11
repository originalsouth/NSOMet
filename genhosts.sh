#!/usr/bin/env bash
export LC_ALL=C
OUTFILE=nsomet_hosts.txt
git submodule update --init --recursive --remote --merge
awk -F',' 'NR>1{print "0.0.0.0,"substr($1,2,length($1)-2)}' investigations/2018-08-01_nso/indicators.csv > $OUTFILE
for i in $(find . -name "*domains.txt" -type f); do awk '{print "0.0.0.0,"$1}' $i;done >> $OUTFILE
sed -i -e '/0\.0\.0\.0,$/d' $OUTFILE
sort -u -t"," -k 2 -o $OUTFILE $OUTFILE
sed -i -e 's/,/\t/g' $OUTFILE
echo "Written $(wc -l $OUTFILE | awk '{print $1}') domains to \"$OUTFILE\""
exit 0
