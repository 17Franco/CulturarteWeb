<%-- 
    Document   : MostrarPropuesta_Colaborar
    Created on : 3 oct 2025, 17:32:12
    Author     : asus/klaas
--%>

<%@page import="java.util.Map"%>
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
        <script  src="JS/Validacion.js" defer></script> <!-- funcionalidades -->
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script> <!-- funcionalidades -->
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet"/>
    </head>
    <body class="bg-body-secondary">

        <%@ include file="Componentes/Header.jsp" %>

        <%
            int permisos = (Integer) request.getAttribute("permisos");
            DTOPropuesta propuesta = (DTOPropuesta) request.getAttribute("propuesta");
            Boolean esFavorita = (Boolean) request.getAttribute("esFavorita");
            
            if (propuesta != null) 
            {
        %>
            
            <div class="container mt-4">

                        
<%
    //POPUPS de aviso de acción:
    
                    String accionEfectuada = request.getParameter("accionLograda");
                    String resultadoString = request.getParameter("resultadoOperacion");
                    int resultadoDeAccion = (resultadoString != null) ? Integer.parseInt(resultadoString) : 0;
              
                    if(accionEfectuada != null && !accionEfectuada.isEmpty() && resultadoDeAccion != 0)
                    {
%>
                        <body>
                        <div class="alert alert-success">
                        <i class="bi bi-check-circle"></i> Usted ha <%=accionEfectuada%> en la propuesta exitosamente.
                        </div>
                        </body>

<%
                    }
                    if(accionEfectuada != null && !accionEfectuada.isEmpty() && permisos != 0 && resultadoDeAccion == 0) 
                    {
%>                         
                        <body>
                        <div class="alert alert-danger">
                            <i class="bi bi-x-circle"></i> Ocurrió un error o no se pudo modificar, intente nuevamente.
                        </div>
                        </body>
<%
                    }               
%>             

                    <div class="card shadow-lg p-4">
                    <div class="row g-4">
                    <div class="col-md-6">
                
                    <%
                         if (propuesta.getImagen() != null && !propuesta.getImagen().isEmpty()) 
                    {%>    
                            <img src="<%= propuesta.getImagen()%>" class="img-fluid rounded shadow mb-3" alt="Imagen Propuesta">
                    <%  } 
                        else 
                        { 
                    %>
                            <img src="imagenes/default-propuesta.png" class="img-fluid rounded shadow mb-3" alt="Sin Imagen">
                    <% 
                        }
                    %>

                        <h2 class="mb-3"><%= propuesta.getTitulo()%></h2>
                        <p class="text-muted"><%= propuesta.getDescripcion()%></p>

                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>Lugar:</strong> <%= propuesta.getLugar()%></li>
                            <li class="list-group-item"><strong>Fecha de inicio de evento:</strong> <%= propuesta.getFecha()%></li>
                            <li class="list-group-item"><strong>Precio entrada:</strong> $<%= propuesta.getPrecio()%></li>
                            <li class="list-group-item"><strong>Monto total:</strong> $<%= propuesta.getMontoTotal()%></li>                            
                    <%
                        //Dejo el estado en un formato más aceptable
                            String estadoFormateado = (String) request.getAttribute("estadoFormateado");
                    %>
                            <li class="list-group-item"><strong>Estado:</strong> <%= estadoFormateado%></li>
                            <li class="list-group-item"><strong>Fecha de finalización:</strong> <%= propuesta.getFechaExpiracion()%></li>
                            <li class="list-group-item"><strong>Proponente:</strong> <%= propuesta.nickProponenteToString()%></li>
                            <li class="list-group-item"><strong>Categoría:</strong> 
                                <%= (propuesta.getCategoria() != null) ? propuesta.getCategoria().getNombreCategoria() : "Sin categoría"%>
                            </li>
                        </ul>
      
                    </div>
                <%
                        // Solo si es 3, usuario que no propuso puede colaborar.
                    if (permisos == 3) 
                    {
                %>
                        <div class="col-md-6">
                            <div class="d-flex mb-2">
                                <form action="FavoritoServlet" method="post" class="ms-auto">
                                    <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                                    <% if (esFavorita) { %>
                                    <button type="submit" name="accion" value="quitar" class="btn btn-danger btn-sm">
                                        ❤️ Quitar Favorito
                                    </button>
                                    <% } else { %>
                                    <button type="submit" name="accion" value="agregar" class="btn btn-outline-primary btn-sm">
                                        ❤️ Marcar Favorito
                                    </button>
                                    <% }%>
                                </form>
                            </div>      
                        <div class="card p-3 shadow-sm">
                            
                            <h4 class="mb-3">Colaborar</h4>
                            <form action="DetallesDePropuesta" method="post">
                                <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                                <input type="hidden" name="accion" value="COLABORAR">
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
                <%
                        
                    } 
                    //Si el usuario es el proponente
                    if(permisos == 1)
                    {
                %>
                        <div class="col-md-6">
                            <div class="d-flex mb-2">
                                <form action="FavoritoServlet" method="post" class="ms-auto">
                                    <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                                    <% if (esFavorita) { %>
                                    <button type="submit" name="accion" value="quitar" class="btn btn-danger btn-sm">
                                        ❤️ Quitar Favorito
                                    </button>
                                    <% } else { %>
                                    <button type="submit" name="accion" value="agregar" class="btn btn-outline-primary btn-sm">
                                        ❤️ Marcar Favorito
                                    </button>
                                    <% }%>
                                </form>
                            </div>  
                        <div class="card p-3 shadow-sm">
                                
                                <h4 class="mb-3">Acciones del Proponente</h4>
                                <form 
                                    
                                    action="DetallesDePropuesta" method="post" id="formProponente">
                                    
                                    <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                                    <input type="hidden" name="accion" id="accionProponente">

                                    <button type="submit" class="btn btn-success w-100 mb-2" onclick="document.getElementById('accionProponente').value='EXTENDER';"> Extender Financiación </button>
                                    <button type="submit" class="btn btn-danger w-100" onclick="document.getElementById('accionProponente').value='CANCELAR';"> Cancelar Propuesta </button>
                                
                                </form>
                        </div>
                        </div>
                <% 
                    } 
                %>    
                </div>
                </div>

    <%      
            }
            else 
            { 
    %>
            <div class="alert alert-danger">No se pudo cargar la propuesta</div>
            <%
                String mensajeError = (String) request.getAttribute("mensaje_error");
                if (mensajeError != null) {
            %>
            <div class="alert alert-danger"><%= mensajeError%></div>
            <% } 

                }
            %>
                <div class="card mb-5"></div>
                <h4 class="mb-3">COMENTARIOS</h4>
