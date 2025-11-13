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
import jakarta.servlet.http.HttpSession;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
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

        try {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");
            String dir = "http://" + host + ":" + port + serv + "?wsdl";

            URL url = URI.create(dir).toURL();
            ControllerWS_Service service = new ControllerWS_Service(url);
            ControllerWS portU = service.getControllerWSPort();
        
        if ("agregar".equals(accion)) {
            //portU.marcarComoFavorita(nickname, tituloPropuesta);
            request.setAttribute("accionLograda", "Agredada a Favorita");
        } else if ("quitar".equals(accion)) {
            //portU.quitarFavorita(nickname, tituloPropuesta);
            request.setAttribute("accionLograda", "Se a removido de Favorita");
        }
        response.sendRedirect("DetallesDePropuesta?id="+ URLEncoder.encode(tituloPropuesta, "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }       
}
