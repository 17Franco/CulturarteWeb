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
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author asus
 */
@WebServlet("/FavoritoServlet")
public class FavoritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession sesion = request.getSession();
        String nickname = (String) sesion.getAttribute("logueado");
        String tituloPropuesta = request.getParameter("tituloPropuesta");
        String accion = request.getParameter("accion");

        IController controller = Fabrica.getInstance().getController();
        if ("agregar".equals(accion)) {
            controller.marcarComoFavorita(nickname, tituloPropuesta);
            request.setAttribute("accionLograda", "Agredada a Favorita");
            request.setAttribute("resultado", 1);
            request.getRequestDispatcher("resultadoAccion.jsp").forward(request, response);
        } else if ("quitar".equals(accion)) {
            controller.quitarFavorita(nickname, tituloPropuesta);
            request.setAttribute("accionLograda", "Se a removido de Favorita");
            request.setAttribute("resultado", 1);
            request.getRequestDispatcher("resultadoAccion.jsp").forward(request, response);
        }
        
        
    }

}
