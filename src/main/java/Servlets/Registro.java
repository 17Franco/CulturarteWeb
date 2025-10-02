/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import logica.Fabrica;
import logica.IController;

@MultipartConfig
@WebServlet("/Registro")
public class Registro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //intancia de fabrica y iController
        IController controller= Fabrica.getInstance().getController();
        PrintWriter out = response.getWriter();
        try{
            //contenido del input solo controla el input de registro
            String nick = request.getParameter("NickName");
            String pass = request.getParameter("password");
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
            
            
            byte[] contenido = null;
            try (InputStream input = filePart.getInputStream();
                 ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {

                byte[] data = new byte[1024];
                int nRead;
                while ((nRead = input.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                contenido = buffer.toByteArray();  
            }
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate fechaFormat = LocalDate.parse(fecha, formatter);  

            if(tipoUser.equals("Proponente")){
               controller.registroUsuario(nick, pass, nombre, apellido, email,fechaFormat,contenido, fileName, false, direccion, web, biografia);
            }else{
               controller.registroUsuario(nick, pass, nombre, apellido, email,fechaFormat,contenido, fileName, true, direccion, web, biografia);
            }
            
            request.setAttribute("successMessage", "¡Registro exitoso!."); //por si luego quiero mostrar mensjae

          
            request.getRequestDispatcher("/InicioSesion_Registro.jsp").forward(request, response);
        }catch(Exception e){
            System.out.println("Error de registro: " + e.getMessage());
            e.printStackTrace(); // Esto es CLAVE para ver la traza en la consola de Tomcat
            
            request.setAttribute("errorMessage", "No se pudo completar el registro. " + e.getMessage());

            // Se hace un reenvío (forward) a la misma página JSP del formulario.
            // Esto permite que la JSP muestre el mensaje.
            request.getRequestDispatcher("/InicioSesion_Registro.jsp").forward(request, response);
        } 
    
    }
}
    
