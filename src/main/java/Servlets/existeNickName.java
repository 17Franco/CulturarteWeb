
package Servlets;

import Config.config;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URI;
import java.net.URL;
import logica.Fabrica;
import logica.IController;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;


@WebServlet(name="existeNickName", urlPatterns={"/existeNickName"})
public class existeNickName extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //intancia clase config (este me trae el archivo de configuracion)
        config conf = config.getInstance();
        //me traigo la ip desde el config.propertie
        String host = conf.getProps("WEB_SERVICES_HOST");
        //me traigo la port desde el config.propertie
        String port = conf.getProps("WEB_SERVICES_PORT");
        //servicio que quiero traer (manejamos solo uno igual)
        String serv = conf.getProps("SERVICE");
        //esto es para que si cambia la url del servicio solo modificamos el config y estaria
        
        //contruir url   
        String dir="http://"+host+":"+port+serv+"?wsdl";
        // convertir el String a URI 
        URI uri = URI.create(dir);
        // si el constructor de tu servicio acepta URL, convertís:
        URL url = uri.toURL();
        
        
        //Intanciando webService
        ControllerWS_Service service = new ControllerWS_Service(url);
        //controlador
        ControllerWS portU = service.getControllerWSPort(); 
        
        //intancia de fabrica y iController
        //IController controller= Fabrica.getInstance().getController();
        //contenido del input solo controla el input de registro
        String nickname = request.getParameter("vNickR");

        
        boolean existe = portU.existe(nickname);

        // Devolver JSON simple
        response.setContentType("application/json");
        response.getWriter().write("{\"existe\": " + existe + "}");
    }

}
