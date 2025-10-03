
<nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Culturarte</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse "id="navbarSupportedContent">
            <form class="d-flex mx-auto w-50"  role="search">
                <input class="form-control  me-2 text-white" id="search" style="background-color:#4A90E2" type="search" placeholder="Título, descripción, lugar" aria-label="Search"/>
                <button class="btn text-white" style="background-color:#4A90E2" type="submit">Search</button>
            </form>
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0" id="ListNav">
            <!-- Aca empiezo a controlar que muestro segun si esta logueado o no  -->
            
            <!-- primero sino esta logueado en el nav quiero mostra el acceso a login/regisrto  -->
            <% if (session.getAttribute("logueado") == null) { %> 
                <li class="nav-item bg-primary-subtle-hover" >
                    <a class="nav-link" href="InicioSesion_Registro.jsp">Login/Registro</a>
                </li>
            <% } %>
            <li class="nav-item dropdown">
                <!-- aca quiero que accedan al dropdaw solo si esta logueado -->
                <a class="nav-link dropdown-toggle <%= (session.getAttribute("logueado") == null) ? "disabled" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <!-- si no esta logueado muestro Invitado sino muestro el nombre del usaurios mas Inicial  -->
                   
                    <%if(session.getAttribute("logueado") == null){ %>
                     <div class="estiloPerfil">I</div>
                        Invitado
                    <% }else { %>
                    <% 
                        String logueado = (String) session.getAttribute("logueado"); 
                        String mayus =logueado.toUpperCase();
                        String inicial = (mayus != null && !mayus.isEmpty()) ? mayus.substring(0, 1) : "";
                    %>
                    <div class="estiloPerfil"><%=inicial%></div>
                    <sapan><%=logueado%></span>
                    <%}%>
                </a>
               
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#Perfil.jsp">Perfil</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#UsuariosSeguidos.jsp">Usuarios Seguidos</a></li>
                    <li><a class="dropdown-item" href="#PropeustasFavorias.jsp">Propuestas Favoritas</a></li>
                    <!-- este campo solo estara si es Proponente -->
                    <% if(("Proponente").equals(session.getAttribute("tipoUser"))) { %>
                    <li><a class="dropdown-item" href="#PropeustasFavorias.jsp">CrearPropuesta</a></li>
                    <% }%>
                    <li><hr class="dropdown-divider"></li>
                    
                    <li><a class="dropdown-item" href="logout">Cerrar Sesion</a></li>
                    
                    
                </ul>                       
            </li>
        </ul>
        </div>
    </div>
</nav>
