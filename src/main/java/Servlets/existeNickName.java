
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


@WebServlet("/existeNickName")
public class existeNickName extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //intancia de fabrica y iController
        IController controller= Fabrica.getInstance().getController();
        //contenido del input solo controla el input de registro
        String nickname = request.getParameter("vNickR");

        
        boolean existe = controller.existe(nickname);

        // Devolver JSON simple
        response.setContentType("application/json");
        response.getWriter().write("{\"existe\": " + existe + "}");
    }

}
