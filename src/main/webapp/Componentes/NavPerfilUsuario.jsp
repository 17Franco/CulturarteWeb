<aside class="sidebar siderbarUsuario">
    <%
        //genero variables para quedame con nick del usuario que consulto perfiol tipo y tambien el que inicio sesion
        String nick= (String)request.getAttribute("nick");
        String tipoUsr= (String)request.getAttribute("tipo");
        String UsuarioLogueado= (String)session.getAttribute("logueado");
        String paginaAct= (String) request.getAttribute("pagina");
        
        
    %>
    <nav>
        <ul class="panelUsuario ">
            <h3>Perfil Usuario</h3>
            <a class="navPefil" href="PerfilUsuario?nick=<%=nick%>&tipo=<%=tipoUsr%>"> <li class="ItemUsuario <%= "Perfil".equals(paginaAct) ? " Activo" : "" %>">Informacion Usuario</li> </a>
            <a class="navPefil" href="UsuariosSeguidos?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "Seguidos".equals(paginaAct) ? " Activo" : "" %> ">Usuario Seguidos</li></a>
            <a class="navPefil" href="Seguidores?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "Seguidores".equals(paginaAct) ? " Activo" : "" %> ">Seguidores</li></a>
            <a class="navPefil" href="PropuestasFavoritaUsuario?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "Favoritas".equals(paginaAct) ? " Activo" : "" %> ">Propuestas Favoritas</li></a>
            <%if(("Proponente").equals(tipoUsr)){%>
                <a class="navPefil" href="PropuestasCreadas?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "Creadas".equals(paginaAct) ? " Activo" : "" %> ">Propuestas Creadas</li></a>
                <%if(session.getAttribute("logueado")!=null && UsuarioLogueado.equals(nick)){%>
                <a class="navPefil" href="CancelarPropuestas?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "Cancelar".equals(paginaAct) ? " Activo" : "" %> ">Cancelar Propuesta</li></a>
                <a class="navPefil" href="ExtenderPropuestas?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "Extender".equals(paginaAct) ? " Activo" : "" %> ">Extender Plazo Financiación</li></a>
                <%}%>
            <%}else if (("Colaborador").equals(tipoUsr)) {%>
                <a class="navPefil" href="Colaboraciones?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "Colaboraciones".equals(paginaAct) ? " Activo" : "" %> ">Colaboraciones</li></a>
                <a class="navPefil" href="ListarColaboracionesAPagar?nick=<%=nick%>&tipo=<%=tipoUsr%>"><li class="ItemUsuario <%= "PagarColaboracion".equals(paginaAct) ? " Activo" : "" %> ">Pagar Colaboración</li></a>
            <%}%>
        </ul>
    </nav>
</aside>
