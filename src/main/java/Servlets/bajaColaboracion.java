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
import logica.Fabrica;
import logica.IController;


@WebServlet(name = "bajaColaboracion", urlPatterns = {"/bajaColaboracion"})
public class bajaColaboracion extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
            IController controller= Fabrica.getInstance().getController();
            String id = request.getParameter("id");
            try {
                controller.CancelarColaboracion(Long.valueOf(id));
                
                response.getWriter().write("{\"resp\": " + true + "}");
            }catch(Exception e){
                 e.printStackTrace();
                 response.getWriter().write("{\"resp\": false, \"error\": \"" + e.getMessage() + "\"}");
                 
            }
   
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
   

}
