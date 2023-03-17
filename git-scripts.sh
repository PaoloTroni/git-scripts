#!/bin/bash

clear
echo " "
echo "################# BIENVENIDO AL ASISTENTE DE GIT #################"
echo "By Paolo Troni - paolotroni@gmail.com - https://github.com/PaoloTroni"
echo " "

# Comprobación inicial de si existe o no un repositorio creado. Si no existe, lo crea, para evitar errores posteriores.
if ! [[ -d .git ]]; 
	then
		echo " "
		echo "¡ATENCIÓN! No existe una carpeta \".git\" en este directorio ($PWD)."
		echo " "
		echo "Sin una carpeta \".git\" creada no se puede seguir adelante. Se creará una ahora."
		echo " "
		echo "Por favor, confirme: pulse \"S\" (mayúscula) para confirmar o pulse una tecla cualquiera para abortar."
		read confirmation
		echo " "
		
		if [ "$confirmation" = "S" ]
			then
			git init
			echo " "
			echo "Repositorio creado satisfactoriamente en el directorio $PWD. El asistente se reiniciará en 5 segundos."
			sleep 5
			echo " "
			./git-scripts.sh
		else
			echo "Se ha abortado la operación. El asistente se cerrará en 5 segundos"
			sleep 5
			exit 0
		fi
	else

# Inicialización de variables
# Variable de control de estado
first_time=true

# Array con las opiciones finales del menu)
opciones_finales=("	Digite m (minúscula) para mostrar el menu principal SIN limpiar la terminal" 
		  "	Digite z (minúscula) para limpiar la terminal y mostrar el menu principal, SIN SALIR" 
		  "	Digite x (minúscula) para limpiar la terminal y salir" 
		  "	Puedes terminar el programa en cualquier momento premendo \"Crtl + C\"")

# Función que imprime las opciones
function print_options {
echo " "
echo "Seleccione la opción deseada:"
echo " "

if [ "$first_time" = true ]; 
	then
        # Si es la primera vez, imprimir todas las opciones
		echo "Opciones de estado y carga de archivos y commits"
		echo "	Digite 1 para ver el estado del repositorio (git status)"
		echo "	Digite 2 para añadir y/o actualizar los archivos ubicados en la carpeta origen y ver sus estados."
		echo "	Digite 3 para crear un commit del proyecto.(git commit -m \"mensaje de commit\")"
		echo "	Digite 4 para ver el historial de todos los commits (git log)"
		echo " "
		echo "Opciones de repositorio online"
		echo "	Digite 5 para enlazar el repositorio local con el repositorio online (git remote add origin)"
		echo "	Digite 6 para subir los cambios a remoto (git push -u origin)"
		echo " "
		echo "Opciones de ramas"
		echo "	Digite 7 para crear una rama (git branch -M)"
		echo "	Digite 8 para ver las ramas existentes (git branch -a)"
		echo "	Digite 9 para moverse a una rama especificada (git checkout)"
		echo " "
		echo "Para BORRAR el repositorio local, ubicado en: $PWD, digite 0"
		echo " "
		echo "Opciones de salida:"
		echo " "
		
		for opcion in "${opciones_finales[@]}"
		do
    			echo "$opcion"
		done
	# Si NO es la primera vez, imprime solo las funciones finales
	else
		for opcion in "${opciones_finales[@]}"
		do
    			echo "$opcion"
		done
	 fi

read opcion
first_time=false
}
	
while true; do
print_options

 # Opciones de operaciones de git
 
case $opcion in

 # Para borrar el repositorio local
 
    0)
        clear
    	echo " "
        echo "Elegiste borrar la carpeta local de GIT ubicada en $PWD."
   	echo " "
	echo "¿ESTÁS SEGURO QUE QUIERES BORRAR LA CARPETA DE GIT?"
	echo " "
	echo "Por favor, confirme: pulse \"S\" (mayúscula) para confirmar o pulse una tecla cualquiera para abortar."
	read confirmation
	echo " "
		if [ "$confirmation" = "S" ]
		then
			rm -rf .git
			echo "Has borrado la carpeta local de GIT. Se cerrará el asistente."
			echo " "
			exit 0
		else	
			echo "Se ha abortado la operación"
		fi
        ;;
        
