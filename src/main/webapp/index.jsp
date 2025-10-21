<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map"%>
<%@page import="logica.DTO.Estado"%>
<%@page import="java.util.List"%>
<%@page import="logica.DTO.DTOPropuesta"%>
<%@page import="logica.DTO.DTOCategoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Propuestas por Estado</title>

  <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>

  <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
  <link rel="stylesheet" href="CssPersonalizado/propuestas.css"/>

  <script src="jsBoostrap/bootstrap.bundle.min.js"></script>

  <script src="JS/DespliegueSubCategorias.js" defer></script>

  <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">


</head>

<body class="bg-body-secondary">
  <%@ include file="Componentes/Header.jsp" %>

  <div class="main-container">
    <!-- se cargan las categorías en sidebar -->
    <jsp:include page="/Categorias" />

    <!--  aca comeinya el  Sidebar -->
    <aside class="sidebar">
      <nav>
        <ul class="categories">
          <%
            List<DTOCategoria> categorias = (List<DTOCategoria>) request.getAttribute("categorias");
            if (categorias != null) {
              for (DTOCategoria cat : categorias) {
          %>
            <li class="category">
                <div class="category-header">
                  <a href="#"><%= cat.getNombreCategoria() %></a>
                  <button class="toggle-subcategory">+</button>
                </div>
                <ul class="subcategory" hidden>
                  <% for (DTOCategoria sub : cat.getSubcategorias()) { %>
                    <li class="propuesta" data-id="<%= sub.getNombreCategoria() %>">
                      <%= sub.getNombreCategoria() %>
                    </li>
                  <% } %>
                </ul>
            </li>
          <% } } else { %>
            <li>No hay categorías cargadas</li>
          <% } %>
        </ul>
      </nav>
    </aside>
        
    <%
        boolean mostrarTabs = (Boolean) request.getAttribute("mostrarEstados");
        List<DTOPropuesta> todasLasPropuestas = (List<DTOPropuesta>)request.getAttribute("propuestas");// trae las propuestas y abajo .size las cuenta guardandolas en Cantidad Propuestas
        Integer cantidadPropuestas = todasLasPropuestas.size();
    %>

    <%
String filtro = request.getParameter("filtro");
if (filtro == null) filtro = "";
%>
    <!-- Columna de contenido (derecha) -->
    <section style="<%= mostrarTabs? "" : "display:none"%>">
      <%
        Map<Estado, List<DTOPropuesta>> propuestasPorEstado =
            (Map<Estado, List<DTOPropuesta>>) request.getAttribute("propuestasPorEstado");

        List<Estado> estados = new ArrayList<>();
        estados.addAll(propuestasPorEstado.keySet());
        // estados.sort(Comparator.comparing(Estado::name));
      %>
      <p> Total propuestas encontradas <%= cantidadPropuestas %></p>
      <!-- Pestañas -->
      <ul class="nav nav-tabs" id="estadoTabs" role="tablist">
        <%
          for (Estado estado : estados) {
              boolean isActive = (estado == estados.get(0));
        %>
          <li class="nav-item">
            <button class="nav-link <%= isActive ? "active" : "" %>"
                    id="<%= estado %>-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#<%= estado %>"
                    type="button">
              <%= estado.name() %>
            </button>
          </li>
        <%
          }
        %>
      </ul>

      <!-- Contenido de pestañas -->
      <div class="tab-content mt-3" id="estadoTabsContent">
        <%
          for (Estado estado : estados) {
            boolean isActive = (estado == estados.get(0));
        %>
          <div class="tab-pane fade <%= isActive ? "show active" : "" %>"
               id="<%= estado.name() %>" role="tabpanel"
               aria-labelledby="<%= estado.name() %>-tab">
            <div class="propuestas-container">
              <%
                List<DTOPropuesta> lista = propuestasPorEstado.get(estado);
                if (lista != null && !lista.isEmpty()) {
                  for (DTOPropuesta pro : lista) {
              %>
                <div class="propuesta-card">
                  <img src="<%= pro.getImagen() %>" alt="Imagen de <%= pro.getTitulo() %>">
                  <div class="card-body">
                    <h5 class="card-title"><%= pro.getTitulo() %></h5>
                    <p>
                    <%
                    String descripcion = pro.getDescripcion();
                    if (!filtro.isEmpty()) {
                        // Escapa caracteres especiales para regex
                        String regex = "(?i)(" + filtro.replaceAll("([\\\\*+\\[\\](){}\\$.?\\^|])", "\\\\$1") + ")";
                        descripcion = descripcion.replaceAll(regex, "<span class='highlight'>$1</span>");
                    }
                    out.print(descripcion);
                    %>
                    </p>                   
                    <div class="info"><b>Lugar:</b> <%= pro.getLugar() %></div>
                    <div class="info"><b>Fecha:</b> <%= pro.getFecha() %></div>
                    <div class="precio"><b>Precio:$</b> <%= pro.getPrecio() %></div>

             

                    <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= pro.getTitulo() %>"
                       class="btn btn-primary mt-2">Ver detalles</a>
                  </div>
                </div>
              <%
                  }
                } else {
              %>
                <p>No hay propuestas en este estado.</p>
              <%
                }
              %>
            </div>
          </div>
        <%
          } // fin for estados
        %>
      </div>

    </section>
    <section style="<%= mostrarTabs? "display:none" : ""%>">
        <div class="propuestas-container">
            
              <%
                if (todasLasPropuestas != null && !todasLasPropuestas.isEmpty()) {
                  for (DTOPropuesta pro : todasLasPropuestas) {
              %>
                <div class="propuesta-card">
                  <img src="<%= pro.getImagen() %>" alt="Imagen de <%= pro.getTitulo() %>">
                  <div class="card-body">
                    <h5 class="card-title"><%= pro.getTitulo() %></h5>
                    <p><%= pro.getDescripcion() %></p>
                    <div class="info"><b>Lugar:</b> <%= pro.getLugar() %></div>
                    <div class="info"><b>Fecha:</b> <%= pro.getFecha() %></div>
                    <div class="precio"><b>Precio:$</b><%= pro.getPrecio() %></div>
                    

                    <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= pro.getTitulo() %>"
                       class="btn btn-primary mt-2">Ver detalles</a>
                  </div>
                </div>
              <%
                  }
                } else {
              %>
                <p>No hay propuestas.</p>
              <%
                }
              %>
            </div>
        </section>
    </div>

 
</body>
</html>