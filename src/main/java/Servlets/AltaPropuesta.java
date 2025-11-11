package Servlets;

import Config.config;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URI;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
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
        
        try {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");
            String dir = "http://" + host + ":" + port + serv + "?wsdl";

            URL url = URI.create(dir).toURL();
            ControllerWS_Service service = new ControllerWS_Service(url);
            ControllerWS portU = service.getControllerWSPort();

            List<webservices.DtoCategoria> categorias = portU.getCategorias();
            request.setAttribute("categorias", categorias);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al obtener categorías: " + e.getMessage());
        }
        
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
        
        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("logueado") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nick = (String) sesion.getAttribute("logueado");

        try {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");
            String dir = "http://" + host + ":" + port + serv + "?wsdl";

            URL url = URI.create(dir).toURL();
            ControllerWS_Service service = new ControllerWS_Service(url);
            ControllerWS portU = service.getControllerWSPort();

            if (!portU.isProponente(nick)) 
            {
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

            if (fecha == null || fecha.isEmpty()) 
            {
                request.setAttribute("error", "Debe seleccionar una fecha.");
                request.setAttribute("categorias", portU.getCategorias());
                request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
                return;
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate fechaFormat = LocalDate.parse(fecha, formatter);
            
            int precio, montoTotal;
            try {
                precio = Integer.parseInt(precioStr);
                montoTotal = Integer.parseInt(montoTotalStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Precio o monto total inválido.");
                request.setAttribute("categorias", portU.getCategorias());
                request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
                return;
            }
            if (retornoArr == null || retornoArr.length == 0) {
                request.setAttribute("error", "Debe seleccionar un Retorno.");
                request.setAttribute("categorias", portU.getCategorias());
                request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
                return;
            }

            List<webservices.TipoRetorno> listaRetornos = new ArrayList<>();
            
            for (String r : retornoArr) {
                if (r.equals("EntradaGratis")) {
                    listaRetornos.add(webservices.TipoRetorno.ENTRADA_GRATIS);
                } else if (r.equals("PorcentajeGanancia")) {
                    listaRetornos.add(webservices.TipoRetorno.PORCENTAJE_GANANCIA);
                }
            }

            if (categoria == null || categoria.isEmpty()) {
                request.setAttribute("error", "Debe seleccionar una Categoria.");
                request.setAttribute("categorias", portU.getCategorias());
                request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
                return;
            }
            portU.altaPropuesta(titulo,descripcion,imagen,lugar,fechaFormat.toString(),precio,montoTotal,LocalDate.now().toString(),listaRetornos,categoria,nick,webservices.Estado.INGRESADA);

            sesion.setAttribute("exito", "Propuesta creada correctamente.");
            response.sendRedirect("AltaPropuesta");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al crear la propuesta: " + e.getMessage());
            request.getRequestDispatcher("/AltaPropuesta.jsp").forward(request, response);
        }
    }   
}
