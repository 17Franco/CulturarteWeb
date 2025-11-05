
<%@page import="logica.DTO.DTOUsuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seguir Usuarios</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
    </head>
    <body class="bg-body-secondary">
        <%@ include file="Componentes/Header.jsp" %>
        <div class="main-Rank">
            
            <%
            //me Traigo de la request el dto
            List<DTOUsuario> usr = (List<DTOUsuario>) request.getAttribute("RankUser");
            
            %>
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Usuario</th>
                  <th scope="col">Cant Seguidores</th>
                </tr>
              </thead>
              <tbody>
                <% int cant=1;%>
                <%for(DTOUsuario u: usr){%>
                
                <tr onclick="window.location.href='PerfilUsuario?nick=<%=u.getNickname()%>&tipo=<%=u.getTipoUsr()%>'" style="cursor:pointer;">
                    <th scope="row"><%=cant%></th>
                    <td><%=u.getNickname()%></td>
                    <td><%=u.getCantSeguidores()%></td>
                        <%cant++;%>
                </tr>
                
                <%}%>            
              </tbody>
            </table>
        </div>
    </body>
</html>