# Opciones de estado y operaciones locales, commits, etc
    1)
        clear
    	echo " "
        echo "Elegiste ver el estado del repositorio."
        echo " "
        git status
        echo " "
        ;;
        
    2)
        clear
    	echo " "
        echo "Elegiste añadir y/o actualizar todos los archivos que estn en la carpeta origen. (git add .)"
        echo "Además, se hará un \"git status\" para visualizar el estado de los archivos."
        echo " "
        git add .
        git status
        echo " "
        ;;
        
    3)
        clear
    	echo " "
        echo "Elegiste crear un commit del proyecto."
        echo "Escriba el mensaje de commit deseado:"
        read commit
        echo " "
        if [ -z "$commit" ]
        then
        	echo "No has especificado ningún mensaje de commit."
        	echo "El commit será por defecto: \"No se ha especificado un commit\""
        	echo " "
        	commit="No se ha especificado un mensaje de commit"
        else	
        	echo "Se creará el commit con el mensaje: \"$commit\""
        	echo " "
        fi
        git commit -m "$commit"
        echo " "
        ;;
        
    4)
        clear
    	echo " "
        echo "Elegiste ver el historial de todos los commits."
        echo " "
        git log
        echo " "
        ;;
        
# Opciones de trabajo con un repositorio remoto de GitHub
    5)
        clear
    	echo " "
        echo "Elegiste enlazar el repositorio local con el repositorio online."
        echo "Debes poner la dirección del repositorio online con su relativa clave"
        echo "¡ATENCIÓN! Comprueba que la dirección del repositorio sea correcta. En caso contrario no se llevará a cabo la operacion."
        read repo_online
        echo " "
        if [ -z "$repo_online" ]
        then
        	
        	echo "ERROR: tienes que especificar la dirección del repositorio online con su clave"        
     	else	
        	echo "Se enlazará el repositorio local con el repositorio online ubicado en: \"$repo_online\""
        	git remote add origin $repo_online
        	echo "Repositorio enlazado"
        fi
        ;;
        	
    6)
    	clear
    	echo " "
        echo "Elegiste subir los cambios a remoto."
        echo "Escriba el nombre de la rama a la que quieres subir los archivos:"
        read branch
        echo " "
        if [ -z "$branch" ]
        then
        	echo "No has especificado ninguna rama. Por defecto los archivos se subirán a la rama \"main\"."
        	branch="main"
        else	
        	echo "Vas a subir los archivos en la rama \"$branch\"."
        	echo " "
        fi
        git push -u origin $branch
        echo "Archivos subidos en el repositorio remoto en la rama \"$branch\"."
        ;;
        
# Opciones para manipular ramas

   7)
        clear
    	echo " "
        echo "Elegiste crear una rama."
        echo "Escriba el nombre de la nueva rama"
        read branch
        echo " "
        if [ -z "$branch" ]
        then
        	while ! [ -z "$branch" ]; do
        		echo "No has escrito nada. Por favor, pon nombre a la nueva rama."
        		read branch
        	done	
        fi
        git branch -M $branch
        echo "Has creado la rama \"$branch\"."
        ;;
        
    8)
        clear
    	echo " "
    	echo "Elegiste ver las ramas existentes."
        echo " "
        git branch -a
        echo " "
        ;;
        
    9)
        clear
    	echo " "
    	echo "Elegiste moverse a una rama específica."
    	echo "Escriba el nombre de la rama a la que te quieres mover:"
        read branch
        echo " "
        if [ -z "$branch" ]
        then
        	while ! [ -z "$branch" ]; do
        		echo "No has escrito nada. Por favor, escribe el nombre de la rama."
        		read branch
        	done	
        fi
        git checkout $branch
        echo "Te has movido a la rama \"$branch\"."
        ;;
                
# Opciones de salida y limpieza

        # Mostrar el menu principal sin limpiar la terminal
    m)
        first_time=true
        ;; 
        
        # Limpiar la terminal y volver al menu principal, sin salir
    z)
        clear
        first_time=true
        ;;
        
        # Limpiar la terminal y salir del programa
    x)
        clear
        exit 0
        ;;    
        
        # Opción por defecto para teclas no definidas - no sale del programa
    *)
        echo "Esa opción no es válida."
        ;;
     
esac

done

fi
