package DataService;
import logica.DTO.DTOPropuesta;
import logica.DTO.DTOColaboracion;
import persistencia.ManejadorPropuesta;
import java.util.HashSet;
import java.util.Set;
import java.util.List;

public class ConsultaPropuesta 
{
    public Set<DTOPropuesta> obtenerPropuestas(int opcion)
    {
        //1: almacena todo menos propuestas "INGRESADA"
        //2: almacena y envía todas las propuestas.
        
        ManejadorPropuesta MProp = ManejadorPropuesta.getinstance();
        Set<DTOPropuesta> temp = MProp.obtenerPropuestas("");
        Set<DTOPropuesta> temp2 = new HashSet<>();
        
        if(opcion == 1)
        {
            for (DTOPropuesta ct : temp)
            {
                if( !(ct.getUltimoEstado().getEstadoString().equals("INGRESADA")) ) //Si la propuesta no son "INGRESADA"
                {
                    temp2.add(ct);
                }
            }
        }
        
        if(opcion == 2)
        {
            return temp;
        }
        
        return temp2;
    }
        
    public DTOPropuesta enviarPropuesta(String propuestaSel)
    {
        ManejadorPropuesta MProp = ManejadorPropuesta.getinstance();
        Set<DTOPropuesta> temp = MProp.obtenerPropuestas("");
        
        for (DTOPropuesta ct : temp)
        {
            if(ct.getTitulo().equals(propuestaSel))
            {
                return ct;  //Propuesta encontrada se envía como DTO a Servlet
            }
        }
        
        //Pongo mensaje de error para poder arreglar cualquier bug mas rápido...
        System.out.print("\nACAA ERROR, la propuesta elegida no se encontró, revisar el pasaje del String desde servlet o desde el cliente: " + propuestaSel + " \n");
        return null;    //Igual no debería llegar acá
        
    }
    
    public int accionSobrePropuesta(String nickUsuario, DTOPropuesta propuestaSel) 
    {  
        //Permite habilitar botones en cliente:
        //Retorna:  
        //          1: El usuario es proponente.
        //          2: El usuario es colaborador.
        //          3: El usuario no ha participado aún en la propuesta.
        
        if(propuestaSel.nickProponenteToString().equals(nickUsuario))   //Si es proponente
        {
            
            return 1;
        }
        else
        {
            List<DTOColaboracion> t1 = propuestaSel.getAporte();
            
            for(DTOColaboracion ct : t1)
            {
                if(ct.getColaborador().equals(nickUsuario)) //Si es colaborador
                {
                    
                    return 2;
                }
            
            }
        }
        
        
        
        return 3;   //Si no es ninguno de los dos.
    }
    
}
