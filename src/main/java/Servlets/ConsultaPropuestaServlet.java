package Servlets;

import DataService.ConsultaPropuesta;
import logica.DTO.DTOPropuesta;
import java.util.Set;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ConsultaPropuestaServlet", urlPatterns = {"/ConsultaPropuestaServlet"})

public class ConsultaPropuestaServlet extends HttpServlet 
{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain;charset=UTF-8");
        ConsultaPropuesta servicio = new ConsultaPropuesta();
        
        
        try (PrintWriter out = response.getWriter()) 
        {
                        
            Set<DTOPropuesta> propuestas = servicio.obtenerPropuestas(1);   //Se reciben todas las prop menos las de estado "INGRESADA"
    
            for(DTOPropuesta ct : propuestas)
            {
               out.print(ct.getTitulo() + "|" + ct.getDescripcion() + "|" + ct.getLugar() + "///"); 
               // | Separa entre los elementos de la misma propuesta, y /// separa entre propuestas.
            }
            
            //Por ahora no se si es necesario enviar líneas HTML por acá.
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
