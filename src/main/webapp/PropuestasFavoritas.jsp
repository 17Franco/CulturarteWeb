
<%@page import="logica.DTO.DTOPropuesta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Propuestas Favoritas</title>
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
            //me Traigo de la request el dto
            List<DTOPropuesta> prop = (List<DTOPropuesta>) request.getAttribute("propuestasFavoritas");
            
            %>
            <div class="propuestas-contenedor">
                <%for(DTOPropuesta p:prop){%>
                    <div class="tarjeta-propuesta-horizontal"> 
    
                        <div class="imagen-area">
                            <%if(p.getImagen()!=null && !"".equals(p.getImagen())){%>
                                <img src="Img?ruta=<%= p.getImagen() %>" alt="<%= p.getTitulo() %>" class="propuesta-img">
                            <%}else{ %>
                            <!--le agrego una img generica si no tiene imagen -->
                                <img class="propuesta-img" src="https://alunarte.com/wp-content/uploads/2017/07/la-propuesta.png" alt="Imagen de propuesta>">
                            <%}%>
                        </div>

                        <div class="texto-area">
                            <h5 class="card-title"><%=p.getTitulo()%> </h5>
                            <p><strong>Categoria</strong> <%=p.getCategorioToString()%></p>
                            <p><strong>Estado</strong> <%=p.getEstadoAct() %></p>
                            <p><strong>Fecha Publicacion</strong> <%=p.getFechaPublicacion()%></p>
                            <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= p.getTitulo()%>" class="btn btn-primary">Ver Detalle</a>
                        </div>

                    </div>
                <%}%>
                <!---->
            </div>   
        
        </div>
        
    </body>
</html>
