
<%@page import="java.util.Set"%>
<%@page import="logica.DTO.DTOPropuesta"%>
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

    <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
    <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
    <link rel="stylesheet" href="CssPersonalizado/propuestas.css"/>
    <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
    <script src="JS/DespliegueSubCategorias.js" defer></script> 


    <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
</head>

<body class="bg-body-secondary">
    <%@ include file="Componentes/Header.jsp" %>

    <!-- Contenedor principal-->
    <div class="main-container">
    <jsp:include page="/Categorias" />
        <jsp:include page="/Propuestas" />
        <!-- Sidebar Categorías -->
        <aside class="sidebar">
            <nav>
                <ul class="categories">
                    <%
                        List<DTOCategoria> categorias = (List<DTOCategoria>) request.getAttribute("categorias");
                        if (categorias != null) {
                            for(DTOCategoria cat : categorias) {
                    %>
                        <li class="category">
                            <div class="category-header">
                                <a href="#"><%= cat.getNombreCategoria() %></a>
                                <button class="toggle-subcategory">+</button>
                            </div>
                            <ul class="subcategory" hidden>
                                <% for(DTOCategoria sub: cat.getSubcategorias()){ %>
                                    <li><a href="#"><%= sub.getNombreCategoria() %></a></li>
                                <% } %>
                            </ul>
                        </li>
                    <% } } else { %>
                        <li>No hay categorías cargadas</li>
                    <% } %>
                </ul>
            </nav>
        </aside>

        <!-- Contenedor de Propuestas -->
        <div class="propuestas-container">
            <%
                Set<DTOPropuesta> propuestas = (Set<DTOPropuesta>) request.getAttribute("propuestas");
                if (propuestas != null && !propuestas.isEmpty()) {
                    for (DTOPropuesta pro : propuestas) {
            %>
                <div class="propuesta-card">
                    
                    
                    <img src="Img?ruta=<%= pro.getImagen() %>" alt="Imagen de <%= pro.getTitulo() %>">
                    
                    <!-- he probado varias cosas todavia no doy con trareme las malditas imagenes
                    <img src="http://servidor-central/IMG/<%= pro.getImagen() %>" alt="Imagen de <%= pro.getTitulo() %>">-->

                    <div class="card-body">
                        <h5><%= pro.getTitulo() %></h5>
                        <p><%= pro.getDescripcion() %></p>
                        <div class="info"><b>Lugar:</b> <%= pro.getLugar() %></div>
                        <div class="info"><b>Fecha:</b> <%= pro.getFecha() %></div>
                        <div class="precio">Precio: $<%= pro.getPrecio() %></div>
                        <div class="info"><b>Monto Total:</b> $<%= pro.getMontoTotal() %></div>
                        <div class="info"><b>Publicada:</b> <%= pro.getFechaPublicacion() %></div>
                        <!-- Redireccionar a mosrtar propuestas-->
                        <a 
                            href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= pro.getTitulo()%>" 
                            class="btn btn-primary mt-2">
                            Ver detalles
                        </a>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <p>No hay propuestas disponibles.</p>
            <%
                }
            %>
        </div>

    </div>



</body>
</html>
