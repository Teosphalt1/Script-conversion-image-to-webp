#!/usr/bin/env bash  

#Date D'aujourd'hui
date=$(date +'%Y-%m-%d') 

for file in *
do

#Date de création de l'image
date_creation=$(stat -c '%.10w' $file)

#Date de la derniere modification de l'image
date_modification=$(date -r "$file" +'%Y-%m-%d')

#Fonction pour renommer le nouveau fichier avec le format format .webp
newfile(){
        echo "$file" | sed -r 's/(.[a-z0-9]*$)/.webp/'
}
new_filename="$(newfile)"

#Condition pour vérifier dans un premier temps si le fichier est un format d'image, dans un second temps si ce fichier au format webp n'existe pas et dans un dernier temps si la date de création de ce fichier ou bien la date de modification correspond à celle d'aujourd'hui
if [[ $(file --mime-type -b "$file") == image/*g ]] && [[ ! -e $new_filename ]] && [[ $date == $date_modification || $date == $date_creation ]]; then

        #Conversion et compression de l'image au format webp et attribution du nouveau nom
        cwebp -q 80 "$file" -o "$(newfile)"
fi
done
