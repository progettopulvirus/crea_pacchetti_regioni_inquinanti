#!/bin/bash

#Il primo passo per creare i pacchetti con i dati degli inquinanti e' usare il programma selezionaserie.R
#Il programma R crea una directory con il nome di una regione (i nomi sono elencatiin questo script 
#e fanno parte del vettore 'regioni') e all'interno di queste directory il programma creaPacchetto.R
#crea la struttura del pacchetto R

#In un'altra directory far girare questo script: scaricaRepositoryRegioni.sh che scarica da github
#i repository elencati nel vettore `regioni`

#Attenzioni: i nomi dei repository di github debbono essere gli stessi nomi delle directory create da selezionaSerie.R

#Copiare le directory con i pacchetti R (quelle create da selezioneaSerie.R) nella stessa directory dove compaiono i repository 
#di github. Siccome le directory hanno lo stesso nome, nei repository github avverra' un merge e una sovrascrittura dei dati
#ovvero il contenuto dei repository github verra' aggiornato con i nuovi pacchetti R, ma rimarra' invariata la struttura del 
#repository (i file .git nonvanno cancellati)

#Infine: il prohramma github.sh provvederea' a fare add->commit->push

#Attenzione questo vettore va aggiornato qualora vi fossero nuovi repository su github
regioni=("basilicata" "campania" "emiliaromagna" "friuliveneziagiulia" "lazio" \
"lombardia" "molise" "pabolzano" "patrento" "piemonte" "puglia" "sardegna" "sicilia" \
"toscana" "umbria" "valleaosta" "veneto")

for i in ${regioni[*]};do

echo "Scarico repository github: ${i}\n"

git clone "https://github.com/progettopulvirus/${i}.git"

done
