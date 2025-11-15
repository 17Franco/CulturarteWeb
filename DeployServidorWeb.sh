StopTomcat() {
    echo ""
    echo "Presiona Enter para detener Tomcat..."
    read

    "$TOMCAT_HOME/bin/shutdown.sh"
    echo "Tomcat detenido."
}

DeployServidorWeb(){
	config="$HOME/.Culturarte/config.properties"
	
	WEB_HOST=$(grep '^WEB_HOST=' "$config" | cut -d'=' -f2)
	WEB_USER=$(grep '^USER_HOST_WEB=' "$config" | cut -d'=' -f2)

	echo -e "Compilación de servidor-web y despliegue"
	
	mvn clean install
	
	if [ "$WEB_HOST" == "localhost" ]; then
		#busco donde esta tomcat
		TOMCAT_HOME=$(find "$HOME" /usr /opt /var / -type f -name "catalina.sh" 2>/dev/null | sed 's/\/bin\/catalina.sh//' | head -n 1)
		#talves no lo tiene intalado o yqc
		if [ -z "$TOMCAT_HOME" ]; then
		 echo "No se encontró ninguna instalación de Tomcat en el sistema."
		 exit 1
		fi
		
		echo "Tomcat encontrado en: $TOMCAT_HOME"
		NAME_WAR="Culturarte.war"
		
		echo "Desplegando Proyecto web"
		cp target/$NAME_WAR $TOMCAT_HOME/webapps
		
		"$TOMCAT_HOME/bin/startup.sh"
		
		StopTomcat

	else
		echo "-------Desplegando WAR remotamente en $WEB_HOST-------"
		SSH_PORT=22
	 	SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
	 	NAME_WAR="Culturarte.war"
	 	
	 	
		REMOTE_TOMCAT_HOME=$(ssh $SSH_OPTS -p $SSH_PORT "$WEB_USER@$WEB_HOST" \
            "find ~ /usr /opt /var -type f -name 'catalina.sh' 2>/dev/null | sed 's/\/bin\/catalina.sh//' | head -n 1")
            
        if [ -z "$REMOTE_TOMCAT_HOME" ]; then
            echo "No se encontró Tomcat en el host remoto"
            exit 1
        fi

        echo "-------Tomcat remoto encontrado en: $REMOTE_TOMCAT_HOME-------"
        echo
        #cosas a tener en cuenta debe generar la clave privada en el host origen sino pide pass en cada conexion
        echo "-------Creando carpeta remota ~/.Culturarte si no existe-------"
		  ssh $SSH_OPTS -p $SSH_PORT "$WEB_USER@$WEB_HOST" "mkdir -p ~/.Culturarte"
		  
		  echo
		  echo "-------Copiando config al servidor remoto-------"
		  scp $SSH_OPTS -P $SSH_PORT "$config" "$WEB_USER@$WEB_HOST:~/.Culturarte/"
		  
		  echo
		  echo "-------Copiando WAR al servidor remoto-------"
        scp $SSH_OPTS -P $SSH_PORT "target/$NAME_WAR" "$WEB_USER@$WEB_HOST:$REMOTE_TOMCAT_HOME/webapps/"
        
        echo
        ssh $SSH_OPTS -p $SSH_PORT "$WEB_USER@$WEB_HOST" \
            "cd '$REMOTE_TOMCAT_HOME/bin' && ./shutdown.sh 2>/dev/null; sleep 2; ./startup.sh"
            
		  echo
	     echo "--------------Despliegue remoto completado.--------------"
	     
	     read -p "Presiona Enter para detener Tomcat remoto..."

		  echo "Deteniendo Tomcat remoto..."
		  ssh $SSH_OPTS -p $SSH_PORT "$WEB_USER@$WEB_HOST" \
				 "cd '$REMOTE_TOMCAT_HOME/bin' && ./shutdown.sh"
		
	fi
	
}

DeployProject(){
	config="$HOME/.Culturarte/config.properties"
	
	port_WebSaop=$(grep '^WEB_SERVICES_PORT=' "$config" | cut -d'=' -f2)
	
	portR_WebRest=$(grep '^WEB_SERVICES_PORTR=' "$config" | cut -d'=' -f2)
	
	NAME_JAR="Lab1PA-1.0-SNAPSHOT-jar-with-dependencies.jar"
	##deberia comprobar antes que el servidor central este ejecutandose
	pidWebSoap=$(lsof -ti :$port_WebSaop)
	pidWebRest=$(lsof -ti :$portR_WebRest)
	
	if [ -n "$pidWebSoap" ] && [  -n "$pidWebRest" ]; then
	
		nombre_proceso_pidSoap=$(ps -p $pidWebSoap -o cmd=)
		nombre_proceso_pidRest=$(ps -p $pidWebRest -o cmd=)
		
		if [[ "$nombre_proceso_pidSoap" == *"$NAME_JAR"* ]]; then
			if [[ "$nombre_proceso_pidRest" == *"$NAME_JAR"* ]]; then
				#echo "compilar y ejecutar"
				DeployServidorWeb
			else
				echo "el puerto del los servicio rest estan ocupados por otro proceso"
			fi
			
		else
			echo "el puerto del los servicio soap estan ocupados por otro proceso"
		fi

	else
		echo "Error los servicios soap o rest no estan levantados"
	fi
	
	read -p "Presiona Enter para volver al menú..."
 	clear
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
