
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
                    <%if(usr.getRutaImg()!=null && !"".equals(usr.getRutaImg())){%>
                        <!--muestro img llamando al sevlet IMG pasandole la ruta de la img por paremtro en la url-->
                        <img class="img" src="Img?ruta=<%= usr.getRutaImg()%>" alt="Imagen del usuario">
                    <%}else{ %>
                       <img class="img" src="https://img.freepik.com/vector-gratis/circulo-azul-usuario-blanco_78370-4707.jpg" alt="Imagen de <%= usr.getNickname() %>">
                    <%}%>
                </div>
                <div class="infoUsuario">
                    <script>
                        //variable golabl para usar en js
                        const USUARIO_OBJETIVO = "<%= usr.getNickname() %>"; 
                        const USUARIO_LOGUEADO = "<%= UsuarioLogueado %>"; 
                        const contextPath = '<%= request.getContextPath() %>';
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
                    <% if(UsuarioLogueado != null && UsuarioLogueado.equals(nick) && "Proponente".equals(tipoUsr)) { %>
                    <div id="button-eliminar">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        Eliminar Cuenta
                    </button>
                    </div>
                    <%}%>
                    
                    <!-- Modal -->
                    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                      <div class="modal-dialog">
                          <form action="EliminarCuenta" method="post" id="formE">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h1 class="modal-title fs-5" id="staticBackdropLabel">Eliminar Cuenta</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                <div id="msgError2" class="text-danger small mt-2"></div>
                                <div id="msgSucces" class="text-success small mt-2"></div>
                                <p>Ingrese su nickname y confirmar para efectuar la eliminación:</p>
                                <div class="mb-3">

                                  <label for="nick" class="form-label">Nickname</label>
                                  <input type="text" class="form-control" id="nick" name="nick" required>
                                </div>
                                 <div id="msgError" class="text-danger small mt-2"></div>
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-danger" id="btnC" >Confirmar</button>
                              </div>
                            </div>
                        </form>
                      </div>
                    </div>
                    
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
        
        <script src="JS/eliminarProponente.js"></script>
    </body>
</html>
