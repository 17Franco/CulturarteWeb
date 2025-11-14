package Servlets;

import Config.config;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.URI;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import logica.Colaboracion.GeneradorPDF;
import logica.DTO.DTOColaboracion;
import logica.Manejadores.ManejadorColaboracion;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;

@WebServlet("/GenerarConstancia")
public class GenerarConstancia extends HttpServlet {

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
        
          
        ControllerWS_Service service = new ControllerWS_Service(url);
        
        ControllerWS portU = service.getControllerWSPort(); 
        try {
            //obtengo la id desde el form
            Long idColaboracion = Long.parseLong(request.getParameter("idColaboracion"));

         

            // generar pdf desde la clase GeneradorPDF.java
           String pdfFile = portU.generarPDF(idColaboracion);

            if (pdfFile == null || "".equals(pdfFile)) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el PDF.");
                return;
            }
            byte[] pdfByte = Base64.getDecoder().decode(pdfFile);
            
            
            // conf Request http
            response.setContentType("application/pdf"); 
            response.setHeader("Content-Disposition", "inline; filename = documento.pdf");
            response.setContentLength(pdfByte.length);

            // se manda el pdf al navegador en uso
            try (ServletOutputStream out = response.getOutputStream()) {
              out.write(pdfByte);
              out.flush();
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Ocurrió un error al generar la constancia de pago.");
        }
       
    }  
}

