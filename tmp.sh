
GPI="plot.gpi"
echo "plot \\" >> $GPI
NUM=1
for FILE in *.dat; do
  echo "'$FILE' using 1:2 title '`basename $FILE .dat`' w lp ls $NUM,\\" >> $GPI
  ((NUM++))
done

sed -i '$s/,\\$//' $GPI
echo >> $GPI

cat $GPI
gnuplot $GPI