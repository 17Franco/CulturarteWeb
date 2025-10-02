<%-- 
    Document   : detallePropuesta
    Created on : 2 oct 2025, 11:47:34
    Author     : klaas
--%>

<%@ page contentType="text/html;charset = UTF-8" %>
<%@ page import="logica.DTO.DTOPropuesta" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title> Detalles de la propuesta: </title>
    </head>
    <body>

        <%
            DTOPropuesta propuesta = (DTOPropuesta) request.getAttribute("propuesta");  //Obtengo datos de propuesta seleccionada
            int permisos = (Integer) request.getAttribute("permisos");  //Y tambi�n el codigo de permisos 

            String nivelPermiso;
            
            switch (permisos) //Seteo el string con el valor dependiendo de el int que llega.
            {
                case 1:  nivelPermiso = "Proponente";  break;   
                case 2:  nivelPermiso = "Colaborador"; break;
                case 3:  nivelPermiso = "Usuario";     break;
                default: nivelPermiso = "Invitado";    break;    //Este ser�a el caso 0, (lo dej� seteado como 0 cuando no existe usuario desde el servlet).       
            }
            
        %>
        <h2> Detalles de la propuesta: </h2>
        
        <p> De esta propuesta eres: <%= nivelPermiso %></p>
        
    <% if (propuesta != null) 
        {   
        %>
        <p>T�tulo: <%= propuesta.getTitulo() %></p>
        <p>Descripci�n: <%= propuesta.getDescripcion() %></p>
        <p>Lugar: <%= propuesta.getLugar() %></p>
        <% 
        } 
        else 
        { 
        %>
        <p style="color:red;">No se encontr� la propuesta seleccionada.</p>
        <% 
        }
        %>

    </body>
</html>
