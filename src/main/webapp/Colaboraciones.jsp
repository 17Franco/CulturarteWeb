<%@page import="logica.DTO.DTOColaboracion"%>
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
            const contextPath = '<%= request.getContextPath() %>';
        </script>

        <%
            List<DTOColaboracion> c = (List<DTOColaboracion>) request.getAttribute("Colaboraciones");
        %>

        <div class="propuestas-contenedor" id="conteneedor_Colaboracion">
            <% for (DTOColaboracion colab : c) { %>
                <div class="tarjeta-propuesta-horizontal" data-objetivo="<%= colab.getId() %>"> 
                    
                    <div class="imagen-area">
                        <% if (colab.getImgDePropuesta() != null && !"".equals(colab.getImgDePropuesta())) { %>
                            <img src="Img?ruta=<%= colab.getImgDePropuesta() %>" alt="<%= colab.getPropuesta() %>" class="propuesta-img">
                        <% } else { %>
                            <img class="propuesta-img" src="https://alunarte.com/wp-content/uploads/2017/07/la-propuesta.png" alt="Imagen de propuesta">
                        <% } %>
                    </div>

                    <div class="texto-area">
                        <h5 class="card-title">Colaboración Realizada</h5>
                        <p><strong>Título:</strong> <%= colab.getPropuesta() %></p>
                        <p><strong>Monto Colaborado:</strong> <%= colab.getMonto() %></p>
                        <p><strong>Fecha Realizada:</strong> <%= colab.getCreado() %></p>
                        <p><strong>Retorno Elegido:</strong> <%= colab.getTipoRetorno().toString() %></p>

                        <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= colab.getPropuesta() %>" 
                           class="btn btn-primary me-2">Ver Detalle</a>

                        <% if (session.getAttribute("logueado") != null && UsuarioLogueado.equals(colab.getColaborador())) { %>
                            <button class="btn btn-primary accion me-2">Eliminar</button>

                            <!-- 🔽 Nuevo botón que abre el modal -->
                            <button 
                                type="button"
                                class="btn btn-primary me-2 btn-generar-constancia"
                                style="margin-top:10px;"
                                data-id="<%= colab.getId() %>"
                                data-colaborador="<%= colab.getColaborador() %>"
                                data-propuesta="<%= colab.getPropuesta() %>"
                                data-monto="<%= colab.getMonto() %>"
                                data-retorno="<%= colab.getTipoRetorno() %>"
                                data-creado="<%= colab.getCreado() %>">
                                Generar constancia de pago
                            </button>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Modal de previsualización -->
    <div class="modal fade" id="modalConstancia" tabindex="-1" aria-labelledby="modalConstanciaLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modalConstanciaLabel">Previsualización de constancia</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body">
            <p><strong>Plataforma:</strong> Culturarte</p>
            <p><strong>Fecha de emisión:</strong> <span id="fechaEmision"></span></p>
            <p><strong>Colaborador:</strong> <span id="colabNombre"></span></p>
            <p><strong>Propuesta:</strong> <span id="colabPropuesta"></span></p>
            <p><strong>Monto:</strong> <span id="colabMonto"></span></p>
            <p><strong>Tipo de Retorno:</strong> <span id="colabRetorno"></span></p>
            <p><strong>Fecha de creación:</strong> <span id="colabCreado"></span></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>

            <!-- Este botón dispara la generación del PDF -->
            <form id="formGenerarConstancia" method="post" target="_blank" action="${pageContext.request.contextPath}/GenerarConstancia">
              <input type="hidden" name="idColaboracion" id="idColaboracionModal" value="">
              <button type="submit" class="btn btn-primary">Generar PDF</button>
            </form>
          </div>
        </div>
      </div>
    </div>

   

    <script src="JS/InteraccionColaboracion.js"></script>
    <script src="JS/bajaColaboracion.js"></script>
    <script src="JS/formatoPopUpPago.js"></script>
</body>
</html>
