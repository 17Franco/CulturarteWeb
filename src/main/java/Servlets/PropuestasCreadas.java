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
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoPropuesta;

/**
 *
 * @author fran
 */
@WebServlet(name = "PropuestasCreadas", urlPatterns = {"/PropuestasCreadas"})
public class PropuestasCreadas extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         //Intanciando webService
        ControllerWS_Service service = new ControllerWS_Service();
        //controlador
        ControllerWS portU = service.getControllerWSPort(); 
        
         IController controller= Fabrica.getInstance().getController();
         String usrPerfil = request.getParameter("nick");
         String usrTipo = request.getParameter("tipo");
        try{
           if(!("").equals(usrPerfil)){
               //obtener favoritas del usuario
            List<DtoPropuesta> p=portU.getPropuestasCreadasPorProponente(usrPerfil);

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
