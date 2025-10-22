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
import java.util.Set;
import java.util.HashSet;
import logica.DTO.DTOPropuesta;
import logica.Fabrica;
import logica.IController;
import logica.DTO.Estado;

/**
 *
 * @author klaas
 */
@WebServlet(name = "ExtenderPropuestas", urlPatterns = {"/ExtenderPropuestas"})
public class ExtenderPropuestas extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {

        IController controller = Fabrica.getInstance().getController();
        String usrPerfil = request.getParameter("nick");
        String usrTipo = request.getParameter("tipo");
         
        try
        {
           if(!("").equals(usrPerfil))
           {
                
                Set<DTOPropuesta> props = controller.getPropuestasCreadasPorProponente(usrPerfil);

                Set<DTOPropuesta> p = new HashSet();

                for(DTOPropuesta ct : props)
                {

                    if(ct.getEstadoAct() == Estado.PUBLICADA || ct.getEstadoAct() == Estado.EN_FINANCIACION)
                    {
                        p.add(ct);
                    }
                }

                request.setAttribute("propuestasAExtender", p);
                request.setAttribute("nick", usrPerfil);
                request.setAttribute("tipo", usrTipo);
                request.setAttribute("pagina", "Extender");
                request.getRequestDispatcher("/ExtenderPropuesta.jsp").forward(request, response);
            
           }
           
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
