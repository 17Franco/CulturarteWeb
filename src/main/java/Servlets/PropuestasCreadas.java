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
import java.util.List;
import java.util.Set;
import logica.DTO.DTOPropuesta;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author fran
 */
@WebServlet(name = "PropuestasCreadas", urlPatterns = {"/PropuestasCreadas"})
public class PropuestasCreadas extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         IController controller= Fabrica.getInstance().getController();
         String usrPerfil = request.getParameter("nick");
         String usrTipo = request.getParameter("tipo");
        try{
           if(!("").equals(usrPerfil)){
               //obtener favoritas del usuario
            Set<DTOPropuesta> p=controller.getPropuestasCreadasPorProponente(usrPerfil);

            request.setAttribute("propuestasCreadas", p);
            request.setAttribute("nick", usrPerfil);
            request.setAttribute("tipo", usrTipo);
            request.setAttribute("pagina", "Creadas");
            request.getRequestDispatcher("/PropuestasCreadas.jsp").forward(request, response);
            
           }
           
        }catch(Exception e){
            e.printStackTrace();
        }
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
  

}
