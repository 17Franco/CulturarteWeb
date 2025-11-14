DeployServidorWeb(){
	echo " Crear Archivo de Configuracion"
}

DeployProject(){
	##deberia comprobar antes que el servidor central este ejecutandose
	
	##compilar y ejecutar
	DeployServidorWeb
	
}
while true; do
    clear
    echo "=============================="
    echo "        MENÚ PRINCIPAL"
    echo "=============================="
    echo "1) Deploy Project"
    echo "2) Help"
    echo "3) Salir"
    echo "------------------------------"
    read -p "Elige una opción [1-3]: " opcion

    case $opcion in
        1)
        		clear
            DeployProject
           	;;
        2)
            echo "Help"
            ;;
            
		  3)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Opción inválida."
            read -p "Presiona Enter para continuar..."
            ;;
    esac
done
