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
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;

/**
 *
 * @author fran
 */
@WebServlet(name = "Img", urlPatterns = {"/Img"})
public class Img extends HttpServlet {

    
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
        
        ControllerWS_Service service = new ControllerWS_Service();
        
        ControllerWS portU = service.getControllerWSPort(); 
        
        
         String ruta = request.getParameter("ruta");
         String extension = ruta.substring(ruta.lastIndexOf(".") + 1).toLowerCase();//nesesito saber si es png o jpg
         String ext; //aca se guardara contentType segun sea la extencion
        try{
           if(!("").equals(ruta)){
               //DTOColaborador c=controller.getDTOColaborador(usrTipo);
               
                byte[] img=portU.getImg(ruta); //me  traigo el array de bytes de la img
                switch (extension) {
                    case "png":
                        ext = "image/png";
                        break;
                    case "jpg":
                        ext = "image/jpg";
                        break;
                    case "jpeg": 
                        ext = "image/jpg";
                        break;
                    default:
                        ext = "image/jpeg";
                        break;
                }

                response.setContentType(ext);//el tipo de contenido img o html o otra cosa
                response.setContentLength(img.length); //tamano del contenido
                response.getOutputStream().write(img);//write le transfiere cada byte de la img a el metodo getOutputStream() y este al navegador este ultimo interpretea y muestra           
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
