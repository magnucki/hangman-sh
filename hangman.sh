#doppelte buchstabeneingabe ausstellen

#!/bin/bash

woerterbuch="./worte.txt"				#liest das Wörterbuch ein
zufallswort="./zufall.sh"				#läd Zufallsscript

#leer="\."
loesung="$($zufallswort $woerterbuch)"			#sucht ein zufälliges Wort aus dem Wörterbuch
#loesung=bla #testing only

versuche=8						#legt die Anzahl der Versuche fest
bishererraten=" "					#leert die Variable
teil="$(echo $loesung | sed "s/./-/g")"			#gibt das Lösungswort mittels Bindestrichen aus
geraten=""						#leert die Variable

while [ "$geraten" != "$loesung" ] && [ $versuche -gt 0 ] && [ "$teil" != "$loesung" ]		#Festlegen der Bedingungen
												#für die while Schleife
do
    							#Textausgabe
    echo $teil
    echo ""
    echo Bisher geraten: $bishererraten
    echo ""
    echo "Du hast noch $versuche Versuche"
    echo "Bitte rate einen Buchstaben:"

    read geraten					#liest die Bildschirmeingabe in eine Variable ein

	if [ $geraten == $loesung ] ;			#Abbruchbedingung für sofortige richtige Eingabe
	      then echo "richtig geraten"
	    elif [ $(echo $geraten | wc -m) -ne 2 ] ;
     		       					#Wenn die Anzahl der Buchstaben NICHT eins ist
	     then echo "$geraten ist nicht das gesuchte Wort!"
			  geraten=" "
   	
		elif [ $geraten == " " ] ;

			then [ echo "Sie müssen einen Buchstaben eingeben"]	
				geraten=" "	
fi
    

bishererraten=$bishererraten$geraten			#Zusammenführen von Variablen
	tempteil=$teil					#"Auslagern" der Variable "Teil"
    temp=" $(echo $loesung | sed "s/[$bishererraten]//g")" 	#Gibt das Lösungswort ohne die geratenen Buchstaben aus
    teil="$(echo $loesung | sed "s/[$temp]/-/g")"		#Negation der obrigen Anweisung und Ausgabe mit Bindestrichen

    if [ "$teil" == "$tempteil" ] ;			#Wenn sich nichts geändert hat, hat man falsch geraten
       then versuche=$(($versuche-1))			#verringern der Versuchsanzahl
    fi

    if [ "$teil" == "$loesung" ] ;			#Abbruchbedingung der Lösung
      then echo "Sehr gut, du hast es geschafft"
           echo "die Loesung ist: $loesung" 
      exit 0						#Beenden des Programms
    fi


done
echo "Schade die Lösung war $loesung"
exit 0
