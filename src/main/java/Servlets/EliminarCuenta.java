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
import logica.Fabrica;
import logica.IController;


@WebServlet(name = "EliminarCuenta", urlPatterns = {"/EliminarCuenta"})
public class EliminarCuenta extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        IController controller= Fabrica.getInstance().getController();
        
        String nick = request.getParameter("NickName");
        
        try{
            if(controller.existe(nick)){
                if(controller.eliminarProponente(nick)){
                    HttpSession session = request.getSession(false); // no crear si no existe

                    if (session != null) {
                        session.invalidate();
                    }
                    response.getWriter().write("{\"resp\": " + true + "}");
                }else{
                    response.getWriter().write("{\"resp\": " + false + "}");
                }
                
                
                
                
            }else{
            
                response.getWriter().write("{\"resp\": " + false + "}");
            }
            
        }catch(IOException e){
            response.getWriter().write("{\"resp\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
