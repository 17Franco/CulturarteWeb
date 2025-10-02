package Servlets;

import logica.DTO.DTOPropuesta;
import java.util.Set;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import logica.Fabrica;
import logica.IController;

@WebServlet(name = "ConsultaPropuestaServlet", urlPatterns = {"/ConsultaPropuestas"})

public class ConsultaPropuestaServlet extends HttpServlet 
{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
       
        response.setContentType("text/html;charset=UTF-8");
        
        IController controller = Fabrica.getInstance().getController();
        
        Set<DTOPropuesta> propuestas = controller.obtenerPropuestasExceptoINGRESADAS();   //Se reciben todas las prop menos las de estado "INGRESADA"
        
        request.setAttribute("propuestas", propuestas);

        
        String tituloSeleccionadoDesdeCliente = request.getParameter("tituloProp"); //Recibe la propuesta seleccionada desde el jsp


        if (tituloSeleccionadoDesdeCliente != null && !tituloSeleccionadoDesdeCliente.isEmpty()) 
        {
            //Se redirige al siguiente servlet cuando se seleccione una prop enviandole el titulo de la prop seleccionada.
            response.sendRedirect("DetallesDePropuesta?tituloProp=" + URLEncoder.encode(tituloSeleccionadoDesdeCliente, "UTF-8"));
            return;
        }

        
        request.getRequestDispatcher("listaPropuestas.jsp").forward(request, response); //Se envia el set de propuestas al jsp
    }

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
