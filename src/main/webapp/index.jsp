<%-- 
    Document   : index
    Created on : 27 sept 2025, 22:10:26
    Author     : fran
--%>

<%@page import="logica.DTO.DTOCategoria"%>
<%@page import="logica.Fabrica"%>
<%@page import="logica.IController"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/> <!-- estilos -->
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/> <!-- estilos -->
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script> <!-- funcionalidades -->
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    </head>
    <body class="bg-body-secondary">
        <%@ include file="Componentes/Header.jsp" %>
        <jsp:include page="/Categorias" />
        
        <aside class="sidebar">
            <nav>
              <ul class="categories">
              <%
                  List<DTOCategoria> categorias = ( List<DTOCategoria>) request.getAttribute("categorias");
                  if (categorias != null) { //    private Set <DTOCategoria> subcategorias;

                      for(DTOCategoria cat : categorias) {
              %>
                      <li class="category">
                          
                          <div class="category-header">
                              <a href="#"><%= cat.getNombreCategoria() %></a>
                          </div>
                          <ul class="subcategory">
                               <%  //    private Set <DTOCategoria> subcategorias;

                                   for(DTOCategoria sub: cat.getSubcategorias()){
                              %>
                              <li><a href="#"><%= sub.getNombreCategoria() %></a></li>
                              <%
                                  }
                          %>
                          </ul>
                      </li>
              <%
                      }
                  } else {
              %>
                      <li>No hay categorías cargadas</li>
              <%
                  }
              %>
              </ul>
            </nav>
        </aside>
    </body>
</html>
