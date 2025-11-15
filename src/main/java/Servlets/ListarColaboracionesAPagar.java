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
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoColaboracion;
import webservices.DtoPropuesta;
import webservices.Estado;

/**
 *
 * @author klaas
 */
@WebServlet(name = "ListarColaboracionesAPagar", urlPatterns = {"/ListarColaboracionesAPagar"})

public class ListarColaboracionesAPagar extends HttpServlet 
{
    
    private ControllerWS obtenerPuerto() {
        try {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");

            String dir = "http://" + host + ":" + port + serv + "?wsdl";
            URI uri = URI.create(dir);
            URL url = uri.toURL();

            ControllerWS_Service service = new ControllerWS_Service(url);
            return service.getControllerWSPort();
        } catch (MalformedURLException e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
    
    private List<DtoColaboracion> eliminarPropuestasCanceladas(List<DtoColaboracion> inputProp)
    {
        List<DtoColaboracion> temp = new ArrayList();
        ControllerWS controllerPort = obtenerPuerto();
        
        if(inputProp != null && !inputProp.isEmpty())           
        {
            for(DtoColaboracion input : inputProp)
            {
                DtoPropuesta temp1 = controllerPort.getPropuestaDTO(input.getPropuesta());
                
                if(!temp1.getEstadoAct().equals(Estado.CANCELADA))
                {
                    temp.add(input);
                }
                
            }
        }
        
        return temp;
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        processRequest(request, response);
    }
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        
        String uid = request.getParameter("nick");
        String tipoUsuario = request.getParameter("tipo");
        
        ControllerWS controllerPort = obtenerPuerto();
        
        if(!uid.isEmpty())
        {  
            List<DtoColaboracion> temp = controllerPort.colaboraciones(uid);
            List<DtoColaboracion> pendientesDePago = new ArrayList();
            temp = eliminarPropuestasCanceladas(temp);
            
            for(DtoColaboracion ct : temp)
            {
                if(ct.getColaborador().equals(uid) && ct.getDatosPago() == null)    //Si es el colaborador y si no ha pagado.
                {
                    pendientesDePago.add(ct);
                }
            }
            
            
            request.setAttribute("nick", uid);
            request.setAttribute("tipo", tipoUsuario);
            request.setAttribute("colaboracionesAPagar", pendientesDePago);
            request.setAttribute("pagina", "PagarColaboracion");
            request.getRequestDispatcher("/PagarColaboracion.jsp").forward(request, response);     
        }  
    }


}
