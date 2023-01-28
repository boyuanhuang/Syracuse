#!/bin/bash

if [ $# -eq 1 ] && [ $1 = "-h" ] #cas où on a 1 arg qui est -h
then 
    echo "Guide d'utilisation du programme : mon_script_shell.bash
Pour éxécuter le programme, il faut d'écrire le nom du programme suivi d'un nombre positif
puis un autre nombre strictement positif supérieur au précédent : ./mon_script_shell.sh min max"
    exit
fi

if [ $1 -lt $2 ] # cas où on a 2 arg min suivi de max
then
    
    if [ "$(echo $1 | grep "^[[:digit:]]*$")" ] && [ "$(echo $2 | grep "^[[:digit:]]*$")" ]  
    then
    
        for (( i=$1; i<=$2; i++ )); do
            python suite_syracuse.py $i f$i.dat
            
            
    
            #avoir la ligne altimax
            target="$(grep 'altimax=' f${i}.dat)"
            echo "$i ${target//[^0-9]/}" >> altimax.dat
    
            #avoir la ligne dureevol
            target2="$(grep 'dureevol=' f${i}.dat)" 
            echo "$i ${target2//[^0-9]/}" >> dureevol.dat
    
            #avoir la ligne dureealtitude
            target3="$(grep 'dureealtitude=' f${i}.dat)" 
            echo "$i ${target3//[^0-9]/}" >> dureealtitude.dat
            
        done
        
        
        # Plot 1 : toutes les courbes de données (n,Un) de la suite de Syracuse,

        GPI="plot1.gpi"
        echo "set title 'Un en fonction de n pour tous les U0 dans [$1;$2]'" >> $GPI
        echo "set xlabel 'n'" >> $GPI
        echo "set ylabel 'Un'" >> $GPI
        echo "plot \\" >> $GPI
        COUNT=1
        for FILE in f*.dat; do
          ((COUNT++))
        done
        
        NUM=1
        for FILE in f*.dat; do
          ((NUM++))
          if [ "$NUM" -eq $COUNT ];
          then
            echo "'$FILE' using 1:2 title '`basename vols.dat`' w l linecolor 1" >> $GPI
          else
            echo "'$FILE' using 1:2 title '' w l linecolor 1,\\" >> $GPI
          fi
        done
        
        sed -i '$s/,\\$//' $GPI
        echo "set term jpeg" >> $GPI
        echo "set output 'vols.jpeg'" >> $GPI 
        echo "replot" >> $GPI
        #echo "set term x11" >> $GPI
        echo >> $GPI
        
        cat $GPI
        gnuplot -persist $GPI
        rm $GPI
        
            
            
        # Plot 2 : créer une courbe pour l'alti max

        GPI="plot2.gpi"
        FILE=altimax.dat
        echo "set title 'Alltitude maximum atteinte en fonction de U0'" >> $GPI
        echo "set xlabel 'U0'" >> $GPI
        echo "set ylabel 'Altitude maximum'" >> $GPI
        echo "plot \\" >> $GPI
        echo "'$FILE' using 1:2 title '`basename altitude.dat`' w l linecolor 1" >> $GPI

        
        sed -i '$s/,\\$//' $GPI
        echo "set term jpeg" >> $GPI
        echo "set output 'altimax.jpeg'" >> $GPI  
        echo "replot" >> $GPI
        
        echo >> $GPI
        
        cat $GPI
        gnuplot -persist $GPI
        rm $GPI   
            
            
        # Plot 3 : créer une courbe pour l'vol en fonction de U0

        GPI="plot3.gpi"
        FILE=dureevol.dat
        echo "set title 'Duree de vol en fonction de U0'" >> $GPI
        echo "set xlabel 'U0'" >> $GPI
        echo "set ylabel 'Nombre occurences'" >> $GPI
        echo "plot \\" >> $GPI
        echo "'$FILE' using 1:2 title '`basename dureevol.dat`' w l linecolor 1" >> $GPI

        
        sed -i '$s/,\\$//' $GPI
        echo "set term jpeg" >> $GPI
        echo "set output 'dureevol.jpeg'" >> $GPI  
        echo "replot" >> $GPI
        
        echo >> $GPI
        
        cat $GPI
        gnuplot -persist $GPI
        rm $GPI       
            
            
        # Plot 4 : créer duree de vol en altitude en fonction de U0

        GPI="plot4.gpi"
        FILE=dureealtitude.dat
        echo "set title 'Duree de vol en altitude en fonction de U0'" >> $GPI
        echo "set xlabel 'U0'" >> $GPI
        echo "set ylabel 'Nombre occurences'" >> $GPI
        echo "plot \\" >> $GPI
        echo "'$FILE' using 1:2 title '`basename dureealtitude.dat`' w l linecolor 1" >> $GPI

        
        sed -i '$s/,\\$//' $GPI
        echo "set term jpeg" >> $GPI
        echo "set output 'dureealtitude.jpeg'" >> $GPI 
        echo "replot" >> $GPI
        
        echo >> $GPI
        
        cat $GPI
        gnuplot -persist $GPI
        rm $GPI               
            



         
        
        # Bonus
        
        #supp les fichier fU0.dat
        for FILE in f*.dat; do
          rm $FILE
        done

        
        synthese="synthese-min-max.txt"
        
        for FILE in *.dat; do
        
            filename=$FILE
            echo $filename >> $synthese
            MIN=100000000000000000000
            MAX=0
            CUMMUL=0
            while read line; do
                linearray=($line)
                echo ${linearray[1]}
                echo $[type line]
                
                if [ $line -lt $MIN ]; then
                  MIN=$line
                fi
              
                if [ $line -ge $MAX ]; then
                  MAX=$line
                  CUMMUL = $CUMMUL+$line
                fi
                
                done < $filename
            
            MOY=$CUMMUL/$line
            echo $MIN
            echo $MAX
            echo $MOY
        echo "MIN : $MIN" >> $synthese

        echo "MAX : $MAX" >> $synthese

        echo "Moyenne : $MOY" >> $synthese
            
        done     
        
             
     
     


       
            
    else 
        echo "Veuillez entrer deux nombres positifs uniquement : un minimum suivi d'un maximum" # quandc'est pas 2 nb > 0 ou  bien
        exit 1
    fi



else 
    echo "Veuillez entrer uniquement deux parametres"
    exit 2
fi


#supp les fichier fU0.dat
for FILE in *.dat; do
  rm $FILE
  #echo "Here"
done


