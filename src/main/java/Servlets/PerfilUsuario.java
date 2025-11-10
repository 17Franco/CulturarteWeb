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
import java.net.URI;
import java.net.URL;
import logica.DTO.DTOColaborador;
import logica.DTO.DTOProponente;
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoColaborador;
import webservices.DtoProponente;

/**
 *
 * @author fran
 */
@WebServlet(name = "PerfilUsuario", urlPatterns = {"/PerfilUsuario"})
public class PerfilUsuario extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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
        
        
         String usrPerfil = request.getParameter("nick");
         String usrTipo = request.getParameter("tipo");
        try{
           if(!("").equals(usrPerfil)){
               if(!("").equals(usrTipo) && ("Proponente").equals(usrTipo)){
                DtoProponente p=portU.getDTOProponente(usrPerfil);
                request.setAttribute("infoPerfil", p);
                request.setAttribute("nick", usrPerfil);
                request.setAttribute("tipo", usrTipo);
                request.setAttribute("pagina", "Perfil");
                request.getRequestDispatcher("/perfilUsuario.jsp").forward(request, response);
               }else{
                DtoColaborador c=portU.getDTOColaborador(usrPerfil);
                request.setAttribute("infoPerfil", c);
                request.setAttribute("nick", usrPerfil);
                request.setAttribute("tipo", usrTipo);
                request.setAttribute("pagina", "Perfil");
                request.getRequestDispatcher("/perfilUsuario.jsp").forward(request, response);
               
               }
               
           }
           
        }catch(Exception e){
            e.printStackTrace();
        }
    }

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   

}
