<%@page import="logica.DTO.DTOPropuesta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalle de Propuesta</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/> <!-- estilos -->
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/> <!-- estilos -->
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
    </head>
    <body class="bg-body-secondary">

        <%@ include file="Componentes/Header.jsp" %>

        <div class="container mt-4">
            <%
                DTOPropuesta propuesta = (DTOPropuesta) request.getAttribute("propuesta");
                if (propuesta != null) {
            %>

            <div class="card shadow-lg p-4">
                <div class="row g-4">
                    <div class="col-md-6">
                        <% if (propuesta.getImagen() != null && !propuesta.getImagen().isEmpty()) {%>
                        <img src="<%= propuesta.getImagen()%>" class="img-fluid rounded shadow mb-3" alt="Imagen Propuesta">
                        <% } else { %>
                        <img src="imagenes/default-propuesta.png" class="img-fluid rounded shadow mb-3" alt="Sin Imagen">
                        <% }%>

                        <h2 class="mb-3"><%= propuesta.getTitulo()%></h2>
                        <p class="text-muted"><%= propuesta.getDescripcion()%></p>

                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>Lugar:</strong> <%= propuesta.getLugar()%></li>
                            <li class="list-group-item"><strong>Fecha:</strong> <%= propuesta.getFecha()%></li>
                            <li class="list-group-item"><strong>Precio entrada:</strong> $<%= propuesta.getPrecio()%></li>
                            <li class="list-group-item"><strong>Monto total:</strong> $<%= propuesta.getMontoTotal()%></li>
                            <li class="list-group-item"><strong>Estado:</strong> <%= propuesta.getUltimoEstado().getEstado().toString()%></li>
                            <li class="list-group-item"><strong>Proponente:</strong> <%= propuesta.nickProponenteToString()%></li>
                            <li class="list-group-item"><strong>Categoría:</strong> 
                                <%= (propuesta.getCategoria() != null) ? propuesta.getCategoria().getNombreCategoria() : "Sin categoría"%>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <div class="card p-3 shadow-sm">
                            <h4 class="mb-3">Colaborar</h4>
                            <form action="AportePropuesta" method="post">
                                <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">

                                <div class="mb-3">
                                    <label for="monto" class="form-label">Monto</label>
                                    <input type="number" class="form-control" id="monto" name="monto" min="1" required>
                                </div>

                                <div class="mb-3">
                                    <label for="tipoRetorno" class="form-label">Tipo de retorno</label>
                                    <select class="form-select" id="tipoRetorno" name="tipoRetorno" required>
                                        <option value="PorcentajeGanancia">Porcentaje de Ganancia</option>
                                        <option value="EntradaGratis">Entrada Gratis</option>
                                    </select>
                                </div>

                                <button type="submit" class="btn btn-primary w-100">Aportar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <% } else { %>
            <div class="alert alert-danger">No se pudo cargar la propuesta</div>
            <% }%>
        </div>

    </body>
</html>