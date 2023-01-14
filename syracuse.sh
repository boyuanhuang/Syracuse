#!/bin/bash

# Install gnuplot on MacOs, run : brew install gnuplot
# Install gnuplot on Windows, just google or see http://spiff.rit.edu/classes/ast601/gnuplot/install_windows.html

# todo Gestion de input qvec erreur
echo "min: $1";
echo "max: $2";

# Call python script to creat .dat files from min to max
for (( n=$1; n<=$2; n++ ))
do
   echo "Doing $n"
   python syracuse.py $n "f$n.dat"

done

# Plot 1 : toutes les courbes de données (n,Un) de la suite de Syracuse,

GPI="plot.gpi"
echo "set title 'test'" >> $GPI
echo "set key off" >> $GPI
echo "plot \\" >> $GPI
COUNT=1
for FILE in *.dat; do
  ((COUNT++))
done

NUM=1
for FILE in *.dat; do
  ((NUM++))
  if [ "$NUM" -eq $COUNT ];
  then
    echo "'$FILE' using 1:2 title '`basename vol.dat`' w l linecolor 1" >> $GPI
  else
    echo "'$FILE' using 1:2 w l linecolor 1,\\" >> $GPI
  fi
done

sed -i '$s/,\\$//' $GPI
echo "set term jpeg" >> $GPI
echo "set output 'plot.jpeg'" >> $GPI  # https://gnuplot.sourceforge.net/docs_4.2/node392.html
echo "replot" >> $GPI
echo "set term x11" >> $GPI
echo >> $GPI

cat $GPI
gnuplot -persist $GPI
rm $GPI


# Plot 2 : la courbe pour l’altitude maximum
scaning_object="altimax"
for FILE in *.dat; do
  filename=$FILE
  echo $filename
  while read line; do
  # reading each line
  if [[ "$line" == *"$scaning_object"* ]];
  then
    echo "${filename//[^0-9]/} ${line//[^0-9]/}" >> scan1.dat  # Keep only numerical part of the string
  fi

  done < $filename

done

# todo : plot data in scan1.dat
rm "scan1.dat"


# todo
# Plot 3 : la durée de vol



# todo
# Plot 4 : la durée de vol en altitude en fonction des U0.




# Remove files after analysis
for (( n=$1; n<=$2; n++ ))
do
   rm -f "f$n.dat"
done

