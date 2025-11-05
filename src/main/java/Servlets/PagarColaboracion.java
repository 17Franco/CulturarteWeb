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
import java.time.LocalDateTime;
import java.util.List;
import logica.DTO.DTOColaboracion;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author klaas
 */
@WebServlet(name = "PagarColaboracion", urlPatterns = {"/PagarColaboracion"})
public class PagarColaboracion extends HttpServlet 
{
    
    private DTOColaboracion buscarColaboracion(List<DTOColaboracion> in, String tituloPropuesta) 
    {
        for (DTOColaboracion ct : in) 
        {
            if (ct.getPropuesta().equals(tituloPropuesta)) 
            {
                return ct;
            }
        }
        
        return null;
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {

        HttpSession sesionActual = request.getSession(false);
        IController controller = Fabrica.getInstance().getController();

        String nickUsr = (String) sesionActual.getAttribute("logueado");
        String tituloPropuesta = request.getParameter("tituloPropuesta");
        int monto = Integer.parseInt(request.getParameter("monto"));
        
        List<DTOColaboracion> colab = controller.colaboraciones(nickUsr);
        DTOColaboracion colabEncontrada = buscarColaboracion(colab,tituloPropuesta);

        boolean pagoExitoso = false;
        
        if (colabEncontrada != null) 
        {
            if(monto >= colabEncontrada.getMonto()) //Si el pago es mayor o igual al que figura en la colaboración.
            {
                pagoExitoso = controller.acreditarColaboracion(colabEncontrada.getId());
            }
        }

        
        // Guardamos un mensaje para el JSP
        String accionLograda = pagoExitoso ? "Acreditado el pago en" : "Error";
        request.setAttribute("resultadoOperacion", pagoExitoso ? 5 : 0);
        request.setAttribute("accionLograda", accionLograda);
        request.setAttribute("tituloPropuesta", tituloPropuesta);

        // En lugar de sendRedirect, hacemos forward al servlet de detalles
        request.getRequestDispatcher("/DetallesDePropuesta").forward(request, response);
        
//        if(pagoExitoso) 
//        {
//            request.setAttribute("id", tituloPropuesta);
//            request.getRequestDispatcher("/DetallesDePropuesta").forward(request, response);
//            
//            //response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(tituloPropuesta, "UTF-8") + "&resultadoOperacion=" + URLEncoder.encode((String.valueOf(5)), "UTF-8") + "&accionLograda=" + URLEncoder.encode("Acreditado el pago en", "UTF-8"));
//            //response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(tituloPropuesta, "UTF-8") + "&accionLograda=acreditado");
//
//        } 
//        else 
//        {
//            response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(tituloPropuesta, "UTF-8") + "&resultadoOperacion=" + URLEncoder.encode((String.valueOf(0)), "UTF-8") + "&accionLograda=" + URLEncoder.encode("Error", "UTF-8"));
//            //response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(tituloPropuesta, "UTF-8") + "&accionLograda=Error");
//        }
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
         IController controller = Fabrica.getInstance().getController();

        String nickUsr = (String) sesionActual.getAttribute("logueado");
        String tituloPropuesta = request.getParameter("tituloPropuesta");
        
        List<DTOColaboracion> colab = controller.colaboraciones(nickUsr);
        
        DTOColaboracion colabEncontrada = buscarColaboracion(colab,tituloPropuesta);
        
        if(colabEncontrada != null)
        {
            request.setAttribute("colaboracion", colabEncontrada);
            request.getRequestDispatcher("pago.jsp").forward(request, response);
        } 
        else 
        {
            response.sendRedirect("DetallesDePropuesta?tituloPropuesta=" + URLEncoder.encode(tituloPropuesta, "UTF-8") + "&accionLograda=Error");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
