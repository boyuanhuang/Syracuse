import sys

def syracuse(U0, file_name):
    #initialisation de mes variables
    dureevol = 0
    altimax = 0 
    dureealtitude = 0   
    n = 0
    Un = 0
    
    #list pour permettre la mise en forme dans le fichier
    l = []
    l.append(U0)
    
    fichier = open(file_name, "w")
    #entete dns le fichier
    fichier.write("n  Un")
    fichier.write("\n") 
    
    #suite de syracuse
    while U0 != 1:

        if U0%2 == 0:
            Un = U0 // 2
            
            if Un >= altimax :
                altimax = Un

        else : 
            Un = U0 * 3 + 1
            
            if Un >= altimax :
                altimax = Un
           
        U0 = Un 
        dureevol = dureevol + 1
       
        l.append(Un)
        

    for i in l:
        if i > dureevol :
            dureealtitude = dureealtitude + 1
                    

  
    #print('altimax =', altimax)
    #print('dureevol =', dureevol)
    #print('dureealtitude =', dureealtitude)
    
    
    n = [i for i in range(dureevol + 1)]

    for j in range (len(n)):
        fichier.write(str(n[j]))
        fichier.write("  ")
        fichier.write(str(l[j]))
        fichier.write("\n")
    
    

    fichier.write("altimax=")
    fichier.write(str(altimax))
    fichier.write("\n")
    fichier.write("dureevol=")    
    fichier.write(str(dureevol)) 
    fichier.write("\n") 
    fichier.write("dureealtitude=") 
    fichier.write(str(dureealtitude)) 
    fichier.write("\n")    
    fichier.close()    


    return file_name


if __name__=="__main__":
    U0, filename = int(sys.argv[1]), sys.argv[2]
    syracuse(U0, filename)


