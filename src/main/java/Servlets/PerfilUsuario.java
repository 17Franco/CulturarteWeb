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
import logica.DTO.DTOColaborador;
import logica.DTO.DTOProponente;
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoColaborador;
import webservices.DtoProponente;

/**
 *
 * @author fran
 */
@WebServlet(name = "PerfilUsuario", urlPatterns = {"/PerfilUsuario"})
public class PerfilUsuario extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Intanciando webService
        ControllerWS_Service service = new ControllerWS_Service();
        //controlador
        ControllerWS portU = service.getControllerWSPort(); 
        
        //IController controller= Fabrica.getInstance().getController();
         String usrPerfil = request.getParameter("nick");
         String usrTipo = request.getParameter("tipo");
        try{
           if(!("").equals(usrPerfil)){
               if(!("").equals(usrTipo) && ("Proponente").equals(usrTipo)){
                DtoProponente p=portU.getDTOProponente(usrPerfil);
                request.setAttribute("infoPerfil", p);
                request.setAttribute("nick", usrPerfil);
                request.setAttribute("tipo", usrTipo);
                request.setAttribute("pagina", "Perfil");
                request.getRequestDispatcher("/perfilUsuario.jsp").forward(request, response);
               }else{
                DtoColaborador c=portU.getDTOColaborador(usrPerfil);
                request.setAttribute("infoPerfil", c);
                request.setAttribute("nick", usrPerfil);
                request.setAttribute("tipo", usrTipo);
                request.setAttribute("pagina", "Perfil");
                request.getRequestDispatcher("/perfilUsuario.jsp").forward(request, response);
               
               }
               
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
