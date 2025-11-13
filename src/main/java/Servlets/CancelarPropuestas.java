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
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import webservices.DtoPropuesta;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.Estado;

/**
 *
 * @author klaas
 */
@WebServlet(name = "CancelarPropuestas", urlPatterns = {"/CancelarPropuestas"})
public class CancelarPropuestas extends HttpServlet {

    private ControllerWS obtenerPuerto() 
    {    
        try 
        {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");

            String dir = "http://" + host + ":" + port + serv + "?wsdl";
            URI uri = URI.create(dir);
            URL url = uri.toURL();

            ControllerWS_Service service = new ControllerWS_Service(url);
            return service.getControllerWSPort();
        } 
        catch (MalformedURLException e) 
        {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {

        String usrPerfil = request.getParameter("nick");
        String usrTipo = request.getParameter("tipo");
         
         
        ControllerWS controllerPort = obtenerPuerto();
         
        try
        {
           if(!("").equals(usrPerfil))
           {
                
                List<DtoPropuesta> props = controllerPort.getPropuestasCreadasPorProponente(usrPerfil);

                List<DtoPropuesta> p = new ArrayList();

                for(DtoPropuesta ct : props)
                {

                    if(ct.getEstadoAct() == Estado.FINANCIADA)
                    {
                        p.add(ct);
                    }
                }

                request.setAttribute("propuestasACancelar", p);
                request.setAttribute("nick", usrPerfil);
                request.setAttribute("tipo", usrTipo);
                request.setAttribute("pagina", "Cancelar");
                request.getRequestDispatcher("/CancelarPropuesta.jsp").forward(request, response);
            
           }
           
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
