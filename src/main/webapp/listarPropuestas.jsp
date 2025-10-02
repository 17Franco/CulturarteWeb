<%-- 
    Document   : listarPropuestas
    Created on : 2 oct 2025, 10:57:43
    Author     : klaas
--%>

<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Set" %>
<%@ page import="logica.DTO.DTOPropuesta" %>
<!DOCTYPE html>
<html>
    
    <head>
       
        <meta charset="UTF-8">
        <title>Lista de Propuestas</title>
    
    </head>
   
    <body>
            
        <h1>Listado de Propuestas</h1>

        <%
            //Se intercepta set de props desde el servlet
            Set<DTOPropuesta> propuestas = (Set<DTOPropuesta>) request.getAttribute("propuestas");

            if (propuestas != null && !propuestas.isEmpty()) 
            {   //Si existen propuestas... se extraen del set y formatean a un estilo entendible por el navegador wreb
                %>
                <ul>
                <%  
                    for (DTOPropuesta p : propuestas) 
                    { //Acá además de dejar los datos de propuestas legibles, le envío el titulo de la propuesta que user elija hacia el servlet de los detalles de la prop.
                        %>
                        <li>    
                            <a href="DetallesDePropuesta?tituloProp=<%= URLEncoder.encode(p.getTitulo(), "UTF-8") %>">
                                <%= p.getTitulo() %> - <%= p.getDescripcion() %> - <%= p.getLugar() %>
                            </a>
                        </li>
                        <%
                    }  
                %>
                </ul>
                <%
                    
            } 
            else 
            {
                %>
                <p>Aún no hay propuestas.</p>
                <%
            }
        
            %>
        
    </body>
    
</html>

