/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;


import Config.config;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URI;
import java.net.URL;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;


/**
 *
 * @author fran
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {
    
    private boolean isMobileDevice(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (userAgent == null) {
            return false;
        }
        
        
        return userAgent.contains("Mobi") || 
               userAgent.contains("Android") || 
               userAgent.contains("iPhone") || 
               userAgent.contains("iPad") || 
               userAgent.contains("Touch"); // Aunque 'Touch' no es tan fiable, es consistente con la lógica discutida.
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //si agregas login a http://localhost:8080/Lab2PA/index.jsp t manda al jsp
        response.sendRedirect(request.getContextPath() + "/InicioSesion_Registro.jsp"); 
    }

    
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
        
          
        ControllerWS_Service service = new ControllerWS_Service(url);
        
        ControllerWS portU = service.getControllerWSPort(); 
        
        //es para saber si cabia url si cambio en config
//        String endpoint = ((BindingProvider) portU)
//                      .getRequestContext()
//                      .get(BindingProvider.ENDPOINT_ADDRESS_PROPERTY)
//                      .toString();
//
//        System.out.println("➡️ El cliente está llamando a: " + endpoint);
        
        HttpSession sesion = request.getSession();
        String nick = request.getParameter("Nickname");
        String pass = request.getParameter("password"); 
        
        boolean esMovil = isMobileDevice(request);
        try{
         
           if(portU.login(nick, pass)){
                boolean esProponente = portU.isProponente(nick);
                String tipoUsuario = esProponente ? "Proponente" : "Colaborador";
                
                if (esMovil && esProponente) {
                    request.setAttribute("errorMessage", "Acceso denegado: Los Proponentes no pueden iniciar sesión desde dispositivos móviles.");
                    request.getRequestDispatcher("/InicioSesion_Registro.jsp").forward(request, response);
                    return; 
                }
                 
                sesion.setAttribute("logueado", nick);
                sesion.setAttribute("tipoUser", tipoUsuario);
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
