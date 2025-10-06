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
import java.net.URLEncoder;
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
        } else if ("quitar".equals(accion)) {
            controller.quitarFavorita(nickname, tituloPropuesta);
            request.setAttribute("accionLograda", "Se a removido de Favorita");
        }
        response.sendRedirect("DetallesDePropuesta?id="+ URLEncoder.encode(tituloPropuesta, "UTF-8"));
    }

}
