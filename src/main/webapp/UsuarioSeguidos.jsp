
<%@page import="webservices.DtoUsuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
    </head>
    <body class="bg-body-secondary">
        <%@ include file="Componentes/Header.jsp" %>
        <div class="main-container">
            <!--me traigo los que sigue el usuario al que estoy consultando el perfil-->
            <% 
                List<DtoUsuario> usr = (List<DtoUsuario>) request.getAttribute("UsuariosSeguidos");
            %>
            
            <%@ include file="Componentes/NavPerfilUsuario.jsp" %>
            <div class="ContenedorUsuarioSeguidos" id="contenedorUsuarioSeguidos">
                <script>
                    // para poder acceder al nick del usr logueado en mi js
                    const USUARIO_LOGUEADO = "<%= UsuarioLogueado %>"; 
                </script>
                <% for(DtoUsuario u: usr){ %> 
                    <!--le paso en el div el nick de usuario al cual el logueado puede llegar a seguir-->
                    <div class="tarjetaSeguidos" data-objetivo="<%= u.getNickname()%>"> 

                        <div class="contenedorImg2">
                            <%if(u.getRutaImg()!=null && !"".equals(u.getRutaImg())){%>
                                <img class="img2" src="Img?ruta=<%= u.getRutaImg() %>" alt="Imagen de <%= u.getNickname() %>">
                            <%}else{ %>
                            <!--le agrego una img generica si no tiene imagen -->
                                <img class="img2" src="https://img.freepik.com/vector-gratis/circulo-azul-usuario-blanco_78370-4707.jpg" alt="Imagen de <%= u.getNickname() %>">
                            <%}%>
                        </div>


                        <div class="info-seguido-texto">

                            <a href="PerfilUsuario?nick=<%=u.getNickname()%>&tipo=<%=u.getTipoUsr()%>">
                                <span class="nickname-texto"><%= u.getNickname() %></span>
                                <span class="tipo-texto"><%= u.getTipoUsr() %></span>
                            </a>
                            <!--solo mostrara el icono dejar de seguir si estoy enel perfil del usuario Logueado y nosea vacio-->
                            <% if(!("").equals(UsuarioLogueado) && UsuarioLogueado!=null && UsuarioLogueado.equals(nick)){ %>
                            <div id="iconoSeguir<%=u.getNickname()%>" class="iconoSeguir">
                                <button class="btnsDeS btnAccionSeguimiento"> 
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-dash-fill" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M11 7.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5"/>
                                    <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                                </svg>
                                </button>
                            </div>
                            <%}%>
                        </div>
                    </div> 
                <% } %>  
        </div>
        <!--js donde le asigno evento click a los botones  del icono usando delegacion de evento en el div contenedor -->
        <script src="JS/InteraccionSeguidos.js"></script>
        <!--js donde llama al servlet dejar de seguir en este caso saca del contenedoor al contenedor del usuario que dejo de seguir-->
        <script src="JS/DejarDeSeguir.js"></script>
        
    </body>
</html>
