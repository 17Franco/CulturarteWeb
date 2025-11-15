<%-- 
    Document   : ExtenderPropuesta
    Created on : 19 oct 2025, 23:10:20
    Author     : klaas
--%>
<%@page import="java.util.Set"%>
<%@page import="webservices.DtoPropuesta"%>
<%@page import="java.util.List"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cancelar Propuesta</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
        <link rel="stylesheet" href="CssPersonalizado/propuestas.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
    </head>
   <body class="bg-body-secondary">
        <%@ include file="Componentes/Header.jsp" %>
        <div class="main-container">
       
        <%@ include file="Componentes/NavPerfilUsuario.jsp" %>
        
            <%
            
            List<DtoPropuesta> prop = (List<DtoPropuesta>) request.getAttribute("propuestasAExtender");
            
            %>
            <div class="propuestas-contenedor">
                <%for(DtoPropuesta p:prop){%>
                
                    <%if((UsuarioLogueado != null && UsuarioLogueado.equals(nick))) {%>
                            <div class="tarjeta-propuesta-horizontal"> 

                            <div class="imagen-area">
                                <%  String ruta = "https://raw.githubusercontent.com/17Franco/Culturarte/refs/heads/main/propAssets/" + p.getTitulo().replace(" ", "%2B") + ".jpg";
                                    if(p.getImagen()!=null && !"".equals(p.getImagen())){%>
                                    <img src="Img?ruta=<%= p.getImagen() %>" alt="<%= p.getTitulo() %>" class="propuesta-img" onerror="this.onerror=null; this.src='<%= ruta %>';">
                                <%}else{ %>
                                    
                                   <img class="propuesta-img" src="<%=ruta%>" alt="Imagen de propuesta>">
                                <%}%>
                            </div>

                            <div class="texto-area">
                                <h5 class="card-title"><%=p.getTitulo()%> </h5>
                                <p><strong>Categoria</strong> <%=p.getCat().getNombreCategoria() %></p>
                                <p><strong>Estado</strong> <%=p.getEstadoAct() %></p>
                                <p><strong>Fecha Publicacion:</strong> <%= LocalDate.parse(p.getFechaPublicacionString()).format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"))%></p>
                                <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= p.getTitulo()%>" class="btn btn-primary">Ver Detalle</a>
                            </div>

                        </div>
                    
                <%}%>
             <%}%>    
            </div>   
        
        </div>
        
    </body>
</html>