<%
                    //Si el usuario es colaborador de esta propuestsa
                    if(permisos == 2)
                    {
                %>  
                        <div class="col-md-12">
    
                    <form action="DetallesDePropuesta" method="post">
                        <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                            <input type="hidden" name="accion" value="COMENTAR">

                            <div class="mb-3 d-flex align-items-start gap-2">
                                    <textarea class="form-control" id="comentario" name="comentario" rows="2" style="width:500px;" placeholder="Hacer Comentario" required></textarea>
                                    <button type="submit" class="btn btn-primary">Publicar</button>
                            </div> 
                    </form>


                        </div>
                                    
                <% 
                    }
            
            %>
            
            <div id="boxComentarios" >
                <%
                    Map<String, String> comentarios = propuesta.getComentarios();
                    if (comentarios != null && !comentarios.isEmpty()) {
                        for (Map.Entry<String, String> entry : comentarios.entrySet()) {
                            String usuario = entry.getKey();
                            String comentario = entry.getValue();
                %>
                <div class="card mb-2 shadow-sm">
                    <div class="card-body p-2">
                        <p class="mb-1"><b><%= usuario%>:</b></p>
                        <p class="mb-0"><%= comentario%></p>
                    </div>
                </div>    
                <%
                    }
                } else {
                %>
                <p class="text-muted">Propuesta sin comentarios.</p>
                <%
                    }
                %>
            </div>     
        </div>
            
        

    </body>
</html>
