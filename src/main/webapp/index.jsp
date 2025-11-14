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
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Propuestas por Estado</title>
  
  <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
  <link rel="stylesheet" href="CssPersonalizado/propuestas.css"/>
  <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
  <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
  <script src="JS/DespliegueSubCategorias.js" defer></script>
  <script src="JS/detectarDispositivo.js" defer></script>

  <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
</head>

<body class="bg-body-secondary">
  <%@ include file="Componentes/Header.jsp" %>

  <div class="main-container">
    <!-- Sidebar de categorías -->
    <jsp:include page="/Categorias" />

    <aside class="sidebar d-none d-lg-block">
      <script>
        const contextPath = '<%= request.getContextPath() %>';
        const estaLogueado = <%= (session.getAttribute("logueado") != null)%>;
      </script> 
      <nav>
        <ul class="categories">
          <%
            List<webservices.DtoCategoria> categorias = (List<webservices.DtoCategoria>) request.getAttribute("categorias");
            if (categorias != null) {
              for (webservices.DtoCategoria cat : categorias) {
          %>
            <li class="category">
              <div class="category-header">
                <a href="#"><%= cat.getNombreCategoria() %></a>
                <button class="toggle-subcategory">+</button>
              </div>
              <ul class="subcategory" hidden>
                <% for (webservices.DtoCategoria sub : cat.getSubcategorias()) { %>
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
        Map<String, List<DTOPropuesta>> propuestasPorEstado =
            (Map<String, List<DTOPropuesta>>) request.getAttribute("propuestasPorEstado");

        List<DTOPropuesta> todasLasPropuestas = propuestasPorEstado.get("Todas");
        Integer cantidadPropuestas = todasLasPropuestas.size();

        String filtro = request.getParameter("filtro");
        if (filtro == null) filtro = "";
        
        List<String> estados = new ArrayList<>();
        estados.add("Todas");
        for (String estado : propuestasPorEstado.keySet()) {
            if (!"Todas".equals(estado))
                estados.add(estado);
        }
    %>

    <!-- Contenido principal -->
    <section>
      <p class="d-none d-lg-block">Total propuestas encontradas <%= cantidadPropuestas %></p>

      <!-- Pestañas -->
      <ul class="nav nav-tabs d-none d-lg-flex" id="estadoTabs" role="tablist">
        <%
          for (String estado : estados) {
              if ("INGRESADA".equalsIgnoreCase(estado)) continue; // 🚫 Ocultar pestaña Ingresada
              boolean isActive = (estado == estados.get(0));
        %>
          <li class="nav-item">
            <button class="nav-link <%= isActive ? "active" : "" %>"
                    id="<%= estado %>-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#<%= estado %>"
                    type="button">
              <%= estado %>
            </button>
          </li>
        <%
          }
        %>
      </ul>

      <!-- Contenido de pestañas -->
      <div class="tab-content mt-3" id="estadoTabsContent">            
        <%
          for (String estado : estados) {
              if ("INGRESADA".equalsIgnoreCase(estado)) continue; // para que no me traiga las ingresadas
              boolean isActive = (estado == estados.get(0));
        %>
          <div class="tab-pane fade <%= isActive ? "show active" : "" %>"
               id="<%= estado %>" role="tabpanel"
               aria-labelledby="<%= estado %>-tab">
            <div class="propuestas-container">
              <%
                List<DTOPropuesta> lista = propuestasPorEstado.get(estado);
                if (lista != null && !lista.isEmpty()) {
                  for (DTOPropuesta pro : lista) {
              %>
                <div class="propuesta-card">
                  <% if (pro.getImagen() != null && !"".equals(pro.getImagen())) { %>
                    <img src="Img?ruta=<%= pro.getImagen() %>" alt="Imagen de <%= pro.getTitulo() %>">
                  <% } else { %>
                    <img class="propuesta-img" src="https://alunarte.com/wp-content/uploads/2017/07/la-propuesta.png" alt="Imagen de propuesta">
                  <% } %>

                  <div class="card-body">
                    <h5 class="card-title"><%= pro.getTitulo() %></h5>
                    <p>
                    <%
                      String descripcion = pro.getDescripcion();
                      if (!filtro.isEmpty()) {
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
                  } // fin for propuestas
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
  </div>
</body>
</html>
