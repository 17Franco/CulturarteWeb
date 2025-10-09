/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import logica.DTO.DTOCategoria;
import logica.DTO.DTOPropuesta;
import logica.DTO.Estado;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author acer
 */
@WebServlet(name = "Propuestas", urlPatterns = {"/Propuestas"})
public class Propuestas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String Subcategoria = request.getParameter("Subcategoria");

        IController controller = Fabrica.getInstance().getController();

        // Creamos un Set para guardar lo qeu se trae
        Set<DTOPropuesta> propuestas = new HashSet<>();
        if (!"".equals(Subcategoria)) {
             propuestas.addAll(controller.ObtenerPropuestaPorSubCategoria(Subcategoria));
        }else {
            propuestas.addAll(controller.obtenerPropuestas("PUBLICADA"));
            propuestas.addAll(controller.obtenerPropuestas("EN_FINANCIACION"));
            propuestas.addAll(controller.obtenerPropuestas("FINANCIADA"));
        }

        // Traer propuestas de cada estados siguientes
      //  
        

        request.setAttribute("propuestas", propuestas);
        if (!"".equals(Subcategoria)) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
         
    }}
