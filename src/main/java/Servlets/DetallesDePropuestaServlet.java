package Servlets;
import Config.config;
import webservices.DtoPropuesta;
import webservices.Comentario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import logica.DTO.DTOColaboracion;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoColaboracion;

/**
 *
 * @author klaas
 */
@WebServlet(name = "DetallesDePropuestaServlet", urlPatterns = {"/DetallesDePropuesta"})

public class DetallesDePropuestaServlet extends HttpServlet 
{
    private String obtenerNickUsr(HttpSession sesionActual)
    {   //Obtengo el nick del user desde la sesión.
        
        String nickUsr = "";
        
        if(sesionActual  != null) //Si sesión aun está online obtengo el nick de el usuario actual.
        {
            nickUsr = (String) sesionActual.getAttribute("logueado");
            
            if(nickUsr == null) //Si se trata de un invitado...
            {
                nickUsr = "VISITANTE";
            }    
        }
        
        return nickUsr;
    }
        private ControllerWS obtenerPuerto() 
    {    
        try 
        {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");

            String dir = "http://" + host + ":" + port + serv + "?wsdl";
            URI uri = URI.create(dir);
            URL url = uri.toURL();

            ControllerWS_Service service = new ControllerWS_Service(url);
            return service.getControllerWSPort();
        } 
        catch (MalformedURLException e) 
        {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        
        String titulo = request.getParameter("id"); //Se obtiene el parámetro del titulo desde el jsp que muestra las propuestas.
        ControllerWS controllerPort = obtenerPuerto();
        
        HttpSession sesionActual = request.getSession(true);   //Se obtienen datos almacenados en la sesion.
        int permisos = 0;   //Si es visitante, queda en 0
        String tipoUsuario = (String) sesionActual.getAttribute("tipoUser");
        boolean esFavorita = false;

        String nickUsr = obtenerNickUsr(sesionActual);  //La función la dejé arriba del doGet.
        
        try
        {
            
            DtoPropuesta propuestaSel = controllerPort.getPropuestaDTO(titulo);
            String estado = propuestaSel.getEstadoAct().toString();

            if (propuestaSel != null) 
            {
                esFavorita = controllerPort.esFavorita(nickUsr, propuestaSel.getTitulo());
            }

            if( !nickUsr.equals("VISITANTE") && tipoUsuario != null)
            {
                boolean usuarioHaComentado = false;
                
                for(Comentario ct : propuestaSel.getComentarios())
                {
                    if(ct.getNickUsuario().equals(nickUsr))
                    {
                        usuarioHaComentado = true;
                    }
                }
                
                if(usuarioHaComentado == false) //Tuve que traerme esta función desde controller por que SOAP no me permite mandarle los datos que necesita
                {
                    permisos = controllerPort.accionSobrePropuesta(nickUsr, propuestaSel.getTitulo());
                }
                
                if(permisos == 3 && tipoUsuario.equals("Proponente"))   //Esto es por si un proponente visita otras props...
                {
                    permisos = 0;   //Le quito el permiso de colaborar, lo dejo por si más adelante se agrega que puede o algo así.
                }
                
                if(estado.equals("CANCELADA"))
                {
                    permisos = 0;   //quito permisos a cualquier usuario que por alguna razón pueda acceder a una propuesta con estado "CANCELADA"
                }
                
            }
            
        switch(estado) //Se formatea el estado para ser mostrado en la propuesta
        {
            case "INGRESADA":estado= " Ingresada";break;
            case "PUBLICADA":estado= " Publicada";break;
            case "EN_FINANCIACION":estado= " En financiación";break;
            case "FINANCIADA":estado= " Financiada";break;
            case "NO_FINANCIADA":estado= " No financiada";break;
            case "CANCELADA":estado= " Cancelada";break;
            default:estado= " Desconocido";break;
        }
            
            


            if (propuestaSel != null && sesionActual != null)                       //Si no pasó nada raro se envían datos para que puedan ser mostrados.
            {
                request.setAttribute("esFavorita", esFavorita);
                request.setAttribute("estadoFormateado", estado);
                request.setAttribute("propuesta", propuestaSel);                                                //Se envian datos de la propuesta elegida al jsp.      
                request.setAttribute("permisos", permisos);                         //Se envia el tipo de permisos de usuario sobre prop al jsp.
                request.setAttribute("tipoUsuario",tipoUsuario);
                
                request.getRequestDispatcher("/MostrarPropuesta_Colaborar.jsp").forward(request, response);         //Se envían datos a front y se redirige al user hacia la pagina de muestra.
            } 
            
        }
        catch (ServletException | IOException e)
        {
            request.setAttribute("mensaje_error", "Ha ocurrido un error, intentar de nuevo.");
            request.getRequestDispatcher("/MostrarPropuesta_Colaborar.jsp").forward(request, response);  //Se muestra mensaje de error.-            
        }
  
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        
        //RETORNOS AL FRONT en "resultadoOperacion":
        // 0: El usuario no hizo ningún cambio
        // 1: Colaborador envía un comentario.
        // 2: Proponente cancela la propuesta.
        // 3: Proponente extiende financiación.
        // 4: Colaborador nuevo.
        
        int resultadoOperacion;     //Esto notificará al jsp que todo salió bien y que tipo de transacción es...       
        HttpSession sesionActual = request.getSession(true);
        ControllerWS controllerPort = obtenerPuerto();

        String userNick = obtenerNickUsr(sesionActual);  //La función la dejé arriba del doGet.
        
        //Se almacenan datos provenientes del front
        String accionUsuario = request.getParameter("accion");  //Para saber que decició hacer el usuario.
        String tituloProp = request.getParameter("tituloPropuesta");
        String montoStr = request.getParameter("monto"); 
        String tipoRetorno = request.getParameter("tipoRetorno");
        String comentario = request.getParameter("comentario");
        String tipoUsuario = (String) sesionActual.getAttribute("tipoUser");

        
        try
        {
            DtoPropuesta propuestaActual = controllerPort.getPropuestaDTO(tituloProp);     //Se usa el titulo obtenido del front para buscar la propuesta en la bd

            int permisos = controllerPort.permisosSobrePropuesta(userNick, tipoUsuario, propuestaActual.getTitulo()); //Si es visitante, queda en 0...

            resultadoOperacion = controllerPort.accionesSobrePropuesta(userNick,permisos,accionUsuario,comentario,propuestaActual.getTitulo(),montoStr,tipoRetorno);    //Hará todo, devuelve el int con el codigo de lo resuelto o un error.
       
            String accionLograda;
        
            switch (resultadoOperacion) 
            {
                case 1 : accionLograda = "comentado en";    break;
                case 2 : accionLograda = "cancelado";       break;
                case 3 : accionLograda = "extendido";       break;
                case 4 : accionLograda = "colaborado en";   break;
                default: accionLograda = "Error";           break;
            }

            response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(propuestaActual.getTitulo(), "UTF-8") + "&resultadoOperacion=" + URLEncoder.encode((String.valueOf(resultadoOperacion)), "UTF-8") + "&accionLograda=" + URLEncoder.encode(accionLograda, "UTF-8"));
        }
        catch (IOException e) 
        {
            response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(tituloProp, "UTF-8") + "&resultadoOperacion=" + URLEncoder.encode((String.valueOf(0)), "UTF-8") + "&accionLograda=" + URLEncoder.encode("Error", "UTF-8"));
        }


    }

    @Override
    public String getServletInfo() {
        return "Muestra detalles de propuesta elegida por user";
    }// </editor-fold>

}
