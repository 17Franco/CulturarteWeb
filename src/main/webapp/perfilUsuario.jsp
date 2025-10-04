<%-- 
    Document   : perfilUsuario
    Created on : 4 oct 2025, 3:40:02
    Author     : fran
--%>
<%@page import="logica.DTO.DTOColaborador"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
        
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <%@ include file="Componentes/Header.jsp" %>
        
        <h1>Hello World!</h1>
        <%
            DTOColaborador c = (DTOColaborador)request.getAttribute("infoPerfil");
        %>
        <p><%= c.getRutaImg()%></p>
        <!--<img src="ImgUsuario?ruta=<%= c.getRutaImg() %>" alt="Imagen del usuario">-->
        
    </body>
</html>
