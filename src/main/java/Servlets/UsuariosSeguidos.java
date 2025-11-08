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
import logica.DTO.DTOColaborador;
import logica.DTO.DTOProponente;
import logica.DTO.DTOUsuario;
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoUsuario;

/**
 *
 * @author fran
 */
@WebServlet(name = "UsuariosSeguidos", urlPatterns = {"/UsuariosSeguidos"})
public class UsuariosSeguidos extends HttpServlet {

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
               
            List<DtoUsuario> p=portU.seguidos(usrPerfil);

            request.setAttribute("UsuariosSeguidos", p);
            request.setAttribute("nick", usrPerfil);
            request.setAttribute("tipo", usrTipo);
            request.setAttribute("pagina", "Seguidos");
            request.getRequestDispatcher("/UsuarioSeguidos.jsp").forward(request, response);
            
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
