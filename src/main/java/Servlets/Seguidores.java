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
import logica.DTO.DTOUsuario;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author fran
 */
@WebServlet(name = "Seguidores", urlPatterns = {"/Seguidores"})
public class Seguidores extends HttpServlet {

  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         IController controller= Fabrica.getInstance().getController();
         String usrPerfil = request.getParameter("nick");
         String usrTipo = request.getParameter("tipo");
        try{
           if(!("").equals(usrPerfil)){
               
            List<DTOUsuario> p=controller.getSeguidores(usrPerfil);

            request.setAttribute("Seguidores", p);
            request.setAttribute("nick", usrPerfil);
            request.setAttribute("tipo", usrTipo);
            request.setAttribute("pagina", "Seguidores");
            request.getRequestDispatcher("/Seguidores.jsp").forward(request, response);
            
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
