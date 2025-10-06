<%-- 
    Document   : resultadoAccion
    Created on : 5 oct 2025, 13:19:04
    Author     : klaas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalles de Operacion: </title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/> <!-- estilos -->
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/> <!-- estilos -->
        <script  src="JS/Validacion.js" defer></script> <!-- funcionalidades -->
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script> <!-- funcionalidades -->
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    </head>
    <%@ include file="Componentes/Header.jsp" %>
<%  
    //int resultadoDeAccion = (Integer) request.getAttribute("resultado"); //Devuelve el int con codigo de accion realizada
    String accionEfectuada = (String) request.getAttribute("accionLograda"); //Devuelve el string con la accion realizada
    
    Integer resultadoDeAccion = (Integer) request.getAttribute("resultado");
        if (resultadoDeAccion == null) {
            resultadoDeAccion = 0; 
        }
    
    if(accionEfectuada != null && !accionEfectuada.isEmpty() && resultadoDeAccion != 0) 
    { //Si se logra la acción 
%>  
        <body>
        <div class="alert alert-success">
        <i class="bi bi-check-circle"></i> Usted ha <%=accionEfectuada%> exitosamente.
        </div>
        </body>

<%
    }
    else
    {//Accion truncaten
%>
        <div class="alert alert-danger">
            <i class="bi bi-x-circle"></i> Ocurrió un error o no se pudo modificar, intente nuevamente.
        </div>

<%
    }   
%>    

<a href="index.jsp" class="btn btn-primary">Volver al inicio</a>


</html>
