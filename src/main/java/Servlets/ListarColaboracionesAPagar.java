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
import java.util.ArrayList;
import java.util.List;
import logica.DTO.DTOColaboracion;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author klaas
 */
@WebServlet(name = "ListarColaboracionesAPagar", urlPatterns = {"/ListarColaboracionesAPagar"})

public class ListarColaboracionesAPagar extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        
        String uid = request.getParameter("nick");
        String tipoUsuario = request.getParameter("tipo");

        if(!uid.isEmpty())
        {  
            IController controller= Fabrica.getInstance().getController();
            List<DTOColaboracion> temp = controller.colaboraciones(uid);
            List<DTOColaboracion> pendientesDePago = new ArrayList();
            
            for(DTOColaboracion ct : temp)
            {
                if(ct.getColaborador().equals(uid) && ct.getDatosPago() == null)    //Si es el colaborador y si no ha pagado.
                {
                    pendientesDePago.add(ct);
                }
            }
            
            
            request.setAttribute("nick", uid);
            request.setAttribute("tipo", tipoUsuario);
            request.setAttribute("colaboracionesAPagar", pendientesDePago);
            request.setAttribute("pagina", "Colaboraciones");
            request.getRequestDispatcher("/PagarColaboracion.jsp").forward(request, response);     
        }  
    }

}
