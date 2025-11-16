
<nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand d-none d-lg-flex" href="<%=request.getContextPath() + "/" %>">Culturarte</a>
        <%if (session.getAttribute("logueado") == null) { %>
            <a class="navbar-brand d-lg-none" href="#">Culturarte</a>
        <% } else { %>
            <a class="navbar-brand d-lg-none" href="#">Bienvenido <%=session.getAttribute("logueado")%></a>
        <%}%>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse "id="navbarSupportedContent">
           
            <form class="d-flex mx-auto w-50 d-none d-lg-flex"  role="search" action="Buscador" method="get">
                <input 
                    class="form-control me-2 text-white" 
                    id="search" 
                    name="filtro" 
                    style="background-color:#4A90E2" 
                    type="search" 
                    placeholder="Título, descripción, lugar" 
                    aria-label="Search"
                />
                
                <div class="form-check form-check-inline ms-2">
                    <input class="form-check-input" type="radio" name="orden" id="radioTitulo" value="titulo" checked>
                    <label class="form-check-label" for="radioTitulo">A/Z</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="orden" id="radioFecha" value="fecha">
                    <label class="form-check-label" for="radioFecha">Fecha</label>
                </div>
                
                <button class="btn text-white" style="background-color:#4A90E2" type="submit">
                    Buscar
                </button>
            </form>           
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0" id="ListNav">
                <!-- Aca empiezo a controlar que muestro segun si esta logueado o no  -->

                <!-- primero sino esta logueado en el nav quiero mostra el acceso a login/regisrto  -->
                <% if (session.getAttribute("logueado") == null) { %> 
                <li class="nav-item bg-primary-subtle-hover d-none d-lg-block" >
                    <a class="nav-link" href="InicioSesion_Registro.jsp">Login/Registro</a>
                </li>
                <% }%>
                <% if(session.getAttribute("logueado")==null) { %>
                <li><a class="dropdown-item d-none d-lg-block" href="listarUsuarios">Ver Usuarios</a></li>
                <%}%>

                <li class="nav-item bg-primary-subtle-hover" >
                    <a class="nav-link d-none d-lg-block" href="RankUsuario">RankingUsuarios</a>
                </li>
                
                <!--item de que solo se mostrara en movil-->
                <% if(session.getAttribute("logueado")!=null) { %>
                <div class="d-lg-none">
                <li class="nav-item bg-primary-subtle-hover d" >
                    <a class="nav-link" href="<%=request.getContextPath() + "/" %>">ConsultarPropuestas</a>
                </li>
                
                <li class="nav-item bg-primary-subtle-hover " >
                    <a class="nav-link" href="ListarColaboracionesAPagar?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Pagar Colaboracion</a>
                </li>
                
                <li class="nav-item bg-primary-subtle-hover " >
                    <a class="nav-link" href="logout">Cerrar Sesion</a>
                </li>
                <% }%>

                </div>
                
                <!--menu desplegable perfil-->
                <li class="nav-item dropdown d-none d-lg-block">
                    <!-- aca quiero que accedan al dropdaw solo si esta logueado -->
                    <a class="nav-link dropdown-toggle <%= (session.getAttribute("logueado") == null) ? "disabled" : ""%>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <!-- si no esta logueado muestro Invitado sino muestro el nombre del usaurios mas Inicial  -->

                        <%if (session.getAttribute("logueado") == null) { %>
                        <div class="estiloPerfil">I</div>
                        Invitado
                        <% } else { %>
                        <%
                            String logueado = (String) session.getAttribute("logueado");
                            String mayus = logueado.toUpperCase();
                            String inicial = (mayus != null && !mayus.isEmpty()) ? mayus.substring(0, 1) : "";
                        %>
                        <div class="estiloPerfil"><%=inicial%></div>
                        <sapan><%=logueado%></span>
                        <%}%>
                    </a>
               
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="PerfilUsuario?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Perfil</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="UsuariosSeguidos?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Usuarios Seguidos</a></li>
                    <li><a class="dropdown-item" href="Seguidores?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Seguidores</a></li>
                    <li><a class="dropdown-item" href="listarUsuarios">Ver Usuarios</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="PropuestasFavoritaUsuario?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Propuestas Favoritas</a></li>
                    <% if(("Proponente").equals(session.getAttribute("tipoUser"))) { %>
                    <li><a class="dropdown-item" href="PropuestasCreadas?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Propuestas Creadas</a></li>
                    <li><a class="dropdown-item" href="CancelarPropuestas?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Cancelar Propuesta</a></li>
                    <li><a class="dropdown-item" href="ExtenderPropuestas?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Extender Plazo Financiación</a></li>

                    <% }%>
                    <% if(("Colaborador").equals(session.getAttribute("tipoUser"))) { %>
                    <li><a class="dropdown-item" href="Colaboraciones?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Colaboracion</a></li>
                    <li><a class="dropdown-item" href="ListarColaboracionesAPagar?nick=<%=session.getAttribute("logueado")%>&tipo=<%=session.getAttribute("tipoUser")%>">Pagar Colaboración</a></li>
                    <% }%>
                    <!-- este campo solo estara si es Proponente -->
                   
                    <% if(("Proponente").equals(session.getAttribute("tipoUser"))) { %>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/AltaPropuesta">CrearPropuesta</a></li>
                    <% }%>
                    <li><hr class="dropdown-divider"></li>
                   
                    <li><a class="dropdown-item" href="logout">Cerrar Sesion</a></li>
                    
                    
                </ul>
                
            </li>
        </ul>
        </div>
    </div>
</nav>
