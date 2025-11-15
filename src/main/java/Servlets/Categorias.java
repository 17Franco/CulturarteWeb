/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Config.config;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URI;
import java.net.URL;
import java.util.Comparator;
import java.util.List;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;

@MultipartConfig
@WebServlet(name="Categorias", urlPatterns={"/Categorias"})
public class Categorias extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
       //IController controller= Fabrica.getInstance().getController();
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
        String dir = "http://" + host + ":" + port + serv + "?wsdl";
        // convertir el String a URI 
        URI uri = URI.create(dir);
        // si el constructor de tu servicio acepta URL, convertís:
        URL url = uri.toURL();

        ControllerWS_Service service = new ControllerWS_Service(url);

        ControllerWS portU = service.getControllerWSPort();
        
       List<webservices.DtoCategoria> categorias = portU.getCategorias();
       categorias.sort(Comparator.comparing(webservices.DtoCategoria::getNombreCategoria));
        request.setAttribute("categorias", categorias);
        
        
      //  request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    // traer todas las propuestas =  Set<DTOPropuesta> obtenerPropuestas(String estado);

}