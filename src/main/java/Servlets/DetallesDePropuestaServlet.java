package Servlets;
import logica.DTO.DTOPropuesta;
import logica.DTO.Estado;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import logica.Fabrica;
import logica.IController;

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
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        
        String titulo = request.getParameter("id"); //Se obtiene el parámetro del titulo desde el jsp que muestra las propuestas.
        IController controller = Fabrica.getInstance().getController();
        HttpSession sesionActual = request.getSession(true);   //Se obtienen datos almacenados en la sesion.
        int permisos = 0;   //Si es visitante, queda en 0
        String tipoUsuario = (String) sesionActual.getAttribute("tipoUser");
        boolean esFavorita = false;

        String nickUsr = obtenerNickUsr(sesionActual);  //La función la dejé arriba del doGet.
        
        try
        {
            
            DTOPropuesta propuestaSel = controller.getPropuestaDTO(titulo);
            String estado = propuestaSel.getUltimoEstado().getEstado().toString();

            if (propuestaSel != null) 
            {
                esFavorita = controller.esFavorita(nickUsr, propuestaSel.getTitulo());
            }

            if( !nickUsr.equals("VISITANTE") && tipoUsuario != null)
            {
                if(!propuestaSel.usuarioHaComentadoSN(nickUsr))
                {
                    permisos = controller.accionSobrePropuesta(nickUsr, propuestaSel);  //Se obtienen permisos de usuario en propuesta.
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
            
            estado = Estado.formateoEstado(estado); //Se formatea el estado para ser mostrado en la propuesta

            if (propuestaSel != null && sesionActual != null)                       //Si no pasó nada raro se envían datos para que puedan ser mostrados.
            {
                request.setAttribute("esFavorita", esFavorita);
                request.setAttribute("estadoFormateado", estado);
                request.setAttribute("propuesta", propuestaSel);                                                //Se envian datos de la propuesta elegida al jsp.      
                request.setAttribute("permisos", permisos);                         //Se envia el tipo de permisos de usuario sobre prop al jsp.
                request.setAttribute("tipoUsuario",tipoUsuario);
                
                request.getRequestDispatcher("MostrarPropuesta_Colaborar.jsp").forward(request, response);         //Se envían datos a front y se redirige al user hacia la pagina de muestra.
            } 
            
        }
        catch (Exception e)
        {
            e.printStackTrace();
            request.setAttribute("mensaje_error", "Ha ocurrido un error, intentar de nuevo.");
            request.getRequestDispatcher("MostrarPropuesta_Colaborar.jsp").forward(request, response);  //Se muestra mensaje de error.-            
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
        IController controller = Fabrica.getInstance().getController();

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
            DTOPropuesta propuestaActual = controller.getPropuestaDTO(tituloProp);     //Se usa el titulo obtenido del front para buscar la propuesta en la bd

            int permisos = controller.permisosSobrePropuesta(userNick, tipoUsuario, propuestaActual); //Si es visitante, queda en 0...

            resultadoOperacion = controller.accionesSobrePropuesta(userNick,permisos,accionUsuario,comentario,propuestaActual,montoStr,tipoRetorno);    //Hará todo, devuelve el int con el codigo de lo resuelto o un error.
       
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
        catch (Exception e) 
        {
            e.printStackTrace();
            response.sendRedirect("DetallesDePropuesta?id=" + URLEncoder.encode(tituloProp, "UTF-8") + "&resultadoOperacion=" + URLEncoder.encode((String.valueOf(0)), "UTF-8") + "&accionLograda=" + URLEncoder.encode("Error", "UTF-8"));
        }


    }

    @Override
    public String getServletInfo() {
        return "Muestra detalles de propuesta elegida por user";
    }// </editor-fold>

}
