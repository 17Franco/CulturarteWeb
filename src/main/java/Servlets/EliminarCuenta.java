/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Config.config;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URI;
import java.net.URL;
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;


@WebServlet(name = "EliminarCuenta", urlPatterns = {"/EliminarCuenta"})
public class EliminarCuenta extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        
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
        
        
        
        String nick = request.getParameter("NickName");
        
        try{
            if(portU.existe(nick)){
                if(portU.eliminarProponente(nick)){
                    HttpSession session = request.getSession(false); // no crear si no existe

                    if (session != null) {
                        session.invalidate();
                    }
                    response.getWriter().write("{\"resp\": " + true + "}");
                }else{
                    response.getWriter().write("{\"resp\": " + false + "}");
                }
                
                
                
                
            }else{
            
                response.getWriter().write("{\"resp\": " + false + "}");
            }
            
        }catch(IOException e){
            response.getWriter().write("{\"resp\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
