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
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.List;
import Config.config;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoPago;
import webservices.DtoColaboracion;

/**
 *
 * @author klaas
 */
@WebServlet(name = "PagarColaboracion", urlPatterns = {"/PagarColaboracion"})
public class PagarColaboracion extends HttpServlet 
{
    
    private DtoColaboracion buscarColaboracion(List<DtoColaboracion> in, String tituloPropuesta) 
    {
        for (DtoColaboracion ct : in) 
        {
            if (ct.getPropuesta().equals(tituloPropuesta)) 
            {
                return ct;
            }
        }
        
        return null;
    }
    
    private ControllerWS obtenerPuerto() 
    {
        try 
        {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");

            String dir = "http://" + host + ":" + port + serv + "?wsdl";
            URI uri = URI.create(dir);
            URL url = uri.toURL();

            ControllerWS_Service service = new ControllerWS_Service(url);
            return service.getControllerWSPort();
        } 
        catch (MalformedURLException e) 
        {
            throw new RuntimeException(e.getMessage(), e);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession sesionActual = request.getSession(false);
        
        if (sesionActual == null || sesionActual.getAttribute("logueado") == null) 
        {   //Por si la sesión se cierra
            response.sendRedirect("login.jsp");
            return;
        }

        ControllerWS controllerPort = obtenerPuerto();

        String nickUsr = (String) sesionActual.getAttribute("logueado");
        String tituloPropuesta = request.getParameter("tituloPropuesta");
        int monto = Integer.parseInt(request.getParameter("monto"));
        String formaPago = request.getParameter("formaPago");
        
        //La info sobre estos datos está en DtoPago y la clase Pago.
        String dato1 = request.getParameter("dato1");   
        String dato2 = request.getParameter("dato2");
        String dato3 = request.getParameter("dato3");
        String dato4 = request.getParameter("dato4");
        String dato5 = request.getParameter("dato5");
        
        List<DtoColaboracion> colab = controllerPort.colaboraciones(nickUsr);
        DtoColaboracion colabEncontrada = buscarColaboracion(colab,tituloPropuesta);

        boolean pagoExitoso = false;
        
        DtoPago datosPago = new DtoPago();
        
        datosPago.setMonto(monto);
        datosPago.setFormaPago(formaPago);
        datosPago.setDato1(dato1);
        datosPago.setDato2(dato2);
        datosPago.setDato3(dato3);
        datosPago.setDato4(dato4);
        datosPago.setDato5(dato5);
        
        
        if (colabEncontrada != null) 
        {
            if(monto >= colabEncontrada.getMonto()) //Si el pago es mayor o igual al que figura en la colaboración.
            {
                pagoExitoso = controllerPort.acreditarColaboracion(colabEncontrada.getId(), datosPago);
            }
        }


        String accionLograda = "";
        int resultadoOperacion = 0;
        
        if(pagoExitoso == true)
        {
           accionLograda = "acreditado el pago en";
           resultadoOperacion = 5;
        }
        
        if(pagoExitoso == false)
        {
            accionLograda = "Error";
        }

        response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(tituloPropuesta, "UTF-8") + "&resultadoOperacion=" + resultadoOperacion + "&accionLograda=" + URLEncoder.encode(accionLograda, "UTF-8"));
        
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PagarColaboracion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PagarColaboracion at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        HttpSession sesionActual = request.getSession(false);
        
        if (sesionActual == null || sesionActual.getAttribute("logueado") == null) 
        {   //Por si la sesión se cierra
            response.sendRedirect("login.jsp");
            return;
        }
        
        ControllerWS controllerPort = obtenerPuerto();

        String nickUsr = (String) sesionActual.getAttribute("logueado");
        String tituloPropuesta = request.getParameter("tituloPropuesta");
        
        List<DtoColaboracion> colab = controllerPort.colaboraciones(nickUsr);
        
        DtoColaboracion colabEncontrada = buscarColaboracion(colab,tituloPropuesta);
        
        if(colabEncontrada != null)
        {
            request.setAttribute("colaboracion", colabEncontrada);
            request.getRequestDispatcher("pago.jsp").forward(request, response);
        } 
        else 
        {
            response.sendRedirect("DetallesDePropuesta?tituloPropuesta=" + URLEncoder.encode(tituloPropuesta, "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() 
    {
        return "Odio html y todo lo que se le parezca";
    }

}
