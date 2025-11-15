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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Constancia de Colaboraciones</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
        <link rel="stylesheet" href="CssPersonalizado/propuestas.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
        
        <style>
            /* Estilos responsive personalizados */
            .propuestas-contenedor {
                padding: 15px;
            }
            
            .tarjeta-propuesta-horizontal {
                display: flex;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                overflow: hidden;
                height: 100%;
                transition: transform 0.2s;
            }
            
            .tarjeta-propuesta-horizontal:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            
            .imagen-area {
                flex: 0 0 200px;
                min-height: 200px;
            }
            
            .propuesta-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .texto-area {
                flex: 1;
                padding: 20px;
                display: flex;
                flex-direction: column;
            }
            
            .texto-area h5 {
                margin-bottom: 15px;
                color: #333;
            }
            
            .texto-area p {
                margin-bottom: 10px;
                font-size: 0.95rem;
            }
            
            .btn-group {
                margin-top: auto;
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            
            .btn-group .btn {
                flex: 1;
                min-width: 120px;
            }
            
            /* Responsive para tablets */
            @media (max-width: 992px) {
                .p-2[style*="flex: 0 0 50%"] {
                    flex: 0 0 100% !important;
                    max-width: 100%;
                }
                
                .imagen-area {
                    flex: 0 0 180px;
                }
            }
            
            /* Responsive para móviles */
            @media (max-width: 768px) {
                .propuestas-contenedor {
                    padding: 10px;
                }
                
                .p-2[style*="flex: 0 0 50%"] {
                    flex: 0 0 100% !important;
                    max-width: 100%;
                    padding: 0.5rem !important;
                }
                
                .tarjeta-propuesta-horizontal {
                    flex-direction: column;
                    margin-bottom: 15px;
                }
                
                .imagen-area {
                    flex: 0 0 auto;
                    min-height: 200px;
                    max-height: 250px;
                }
                
                .texto-area {
                    padding: 15px;
                }
                
                .texto-area h5 {
                    font-size: 1.1rem;
                    margin-bottom: 12px;
                }
                
                .texto-area p {
                    font-size: 0.9rem;
                    margin-bottom: 8px;
                }
                
                .btn-group {
                    flex-direction: column;
                    gap: 8px;
                }
                
                .btn-group .btn {
                    width: 100%;
                    min-width: auto;
                }
            }
            
            /* Responsive para móviles pequeños */
            @media (max-width: 480px) {
                .main-container {
                    padding: 0;
                }
                
                .propuestas-contenedor {
                    padding: 5px;
                }
                
                .imagen-area {
                    min-height: 180px;
                    max-height: 200px;
                }
                
                .texto-area {
                    padding: 12px;
                }
                
                .texto-area h5 {
                    font-size: 1rem;
                }
                
                .texto-area p {
                    font-size: 0.85rem;
                }
                
                .texto-area p strong {
                    display: block;
                    margin-bottom: 2px;
                }
            }
        </style>
    </head>

    <body class="bg-body-secondary">
        <%@ include file="Componentes/Header.jsp" %>
        <div class="main-container">
            <%
                 String UsuarioLogueado = (String) session.getAttribute("logueado");
                %>

            <script>
            const contextPath = '<%= request.getContextPath()%>';
            </script>

            <%
                List<DtoColaboracion> pendientesDePago = (List<DtoColaboracion>) request.getAttribute("colaboracionesAPagar");
            %>

            <div class="propuestas-contenedor d-flex flex-wrap" id="conteneedor_Colaboracion">
    <% for(DtoColaboracion colab : pendientesDePago) { %>
        <div class="p-2" style="flex: 0 0 50%;">
            <div class="tarjeta-propuesta-horizontal" data-objetivo="<%= colab.getId() %>"> 

                <div class="imagen-area">
                    <% String ruta = "https://raw.githubusercontent.com/17Franco/Culturarte/refs/heads/main/propAssets/" 
                                    + colab.getPropuesta().replace(" ", "%2B") + ".jpg"; 
                    if (colab.getImgDePropuesta() != null && !"".equals(colab.getImgDePropuesta())) { %>
                        <img src="Img?ruta=<%= colab.getImgDePropuesta()%>" alt="<%= colab.getPropuesta()%>" 
                             class="propuesta-img" onerror="this.onerror=null; this.src='<%= ruta %>';">
                    <% } else { %>
                        <img class="propuesta-img" src="<%=ruta%>" alt="Imagen de propuesta">
                    <% } %>
                </div>

                <div class="texto-area">
                    <h5 class="card-title">Colaboración</h5>
                    <p><strong>Título:</strong> <%= colab.getPropuesta()%></p>
                    <p><strong>Monto Colaborado:</strong> <%= colab.getMonto()%></p>

                    <%
                        String fechaStr = colab.getCreadoString();
                        String fechaFormateada = fechaStr;

                        if (fechaStr != null && !fechaStr.isEmpty()) {
                            java.time.LocalDate fecha = java.time.LocalDate.parse(fechaStr);
                            fechaFormateada = fecha.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
                        }
                    %>
                    <p><strong>Fecha Realizada:</strong> <%= fechaFormateada %></p>

                    <% if (colab.getTipoRetorno().toString().equals("ENTRADA_GRATIS")) { %>
                        <p><strong>Retorno:</strong> Entrada Gratis</p>
                    <% } else { %>
                        <p><strong>Retorno:</strong> Porcentaje ganancia</p>
                    <% } %>

                    <div class="btn-group" role="group">
                        <% if (session.getAttribute("logueado") != null && UsuarioLogueado.equals(colab.getColaborador()) 
                               && !colab.getPropuesta().equals("Cine en el Botanico")) { %>
                            <a href="${pageContext.request.contextPath}/PagarColaboracion?tituloPropuesta=<%= java.net.URLEncoder.encode(colab.getPropuesta(), "UTF-8")%>" 
                               class="btn btn-primary">Acreditar Pago</a>
                        <% } %>

                        <a href="${pageContext.request.contextPath}/DetallesDePropuesta?id=<%= colab.getPropuesta()%>" 
                           class="btn btn-secondary">Detalles</a>
                    </div>
                </div>

            </div>
        </div>
    <% } %>
</div>
        </div>

        <script src="JS/InteraccionColaboracion.js"></script>
        <script src="JS/bajaColaboracion.js"></script>
        <script src="JS/formatoPopUpPago.js"></script>
    </body>
</html>