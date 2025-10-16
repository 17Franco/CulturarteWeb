<%@page import="logica.DTO.DTOColaboracion"%>
<%@page import="java.util.Set"%>
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
            List<DTOColaboracion> c = (List<DTOColaboracion>) request.getAttribute("Colaboraciones");
            
            %>
            <div class="propuestas-contenedor">
                <%for(DTOColaboracion colab:c){%>
                    <!--si estoy en sesion invitado o veo el perfil de otro usuario solo puedo ver las que no son ingresada-->
                    
                    <div class="tarjeta-propuesta-horizontal"> 

                        <div class="imagen-area">
                            <img src="Img?ruta=<%= colab.getImgDePropuesta() %>" alt="<%= colab.getPropuesta() %>" class="propuesta-img">
                        </div>

                        <div class="texto-area">
                            <h5 class="card-title">Colaboracio Realizada</h5>
                            <p><strong>Titulo</strong> <%=colab.getPropuesta()%></p>
                            <p><strong>Moto Colaborado</strong> <%=colab.getMonto() %></p>
                            <p><strong>Fecha Realizada</strong> <%=colab.getCreado() %></p>
                            <p><strong>Retorno Elegido</strong> <%=colab.getTipoRetorno().toString()%></p>
                            <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= colab.getPropuesta() %>" class="btn btn-primary">Ver Detalle</a>
                        </div>

                    </div>
                 
                <%}%>
                <!---->
            </div>   
        
        </div>
        
    </body>
</html>