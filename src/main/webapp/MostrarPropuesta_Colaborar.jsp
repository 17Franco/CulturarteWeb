<%-- 
    Document   : MostrarPropuesta_Colaborar
    Created on : 3 oct 2025, 17:32:12
    Author     : asus/klaas
--%>

<%@page import="java.util.Map"%>
<%@page import="logica.DTO.DTOPropuesta"%>
<%@page import="logica.DTO.TipoRetorno"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            String mensaje_error = request.getParameter("mensaje_error");
            String accionEfectuada = request.getParameter("accionLograda");
            String tipoUsuario = (String) request.getAttribute("tipoUsuario");
            
            if (propuesta != null && mensaje_error == null) 
            {
        %>
            
            <div class="container-fluid my-4 px-3">
<%
    //POPUPS de aviso de acción:
    
                    
                    String resultadoString = request.getParameter("resultadoOperacion");
                    int resultadoDeAccion = (resultadoString != null) ? Integer.parseInt(resultadoString) : 0;
                    
                    if(accionEfectuada != null && !accionEfectuada.isEmpty() && resultadoDeAccion != 0)
                    {
%>
                        <body>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle"></i> Usted ha <%=accionEfectuada%> la propuesta exitosamente.
                        <%
                            if (accionEfectuada.equals("cancelado")) 
                            {
                        %>
                                <br>Será redirigido a la página principal en 5 segundos.
                        <%
                            }
                        %>
                        </div>
                        </body>

<%
                    }
                    if(accionEfectuada != null && accionEfectuada.equals("Error")) 
                    {
%>                         
                        <body>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-x-circle"></i> Ocurrió un error o no se pudo modificar, intente nuevamente.
                        </div>
                        </body>
<%
                    }               
%>             

                    <div class="card shadow-lg p-4">
                    <%
                    if (tipoUsuario != null && !(propuesta.getUltimoEstado().getEstadoString().equals("CANCELADA")) && !(propuesta.getUltimoEstado().getEstadoString().equals("INGRESADA"))) 
                    {%> 
                    <div class="text-end mb-2">
                            <button 
                                id="btnFavorito"
                                data-titulo="<%= propuesta.getTitulo()%>"
                                data-estado="<%= esFavorita ? "true" : "false"%>"
                                class="btn <%= esFavorita ? "btn-danger" : "btn-outline-primary"%> btn-sm">
                                ❤️ <%= esFavorita ? "Quitar Favorito" : "Marcar Favorito"%>
                            </button>
                                <script>
                                    const contextPath = '<%= request.getContextPath()%>';
                                </script>
                                <script src="JS/Favorito.js" defer></script>
                        </div>             
                    <%  } %>         
                    <div class="row g-4">
                    <div class="col-12 col-md-6">
                
                    <%
                         if (propuesta.getImagen() != null && !propuesta.getImagen().isEmpty()) 
                    {%>    
                       <!-- <img src="Img?ruta=<%= propuesta.getImagen()%>" class="img-fluid rounded shadow mb-3" alt="Imagen Propuesta">  --> 
                            <img class="propuesta-img rounded shadow mb-3 w-100" src="https://alunarte.com/wp-content/uploads/2017/07/la-propuesta.png" alt="Imagen Propuesta">
                    <%  } 
                        else 
                        { 
                    %> 
                            <!--  <img src="imagenes/default-propuesta.png" class="img-fluid rounded shadow mb-3" alt="Sin Imagen">  --> 
                            <img class="propuesta-img rounded shadow mb-3 w-100" src="https://alunarte.com/wp-content/uploads/2017/07/la-propuesta.png" alt="Imagen Propuesta">
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
                                    // Solo para colaboradores que aún no pagaron, permisos == 4
                                    if (permisos == 4) {
                                %>
                                <div class="col-12 col-md-6">
                              <h4 class="mb-3">Acreditar pago</h4>
                                <form action="PagarColaboracion" method="get">
                                    <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                                    <button type="submit" class="btn btn-primary">Proceder con los métodos de pago</button>
                                </form>
                                  </div>
                                <%
                                    }
                                %>
                            
                            </div>
                            
                            
                <%
                        // Solo si es 3, usuario que no propuso puede colaborar.
                    if (permisos == 3 && !propuesta.getUltimoEstado().getEstadoString().equals("CANCELADA") && !propuesta.getUltimoEstado().getEstadoString().equals("INGRESADA")) 
                    {
                    
                        boolean retornoEntradaGratis = false;
                        boolean retornoPorcentajeGanancia = false;

                        for(TipoRetorno ct : propuesta.getRetorno())
                        {
                            if(ct.toString().equals("Entrada Gratis"))
                            {
                                retornoEntradaGratis = true;
                            }
                            
                            if(ct.toString().equals("Porcentaje de Ganancia"))
                            {
                                retornoPorcentajeGanancia = true;
                            }
                        }



                %>
                        <div class="col-12 col-md-6">
                              
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
                                <%
                                        if(retornoPorcentajeGanancia)
                                        {
                                            %><option value="PorcentajeGanancia">Porcentaje de Ganancia</option><%       
                                        }
                                
                                        if(retornoEntradaGratis)
                                        {
                                            %><option value="EntradaGratis">Entrada Gratis</option><%           
                                        }
                                %>        
                                    </select>
                                
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Aportar</button>
                            </form>

                        </div>
                                    
                        </div>
                <%
                        
                    } 
                    //Si el usuario es el proponente
                    if(permisos == 1 && !propuesta.getUltimoEstado().getEstadoString().equals("CANCELADA") && !propuesta.getUltimoEstado().getEstadoString().equals("NO_FINANCIADA"))
                    {
                %>
                        <div class="col-12 col-md-6"> 
                        <div class="card p-3 shadow-sm">
                                
                                <h4 class="mb-3">Acciones del Proponente</h4>
                                
                                <form action="DetallesDePropuesta" method="post" id="formProponente">
                                    
                                    <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                                    <input type="hidden" name="accion" id="accionProponente">
                                   <% if(propuesta.getUltimoEstado().getEstadoString().equals("PUBLICADA") || propuesta.getUltimoEstado().getEstadoString().equals("EN_FINANCIACION")) 
                                       { %>
                                            <button type="submit" class="btn btn-success w-100 mb-2" onclick="document.getElementById('accionProponente').value='EXTENDER';"> Extender Financiación </button>
                                    <%}

                                      if(propuesta.getUltimoEstado().getEstadoString().equals("FINANCIADA")) 
                                      {%>
                                            <button type="submit" class="btn btn-danger w-100" onclick="document.getElementById('accionProponente').value='CANCELAR';"> Cancelar Propuesta </button>
                                    <%}%>
                                </form>
                                    
                        </div>
                        </div>
                <% 
                    }
                    //Si la propuesta está cancelada evito que user haga alguna acción
                    if(propuesta.getUltimoEstado().getEstadoString().equals("CANCELADA"))
                    { 
                        %>
                            <div class="col-12 col-md-6">
                            <div class="alert alert-danger">Esta propuesta está cancelada.</div>
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
                <div class="alert alert-danger">error al cargar la propuesta</div>
            <%
                
                if (mensaje_error != null) 
                {
            %>
                    <div class="alert alert-danger"><%= mensaje_error%></div>
            <%  
                } 

            }
    %>
                <div class="card mb-5"></div>
                <h4 class="mb-3">COMENTARIOS</h4>
<%
                    //Si el usuario es colaborador de esta propuestsa
                    if(permisos == 2 && propuesta.getUltimoEstado().getEstadoString().equals("FINANCIADA"))
                    {
                %>  
                        <div class="col-md-12">
    
                    <form action="DetallesDePropuesta" method="post">
                        <input type="hidden" name="tituloPropuesta" value="<%= propuesta.getTitulo()%>">
                            <input type="hidden" name="accion" value="COMENTAR">

                            <div class="mb-3 d-flex flex-column flex-md-row align-items-start gap-2">
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
                    if (comentarios != null && !comentarios.isEmpty()) 
                    {
                        for (Map.Entry<String, String> entry : comentarios.entrySet()) 
                        {
                %>        
                        
                <%        
                            String usuario = entry.getKey();
                            String comentario = entry.getValue();
                %>
                            <div class="card mb-2 shadow-sm w-100 w-md-50">
                                <div class="card-body p-2">
                                    <div class="card-body p-2 d-flex align-items-center">
                                        <div class="estiloPerfil"><%=entry.getKey().substring(0,1)%></div>
                                        <p class="mb-1"><b><%= usuario%>:</b></p>
                                    </div>
                                    <div class="mb-0 ms-5"><%= comentario%></div>
                                    
                                </div>
                            </div>    
                <%
                        }
                    } 
                    else 
                    {
                %>
                        <p class="text-muted">Propuesta sin comentarios.</p>
                <%
                    }
                %>
            </div>     
        </div>
            
        

    </body>
                    <%
                        if("cancelado".equals(accionEfectuada))
                        {
                            %>
                                <script>
                                    setTimeout(function(){window.location.href = 'index.jsp';}, 5000);
                                </script>
                            <%
                        }
                    %>

    
</html>
