<%@page import="webservices.DtoCategoria"%>

<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Alta Propuesta</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
        <link rel="stylesheet" href="CssPersonalizado/propuestas.css"/>
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
        <script src="JS/Validacion.js" defer></script>
        <script src="JS/DespliegueSubCategorias.js" defer></script>
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet"/>
    </head>
    <body class="bg-body-secondary">

        <%@ include file="Componentes/Header.jsp" %>

        <div class="container mt-4">
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) {%>
            <div class="alert alert-danger text-center"><%= error%></div>
            <% } %>

            <% String exito = (String) request.getAttribute("exito"); %>
            <% if (exito != null) {%>
            <div class="alert alert-success text-center"><%= exito%></div>
            <% }%>

            <h2 class="mb-4">Crear Nueva Propuesta</h2>
            <div class="card shadow-lg p-4">
                <form class="row g-3 needs-validation" method="post" action="AltaPropuesta" enctype="multipart/form-data" novalidate>
                    <div class="col-md-6 mb-3">
                        <label for="titulo" class="form-label">Título</label>
                        <input type="text" class="form-control" id="titulo" name="titulo"
                               value="<%= request.getAttribute("valorTitulo") != null ? request.getAttribute("valorTitulo") : ""%>" required>
                        <div class="invalid-feedback">Ingrese un título</div>
                    </div>

                    <div class="col-12 mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <textarea class="form-control" id="descripcion" name="descripcion" rows="4" required><%= request.getAttribute("valorDescripcion") != null ? request.getAttribute("valorDescripcion") : ""%></textarea>
                        <div class="invalid-feedback">Ingrese una descripción</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="lugar" class="form-label">Lugar</label>
                        <input type="text" class="form-control" id="lugar" name="lugar"
                               value="<%= request.getAttribute("valorLugar") != null ? request.getAttribute("valorLugar") : ""%>" required>
                        <div class="invalid-feedback">Ingrese el lugar</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="fechaEvent" class="form-label">Fecha</label>
                        <input type="date" class="form-control border-secondary" id="fechaEvent" name="fecha" required>
                        <div class="invalid-feedback">Ingrese una fecha</div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label for="precio" class="form-label">Precio entrada</label>
                        <input type="number" class="form-control" id="precio" name="precio"
                               value="<%= request.getAttribute("valorPrecio") != null ? request.getAttribute("valorPrecio") : ""%>" required min="0">
                        <div class="invalid-feedback">Ingrese un precio válido</div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label for="montoTotal" class="form-label">Monto total</label>
                        <input type="number" class="form-control" id="montoTotal" name="montoTotal"
                               value="<%= request.getAttribute("valorMontoTotal") != null ? request.getAttribute("valorMontoTotal") : ""%>" required min="1">
                        <div class="invalid-feedback">Ingrese un monto válido</div>
                    </div>

                    <div class="col-12 mb-3">
                        <label class="form-label">Categoría</label>
                        <div class="col-2 mb-2">
                            <ul class="categories list-unstyled">
                                <%
                                    List<webservices.DtoCategoria> categorias = (List<webservices.DtoCategoria>) request.getAttribute("categorias");
                                    if (categorias != null && !categorias.isEmpty()) {
                                        for (webservices.DtoCategoria cat : categorias) {
                                %>
                                <li class="category">
                                    <div class="category-header">
                                        <input type="radio" name="categoria" value="<%= cat.getNombreCategoria()%>" id="cat-<%= cat.getNombreCategoria()%>">
                                        <label for="cat-<%= cat.getNombreCategoria()%>"><%= cat.getNombreCategoria()%></label>
                                        <button type="button" class="toggle-subcategory">+</button>
                                    </div>
                                    <ul class="subcategory list-unstyled" hidden>
                                        <% for (webservices.DtoCategoria sub : cat.getSubcategorias()) {%>
                                        <li>
                                            <input type="radio" name="categoria" value="<%= sub.getNombreCategoria()%>" id="cat-<%= sub.getNombreCategoria()%>">
                                            <label for="cat-<%= sub.getNombreCategoria()%>"><%= sub.getNombreCategoria()%></label>
                                        </li>
                                        <% } %>
                                    </ul>
                                </li>
                                <%  }
                                } else { %>
                                <li>No hay categorías disponibles</li>
                                    <% }%>
                            </ul>
                        </div>
                        <div class="invalid-feedback">Seleccione una categoría</div>
                    </div>

                    <div class="col-12 mb-3">
                        <label class="form-label">Tipo de Retorno</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoRetorno" id="entradaGratis" value="EntradaGratis">
                            <label class="form-check-label" for="entradaGratis">Entrada Gratis</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoRetorno" id="porcentajeGanancia" value="PorcentajeGanancia">
                            <label class="form-check-label" for="porcentajeGanancia">Porcentaje de Ganancia</label>
                        </div>
                    </div> 

                    <div class="col-12 mb-3">
                        <label for="formFile" class="form-label">Subir Imagen</label>
                        <input class="form-control border-secondary" type="file" id="formFile" name="imagen">
                    </div>

                    <div class="col-12 text-center mt-4">
                        <button type="submit" class="btn btn-primary btn-lg">Crear Propuesta</button>
                    </div>

                </form>
            </div>
        </div>
    </body>
</html>