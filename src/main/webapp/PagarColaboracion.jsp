<%-- 
    Document   : PagarColaboracion
    Created on : 8 nov 2025, 3:43:02
    Author     : klaas
--%>

<%@page import="webservices.DtoColaboracion"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Constancia de Colaboraciones</title>
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

            <script>
            const contextPath = '<%= request.getContextPath()%>';
            </script>

            <%
                List<DtoColaboracion> pendientesDePago = (List<DtoColaboracion>) request.getAttribute("colaboracionesAPagar");
            %>

            <div class="propuestas-contenedor" id="conteneedor_Colaboracion">
                
              <%for(DtoColaboracion colab : pendientesDePago) 
                {%>

                            <div class="tarjeta-propuesta-horizontal" data-objetivo="<%= colab.getId()%>"> 

                                <div class="imagen-area">
                                    <% String ruta = "https://raw.githubusercontent.com/17Franco/Culturarte/refs/heads/main/propAssets/" + colab.getPropuesta().replace(" ", "%2B") + ".jpg"; 
                                    if (colab.getImgDePropuesta() != null && !"".equals(colab.getImgDePropuesta())) {%>
                                    <img src="Img?ruta=<%= colab.getImgDePropuesta()%>" alt="<%= colab.getPropuesta()%>" class="propuesta-img" onerror="this.onerror=null; this.src='<%= ruta %>';">
                                    <% } else { %>
                                    <img class="propuesta-img" src="<%=ruta%>" alt="Imagen de propuesta">
                                    <% }%>
                                </div>

                                        <div class="texto-area">
                                            <h5 class="card-title">Colaboración</h5>
                                            <p><strong>Título:</strong> <%= colab.getPropuesta()%></p>
                                            <p><strong>Monto Colaborado:</strong> <%= colab.getMonto()%></p>
                                            
                                            <%
                                            String fechaStr = colab.getCreadoString();
                                            String fechaFormateada = fechaStr;

                                            if (fechaStr != null && !fechaStr.isEmpty()) 
                                            {
                                                java.time.LocalDate fecha = java.time.LocalDate.parse(fechaStr);
                                                fechaFormateada = fecha.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
                                            }
                                            %>
                                            <p><strong>Fecha Realizada:</strong> <%= fechaFormateada %></p>
                                            <% if (colab.getTipoRetorno().toString().equals("ENTRADA_GRATIS")) { %>
                                            <p><strong>Retorno:</strong> Entrada Gratis</p>
                                            <%}
                                            else
                                            {%>
                                            <p><strong>Retorno:</strong> Porcentaje ganancia</p>
                                            <%}%>
                                            
                                            <div class="btn-group" role="group">

                                                <% if (session.getAttribute("logueado") != null && UsuarioLogueado.equals(colab.getColaborador())) { %>
                                                <a href="${pageContext.request.contextPath}/PagarColaboracion?tituloPropuesta=<%= java.net.URLEncoder.encode(colab.getPropuesta(), "UTF-8")%>" 
                                                   class="btn btn-primary">Acreditar Pago</a>
                                                <% } %>

                                                <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= colab.getPropuesta()%>" 
                                                   class="btn btn-secondary">Detalles</a>

                                            </div>
                                        </div>
                                </div>
              <%}%>
                
            </div>
        </div>



        <script src="JS/InteraccionColaboracion.js"></script>
        <script src="JS/bajaColaboracion.js"></script>
        <script src="JS/formatoPopUpPago.js"></script>
    </body>
</html>

