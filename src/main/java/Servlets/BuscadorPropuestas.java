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
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;

/**
 *
 * @author acer
 */
@WebServlet(name = "Buscador", urlPatterns = {"/Buscador"})
public class BuscadorPropuestas extends HttpServlet {
    
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String filtro = request.getParameter("filtro");
        String categoria = request.getParameter("categoria");

        List<webservices.DtoPropuesta> propuestas;
        if (categoria != null && !"".equals(categoria) ){
            propuestas = buscarPorCategoria(categoria);
        }else {
            if (filtro == null || filtro.isEmpty()) {
                filtro = "";
            }
            
            propuestas = buscarPorFiltro(filtro);
        }
        
        String orden = request.getParameter("orden");
        if (orden == null || orden.isEmpty() || "titulo".equals(orden)) {
                propuestas.sort(Comparator.comparing(webservices.DtoPropuesta::getFechaString).reversed());
        } else {
                propuestas.sort(Comparator.comparing(webservices.DtoPropuesta::getFechaString).reversed());
        }
                
        Map<String, List<webservices.DtoPropuesta>> propuestasMap = new HashMap<>();
        propuestasMap.put("Todas", propuestas);
        for (webservices.DtoPropuesta p : propuestas){
            if (!propuestasMap.containsKey(p.getEstadoAct().name())) {
                propuestasMap.put(p.getEstadoAct().name(), new ArrayList<>());
            }
            List<webservices.DtoPropuesta> porpuestasPorEstado = propuestasMap.get(p.getEstadoAct().name());
            porpuestasPorEstado.add(p);
            propuestasMap.put(p.getEstadoAct().name(), porpuestasPorEstado);
            
        }

        request.setAttribute("propuestasPorEstado", propuestasMap);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    private List<webservices.DtoPropuesta> buscarPorCategoria(String categoria){
        //IController controller = Fabrica.getInstance().getController();
        
        ControllerWS controllerPort = obtenerPuerto();
        
        List<webservices.DtoPropuesta> propuestas = new ArrayList<>();
        propuestas.addAll(controllerPort.obtenerPropuestaPorSubCategoria(categoria));
        return propuestas;
    }
    
    private List<webservices.DtoPropuesta> buscarPorFiltro(String filtro){// devuelve una lista de objetos propuesta (List<DTOPropuesta) y busca por filtro(string) propuesta
        //IController controller = Fabrica.getInstance().getController();
        
        ControllerWS controllerPort = obtenerPuerto();
        
        return controllerPort.buscarPropuestas(filtro);   //del controller llama a al metodo BuscarPropuesta( segun filtro filtro)     y devuelve esa lista 
    }
}