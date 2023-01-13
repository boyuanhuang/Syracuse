#!/bin/bash

> $GPI

echo -en "plot \\" >> $GPI
GPI="plot.gpi"
NUM=1
for FILE in *.dat; do
  echo -en "\n  '$FILE' using 1:2 title '`basename $FILE .dat`' w lp ls $NUM,\\" >> $GPI
  ((NUM++))
done

sed -i '$s/,\\$//' $GPI
echo >> $GPI

cat $GPI
gnuplot $GPI