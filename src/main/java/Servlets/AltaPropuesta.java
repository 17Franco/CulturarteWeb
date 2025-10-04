/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import logica.DTO.DTOCategoria;
import logica.DTO.DTOPropuesta;
import logica.DTO.Estado;
import logica.DTO.TipoRetorno;
import logica.Fabrica;
import logica.IController;
/**
 *
 * @author asus
 */
@MultipartConfig
@WebServlet(name = "AltaPropuesta", urlPatterns = {"/AltaPropuesta"})
public class AltaPropuesta extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        IController controller = Fabrica.getInstance().getController();
        List<DTOCategoria> categorias = controller.getCategorias();
        request.setAttribute("categorias", categorias);
        
        HttpSession sesion = request.getSession(false);
        if (sesion != null) {
            String exito = (String) sesion.getAttribute("exito");
            if (exito != null) {
                request.setAttribute("exito", exito);
                sesion.removeAttribute("exito");
            }
        }
        request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // caracteres especiales
        IController controller = Fabrica.getInstance().getController();
        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("logueado") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nick = (String) sesion.getAttribute("logueado");

        if (!controller.isProponente(nick)) {
            request.setAttribute("error", "Solo los proponentes pueden crear propuestas.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String imagen = request.getParameter("imagen");
        String lugar = request.getParameter("lugar");
        String fecha = request.getParameter("fecha");
        String precioStr = request.getParameter("precio");
        String montoTotalStr = request.getParameter("montoTotal");
        String categoria = request.getParameter("categoria");
        String[] retornoArr = request.getParameterValues("tipoRetorno");
       
        if (fecha == null || fecha.isEmpty()) {
            request.setAttribute("error", "Debe seleccionar una fecha.");
            request.setAttribute("categorias", controller.getCategorias());
            request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
            return;
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate fechaFormat = LocalDate.parse(fecha, formatter);
        
        int precio = 0;
        int montoTotal = 0;
        try {
            precio = Integer.parseInt(precioStr);
            montoTotal = Integer.parseInt(montoTotalStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Precio o monto total inválido.");
            request.setAttribute("categorias", controller.getCategorias());
            request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
            return;
        }
        List<TipoRetorno> retorno = new ArrayList<>();
        if (retornoArr != null) {
            for (String r : retornoArr) {
                if (r.equals("EntradaGratis")) {
                    retorno.add(TipoRetorno.EntradaGratis);
                } else if (r.equals("PorcentajeGanancia")) {
                    retorno.add(TipoRetorno.PorcentajeGanancia);
                }
            }
        }
        controller.altaPropuesta(titulo, descripcion, imagen, lugar, fechaFormat,precio, montoTotal, LocalDate.now(), retorno,categoria, nick, Estado.INGRESADA);

        sesion.setAttribute("exito", "Propuesta creada correctamente.");
        response.sendRedirect("AltaPropuesta");
    }
}
