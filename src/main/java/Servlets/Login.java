/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Controller;
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;


/**
 *
 * @author fran
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //si agregas login a http://localhost:8080/Lab2PA/index.jsp t manda al jsp
        response.sendRedirect(request.getContextPath() + "/InicioSesion_Registro.jsp"); 
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       //IController controller= Fabrica.getInstance().getController();
       
        ControllerWS_Service service = new ControllerWS_Service();
        ControllerWS portU = service.getControllerWSPort(); 
        
        HttpSession sesion = request.getSession();
        String nick = request.getParameter("Nickname");
        String pass = request.getParameter("password"); 
        
          
        
        try{
           if(portU.login(nick, pass)){
               if(portU.isProponente(nick)){
                sesion.setAttribute("logueado", nick); 
                sesion.setAttribute("tipoUser", "Proponente");
               }else{
                sesion.setAttribute("logueado", nick); 
                sesion.setAttribute("tipoUser", "Colaborador");
               }
               response.sendRedirect(request.getContextPath() + "/"); 
               //request.getRequestDispatcher("/index.jsp").forward(request, response);
           }else{          
            request.setAttribute("errorMessage", "Nick o Contrasena Incorrectos.");
 
            request.getRequestDispatcher("/InicioSesion_Registro.jsp").forward(request, response);
           }
            
        }catch(Exception e){
            
        System.out.println("Error de registro: " + e.getMessage());
        e.printStackTrace(); 

        request.setAttribute("errorMessage", "No se pudo Iniciar Sesion.");
 
        request.getRequestDispatcher("/InicioSesion_Registro.jsp").forward(request, response);
        
        }
        
    }

    
}
