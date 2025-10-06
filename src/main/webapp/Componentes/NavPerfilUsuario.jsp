

<%@page import="logica.DTO.DTOProponente"%>
<%@page import="logica.DTO.DTOUsuario"%>
<%@page import="logica.DTO.DTOColaborador"%>
<aside class="sidebar siderbarUsuario">
    <%
        String nick= (String)request.getAttribute("nick");
        String tipoUsr= (String)request.getAttribute("tipo");
        String UsuarioLogueado= (String)session.getAttribute("logueado");

    %>
    <nav>
        <ul class="panelUsuario ">
            <h3>Perfil Usuario</h3>
            <a class="navPefil" href="PerfilUsuario?nick=<%=nick%>&tipo=<%=tipoUsr%>"> <li class="ItemUsuario">Informacion Usuario</li> </a>
            <a class="navPefil" href="UsuariosSeguidos?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario">Usuario Seguidos</li></a>
            <a class="navPefil"><li class="ItemUsuario">Propuestas Favoritas</li></a>
            <%if(("Proponente").equals(tipoUsr) && UsuarioLogueado.equals(nick)){%>
            <a class="navPefil"><li class="ItemUsuario">Propuestas Creadas</li></a>
            <%}else if (("Colaborador").equals(tipoUsr) && UsuarioLogueado.equals(nick)) {%>
            <a class="navPefil"><li class="ItemUsuario">Colaboraciones</li></a>
            <%}%>
        </ul>
    </nav>
</aside>
