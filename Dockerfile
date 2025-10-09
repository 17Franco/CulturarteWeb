
# Usamos Tomcat con JDK 21 la imagen 
FROM tomcat:10.1-jdk21

# el war_file guarda el war generado del servidor web con dependecias
ARG WAR_FILE=target/Lab2PA-1.0-SNAPSHOT.war

# Copiamos el WAR dentro de Tomcat se copia en esa ruta para ser accedido directamente desde http://localhost:8080
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

# puerto que exponemos de docker (interno)
EXPOSE 8080

# Arrancamos Tomcat
CMD ["catalina.sh", "run"]