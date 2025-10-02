package Servlets;

import logica.DTO.DTOPropuesta;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author klaas
 */
@WebServlet(name = "DetallesDePropuestaServlet", urlPatterns = {"/DetallesDePropuesta"})
public class DetallesDePropuestaServlet extends HttpServlet 
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {

        response.setContentType("text/plain;charset=UTF-8");
        String titulo = request.getParameter("tituloProp"); //Se obtiene el parámetro del titulo desde el jsp que muestra las propuestas.

        IController controller = Fabrica.getInstance().getController();
        DTOPropuesta propuestaSel = controller.getPropuestaDTO(titulo);
        
        HttpSession dataDeSesion = request.getSession(false);   //Se obtienen datos de la sesion en curso.

        String usuario = null;

        if(dataDeSesion  != null) //Si la sesion aún existe...
        {
            usuario = (String) dataDeSesion.getAttribute("usuario"); //Esto es para saber que puede hacer el user en la propuesta.
        }

        int permisos = 0;   //Si no hay user, queda en 0

        if(usuario != null && propuestaSel != null)
        {
            permisos = controller.accionSobrePropuesta(usuario, propuestaSel);  //Se obtienen permisos de usuario en propuesta.
        }
        
        if (propuestaSel != null)   //Si no pasó nada raro se envían datos para que puedan ser mostrados.
        {
            request.setAttribute("propuesta", propuestaSel);        //Se envian datos de la propuesta elegida al jsp
            request.setAttribute("permisos", permisos);                 //Se envia el tipo de permisos de usuario sobre prop al jsp.
            request.getRequestDispatcher("detallePropuesta.jsp").forward(request, response);    //Se pasa al siguiente jsp
        } 
        else 
        {
            request.setAttribute("mensaje_error", "ERROR, no se encontró la propuesta con el título: " + titulo + ". Revisar que se esté pasando bien el parámetro o que la funcion esté logrando encontrar esa propuesta");
            request.getRequestDispatcher("detallePropuesta.jsp").forward(request, response);
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Muestra detalles de propuesta elegida por user";
    }// </editor-fold>

}
