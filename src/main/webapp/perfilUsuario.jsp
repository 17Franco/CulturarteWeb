
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
       
        <%@ include file="Componentes/NavPerfilUsuario.jsp" %>
        
         <%
            
            DTOUsuario usr = (DTOUsuario) request.getAttribute("infoPerfil");
            
            //String tipoUsr= (String)request.getAttribute("tipo"); //esta en el componente nav
            //el tipo lo saco asi porque se reutiliza para los perfiles de otros usuarios
           // if(("Colaborador").equals(tipoUsr) ){
                 //Tipo="Colaborador";
                // usr = (DTOColaborador)request.getAttribute("infoPerfil");
           // }else{
                //Tipo="Proponente";
                // usr =(DTOProponente)request.getAttribute("infoPerfil");
           // }*/

        %>
            <div class="ContenedorInfoUsuario">
                
                <div class="contenedorImg">
                    <img class="img" src="Img?ruta=<%= usr.getRutaImg()%>" alt="Imagen del usuario">
                </div>
                <div class="infoUsuario">
                    <script>
                        
                        const USUARIO_OBJETIVO = "<%= usr.getNickname() %>"; 
                        const USUARIO_LOGUEADO = "<%= UsuarioLogueado %>"; 
                    </script>
                    <% if(!UsuarioLogueado.equals(nick)){ %>
                    <div id="iconoSeguir">
                        
                    </div>
                   <%}%>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>NickName:</strong> <%=usr.getNickname()%></li>
                        <li class="list-group-item"><strong>Nombre:</strong> <%=usr.getNombre()%></li>
                        <li class="list-group-item"><strong>Apellido:</strong> <%=usr.getApellido()%></li>
                        <li class="list-group-item"><strong>Email:</strong> <%=usr.getEmail()%></li>
                        <li class="list-group-item"><strong>Fecha Nacimiento:</strong> <%=usr.getFecha()%></li>


                        <% 
                            //tipoUsr esta en el nav 
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
        <script src="JS/SigueAUsuario.js"></script>
    </body>
</html>
