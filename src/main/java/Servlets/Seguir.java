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
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author fran
 */
@WebServlet(name = "Seguir", urlPatterns = {"/Seguir"})
public class Seguir extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //intancia de fabrica y iController
        IController controller= Fabrica.getInstance().getController();
        //contenido del input solo controla el input de registro
        String seguidor = request.getParameter("seguidor");
        String seguido = request.getParameter("seguido");
        
        boolean sigue = controller.seguir(seguidor,seguido);

        // Devolver JSON simple
        response.setContentType("application/json");
        response.getWriter().write("{\"resp\": " + sigue + "}");
    }

  
}
