/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import logica.DTO.DTOPropuesta;
import logica.DTO.Estado;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author acer
 */
@WebServlet(name = "Buscador", urlPatterns = {"/Buscador"})
public class BuscadorPropuestas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String filtro = request.getParameter("filtro");
        String categoria = request.getParameter("categoria");

        request.setAttribute("mostrarEstados", false);
        List<DTOPropuesta> propuestas;
        if (categoria != null && !"".equals(categoria) ){
            propuestas = buscarPorCategoria(categoria);
        }else {
            if (filtro == null || filtro.isEmpty()) {
                filtro = "";
            }else {
                request.setAttribute("mostrarEstados", true);
            }
            propuestas = buscarPorFiltro(filtro);
        }
        
        String orden = request.getParameter("orden");
        if (orden == null || orden.isEmpty() || "titulo".equals(orden)) {
            propuestas.sort(Comparator.comparing(DTOPropuesta::getTitulo));
        } else {
            propuestas.sort(Comparator.comparingInt((DTOPropuesta p) -> p.getFecha().getYear()).reversed());
        }
                
        Map<Estado, List<DTOPropuesta>> propuestasMap = new HashMap<>();
        for (DTOPropuesta p : propuestas){
            if (!propuestasMap.containsKey(p.getEstado())) {
                propuestasMap.put(p.getEstado(), new ArrayList<>());
            }
            List<DTOPropuesta> porpuestasPorEstado = propuestasMap.get(p.getEstado());
            porpuestasPorEstado.add(p);
            propuestasMap.put(p.getEstado(), porpuestasPorEstado);
        }
        request.setAttribute("propuestas", propuestas);
        request.setAttribute("propuestasPorEstado", propuestasMap);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    private List<DTOPropuesta> buscarPorCategoria(String categoria) {
        IController controller = Fabrica.getInstance().getController();
        List<DTOPropuesta> propuestas = new ArrayList<>();
        propuestas.addAll(controller.ObtenerPropuestaPorSubCategoria(categoria));
        return propuestas;        
    }
    
    private List<DTOPropuesta> buscarPorFiltro(String filtro) {// devuelve una lista de objetos propuesta (List<DTOPropuesta) y busca por filtro(string) propuesta
        IController controller = Fabrica.getInstance().getController();
        return controller.BuscarPropuestas(filtro);   //del controller llama a al metodo BuscarPropuesta( segun filtro filtro)     y devuelve esa lista 
    }
}