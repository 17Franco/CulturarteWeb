
package Servlets;

import Config.config;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream; // Importa InputStream
import jakarta.servlet.http.Part; // Importa Part
import java.io.ByteArrayOutputStream;
import java.net.URI;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;

@MultipartConfig
@WebServlet(name="Registro", urlPatterns={"/Registro"})
public class Registro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //intancia clase config (este me trae el archivo de configuracion)
        config conf = config.getInstance();
        //me traigo la ip desde el config.propertie
        String host = conf.getProps("WEB_SERVICES_HOST");
        //me traigo la port desde el config.propertie
        String port = conf.getProps("WEB_SERVICES_PORT");
        //servicio que quiero traer (manejamos solo uno igual)
        String serv = conf.getProps("SERVICE");
        //esto es para que si cambia la url del servicio solo modificamos el config y estaria
        
        //contruir url   
        String dir="http://"+host+":"+port+serv+"?wsdl";
        // convertir el String a URI 
        URI uri = URI.create(dir);
        // si el constructor de tu servicio acepta URL, convertís:
        URL url = uri.toURL();
        
        //Intanciando webService
        ControllerWS_Service service = new ControllerWS_Service(url);
        //controlador
        ControllerWS portU = service.getControllerWSPort(); 
        
        //intancia de fabrica y iController
        //IController controller= Fabrica.getInstance().getController();
        
        PrintWriter out = response.getWriter();
        try{
            //contenido del input solo controla el input de registro
            String nick = request.getParameter("NickName");
            String pass = request.getParameter("password2");
            String nombre = request.getParameter("nombre");
            String apellido= request.getParameter("apellido");
            String email= request.getParameter("email");
            String fecha= request.getParameter("fecha");
            String direccion= request.getParameter("direccion");
            String biografia= request.getParameter("biografia");
            String web= request.getParameter("paginaWeb");
            String tipoUser= request.getParameter("tipoUsuario");
            
            Part filePart = request.getPart("img");
            String fileName = filePart.getSubmittedFileName(); // Obtiene el nombre del archivo
            
            
            byte[] contenido = null;//lo que se mandara al controller
            try (InputStream input = filePart.getInputStream(); // input estara el archivo subidor imgperfil 
                 ByteArrayOutputStream buffer = new ByteArrayOutputStream()) { //array de bytes dinamico

                byte[] data = new byte[1024];//aux
                int nRead;//almacena la cantidad de bytes leidos
                while ((nRead = input.read(data, 0, data.length)) != -1) { //codicion input read almacena en data hasta 1024 bytes de la img eso queda en nread
                    buffer.write(data, 0, nRead); //aca escribe en el byfer diinamico la cant de byte que tiene nread de data
                }
                contenido = buffer.toByteArray(); //asigno a contenido 
            }
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate fechaFormat = LocalDate.parse(fecha, formatter);  
            System.out.println(pass);
            if(tipoUser.equals("Proponente")){
               portU.registroUsuario(nick, pass, nombre, apellido, email,fechaFormat.toString(),contenido, fileName, true, direccion, web, biografia);
            }else{
               portU.registroUsuario(nick, pass, nombre, apellido, email,fechaFormat.toString(),contenido, fileName, false, direccion, web, biografia);
            }
            
            request.setAttribute("successMessage", "¡Registro exitoso!"); //por si luego quiero mostrar mensjae

          
            request.getRequestDispatcher("/InicioSesion_Registro.jsp").forward(request, response);
        }catch(Exception e){
            System.out.println("Error de registro: " + e.getMessage());
            e.printStackTrace(); // Esto es CLAVE para ver la traza en la consola de Tomcat
            
            request.setAttribute("errorMessage", "No se pudo completar el registro. ");

            // Se hace un reenvío (forward) a la misma página JSP del formulario.
            // Esto permite que la JSP muestre el mensaje.
            request.getRequestDispatcher("/InicioSesion_Registro.jsp").forward(request, response);
        } 
    
    }
}
    
