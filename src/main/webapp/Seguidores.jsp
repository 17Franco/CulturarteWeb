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
                List<DTOUsuario> usr = (List<DTOUsuario>) request.getAttribute("Seguidores");
            %>
            
            <%@ include file="Componentes/NavPerfilUsuario.jsp" %>
            <div class="ContenedorUsuarioSeguidos" id="contenedorUsuarioSeguidos">
                
                <% for(DTOUsuario u: usr){ %> 
                    <!--le paso en el div el nick de usuario al cual el logueado puede llegar a seguir-->
                    <div class="tarjetaSeguidos" data-objetivo="<%= u.getNickname()%>"> 

                        <div class="contenedorImg2">
                            <img class="img2" src="Img?ruta=<%= u.getRutaImg() %>" alt="Imagen de <%= u.getNickname() %>">
                        </div>
                        <div class="info-seguido-texto">

                            <a href="PerfilUsuario?nick=<%=u.getNickname()%>&tipo=<%=u.getTipoUsr()%>">
                                <span class="nickname-texto"><%= u.getNickname() %></span>
                                <span class="tipo-texto"><%= u.getTipoUsr() %></span>
                            </a>
                            
                        </div>
                    </div> 
                <% } %>  
        </div>
        
        
    </body>
</html>
