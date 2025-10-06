package Servlets;
import logica.DTO.DTOPropuesta;
import logica.DTO.DTOColaboracion;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.Set;
import logica.DTO.DTOColaborador;
import logica.DTO.TipoRetorno;
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

        response.setContentType("text/html;charset=UTF-8");
        String titulo = request.getParameter("id"); //Se obtiene el parámetro del titulo desde el jsp que muestra las propuestas.

        IController controller = Fabrica.getInstance().getController();
        DTOPropuesta propuestaSel = controller.getPropuestaDTO(titulo);
        
        HttpSession sesionActual = request.getSession(true);   //Se obtienen datos almacenados en la sesion.

        String nickUsr = "";
        

        if(sesionActual  != null) //Si sesión aun está online obtengo el nick de el usuario actual.
        {
            nickUsr = (String) sesionActual.getAttribute("logueado");
            
            if(nickUsr == null) //Si se trata de un invitado...
            {
                nickUsr = "VISITANTE";
            }    
        }
        boolean esFavorita = false;
        if (!nickUsr.equals("VISITANTE") && propuestaSel != null) {
            esFavorita = controller.esFavorita(nickUsr, propuestaSel.getTitulo());
        }
        int permisos = 0;   //Si es visitante, queda en 0

        String tipoUsuario = (String) sesionActual.getAttribute("tipoUser");
        
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
        }
        
        String estado = propuestaSel.getUltimoEstado().getEstado().toString();
        
        switch (estado) 
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
            request.setAttribute("estadoFormateado", estado);
            request.setAttribute("propuesta", propuestaSel);                                                //Se envian datos de la propuesta elegida al jsp.      
            request.setAttribute("permisos", permisos);                         //Se envia el tipo de permisos de usuario sobre prop al jsp.
            request.getRequestDispatcher("MostrarPropuesta_Colaborar.jsp").forward(request, response);         //Se envían datos a front y se redirige al user hacia la pagina de muestra.
        } 
        else 
        {
            //Al no existir sesión posiblemente, se envía la variable como request:
            request.setAttribute("mensaje_error", "ERROR, no se encontró la propuesta con el título: " + titulo + ". Revisar que se esté pasando bien el parámetro o que la funcion esté logrando encontrar esa propuesta");
            request.getRequestDispatcher("MostrarPropuesta_Colaborar.jsp").forward(request, response);        //Se muestra en pantalla el error
        }    
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        
        //RETORNOS AL FRONT en "resultadoOperacion":
        // 0: El usuario no hizo ningún cambio.
        // 1: Colaborador envía un comentario.
        // 2: Proponente cancela la propuesta.
        // 3: Proponente extiende financiación.
        // 4: Colaborador nuevo.
        
        int resultadoOperacion = 0;     //Esto notificará al jsp que todo salió bien y que tipo de transacción es...       
        HttpSession sesionActual = request.getSession(true);
        
        
        IController controller = Fabrica.getInstance().getController();

        String userNick = "";

        if (sesionActual != null) //Si sesión aun está online obtengo el nick de el usuario actual.
        {
            userNick = (String) sesionActual.getAttribute("logueado");

            if (userNick == null) //Si se trata de un invitado...
            {
                userNick = "VISITANTE";
            }
        }
        
        //Se almacenan datos provenientes del front
        String accionUsuario = request.getParameter("accion");  //Para saber que decició hacer el usuario.
        DTOPropuesta propuestaActual = controller.getPropuestaDTO(request.getParameter("tituloPropuesta"));     //Se usa el titulo obtenido del front para buscar la propuesta en la bd
        String montoStr = request.getParameter("monto"); 
        String tipo = request.getParameter("tipoRetorno");
        String comentario = request.getParameter("comentario");
        
        
        TipoRetorno retorno = null;
        
        //Seteo tipos de retorno.
        if(tipo != null)
        {
            if(tipo.equals("EntradaGratis"))     { retorno = TipoRetorno.EntradaGratis; }
            if(tipo.equals("PorcentajeGanancia")){ retorno = TipoRetorno.PorcentajeGanancia; }
        }

        
        int permisos = 0;   //Si es visitante, queda en 0
        String tipoUsuario = (String) sesionActual.getAttribute("tipoUser");

        if (userNick != null && tipoUsuario != null &&!userNick.equals("VISITANTE") && propuestaActual.getTitulo() != null) 
        {
            
            if(!propuestaActual.usuarioHaComentadoSN(userNick))
            {
                permisos = controller.accionSobrePropuesta(userNick, propuestaActual);  //Se obtienen permisos de usuario en propuesta.
            }
            
            if(permisos == 3 && tipoUsuario.equals("Proponente"))   //Esto es por si un proponente visita otras props...
            {
                permisos = 0;   //Le quito el permiso de colaborar, lo dejo por si más adelante se agrega que puede o algo así.
            }
            
        }
        
        
        //Si es proponente...
        if(permisos == 1)   
        {        
            //Se verifica que sea una propuesta de este proponente (esto puede ser pasado a una funcion en controller).
            Set<DTOPropuesta> temp = controller.getPropuestasCreadasPorProponente(userNick);
            
            for(DTOPropuesta ct : temp)
            {
                if(ct.nickProponenteToString().equals(userNick))
                {
                    resultadoOperacion = controller.extenderOCancelarPropuesta(accionUsuario,ct.getTitulo());
                    //resultado 3, logra extender, resultado 2, logra cancelar, 0, no sucedió nada.
                }
            }
        }  
    
        //Si es colaborador que ya colaboró...
        if(permisos == 2)
        {
            if(accionUsuario.equals("COMENTAR"))
            {
                if(controller.nuevoComentario(comentario,userNick,propuestaActual.getTitulo()))
                {
                    resultadoOperacion = 1; //Usuario logra comentar.
                }
                
            }   
        }
        
        //Si es colaborador que no colaboró aún y decide colaborar con la propuesta...
        if(permisos == 3) 
        {   
            if(accionUsuario.equals("COLABORAR"))
            {
                int monto = controller.string_A_Int_Con_verificacion(montoStr); //Aca se verifica que esté correcto el ingreso
                
                DTOColaborador usuarioActual = (DTOColaborador) controller.getDTOColaborador(userNick);
                DTOColaboracion nuevaColaboracion = new DTOColaboracion(retorno,monto,usuarioActual.getNickname(),propuestaActual.getTitulo(),LocalDate.now(),usuarioActual,propuestaActual);
                controller.altaColaboracion(nuevaColaboracion);    
                resultadoOperacion = 4;
            }
        }

        request.setAttribute("resultado", resultadoOperacion);
        
        switch (resultadoOperacion) 
        {
            case 1 : request.setAttribute("accionLograda", "Comentado en la propuesta"); break;
            case 2 : request.setAttribute("accionLograda", "Cancelado la propuesta"); break;
            case 3 : request.setAttribute("accionLograda", "Extendido la propuesta"); break;
            case 4 : request.setAttribute("accionLograda", "Colaborado en la propuesta"); break;
            default: request.setAttribute("accionLograda", "Error"); break;
        }
        
        request.getRequestDispatcher("resultadoAccion.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Muestra detalles de propuesta elegida por user";
    }// </editor-fold>

}
