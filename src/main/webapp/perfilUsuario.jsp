
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PerfilUsuario</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
         <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
    </head>
    <body class="bg-body-secondary">
        <%@ include file="Componentes/Header.jsp" %>
        <div class="main-container">
       
        <%@ include file="Componentes/NavPerfilUsuario.jsp" %>
        
            <%
            //me Traigo de la request el dto
            DTOUsuario usr = (DTOUsuario) request.getAttribute("infoPerfil");
            
            %>
            <div class="ContenedorInfoUsuario">
                
                <div class="contenedorImg">
                     <!--muestro img llamando al sevlet IMG pasandole la ruta de la img por paremtro en la url-->
                    <img class="img" src="Img?ruta=<%= usr.getRutaImg()%>" alt="Imagen del usuario">
                </div>
                <div class="infoUsuario">
                    <script>
                        //variable golabl para usar en js
                        const USUARIO_OBJETIVO = "<%= usr.getNickname() %>"; 
                        const USUARIO_LOGUEADO = "<%= UsuarioLogueado %>"; 
                    </script>
                    <!--mostrara el icono para seguir si no es el perfil de usuario logueado-->
                    <% if(UsuarioLogueado != null && !UsuarioLogueado.equals(nick)){ %>
                    <div id="iconoSeguir" class="iconoSeguir">
                        
                    </div>
                   <%}%>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>NickName:</strong> <%=usr.getNickname()%></li>
                        <li class="list-group-item"><strong>Nombre:</strong> <%=usr.getNombre()%></li>
                        <li class="list-group-item"><strong>Apellido:</strong> <%=usr.getApellido()%></li>
                        <li class="list-group-item"><strong>Email:</strong> <%=usr.getEmail()%></li>
                        <li class="list-group-item"><strong>Fecha Nacimiento:</strong> <%=usr.getFecha()%></li>


                        <% 
                            //tipoUsr esta me lo traigo del include del navPefilUsuario 
                            if("Proponente".equals(tipoUsr)){
                             //para acceder a los get de Proponentes 
                             DTOProponente p= (DTOProponente) request.getAttribute("infoPerfil");
                        %> 
                            <li class="list-group-item"><strong>Biografia:</strong><p> <%=p.getBiografia()%> </p></li>
                            <li class="list-group-item"><strong>Direccion:</strong> <%=p.getDireccion()%></li>
                            <li class="list-group-item"><strong>Pagina Web:</strong> <%=p.getWebSite()%></li>
                        <%}%>
                    </ul>
                    

                </div>
                <!---->
            </div>   
        
        </div>
        <script src="JS/actualizarIcono.js"></script>
         <!--este js al cargar la pagina se ejecuta una funcion que verifica si el usuario del que veo perfil lo sigo o no y muestra icono correspondiente-->
        <script src="JS/MostrarIconoSeguirODejarDeSeguir.js"></script>
         <!--Este js llama a serlvet seguir y luego reactualiza el icono-->
        <script src="JS/Seguir.js"></script>
        <!--Este js llama a serlvet DejarDeseguir y luego reactualiza el icono -->
        <script src="JS/DejarDeSeguir.js"></script>
    </body>
</html>
