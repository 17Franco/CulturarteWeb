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

import webservices.ControllerWS;
import webservices.ControllerWS_Service;

/**
 *
 * @author fran
 */
@WebServlet(name = "SigueAUsuario", urlPatterns = {"/SigueAUsuario"})
public class SigueAUsuario extends HttpServlet {

   
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
    //contenido del input solo controla el input de registro
    String seguidor = request.getParameter("seguidor");
    String seguido = request.getParameter("seguido");

    boolean sigue = portU.sigueAUsuario(seguidor,seguido);

    // Devolver JSON simple
    response.setContentType("application/json");
    response.getWriter().write("{\"seguido\": " + sigue + "}");
}

  
  
}
