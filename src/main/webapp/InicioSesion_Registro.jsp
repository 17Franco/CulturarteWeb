
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/> <!-- estilos -->
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/> <!-- estilos -->
        <script  src="JS/Validacion.js" defer></script> <!-- funcionalidades -->
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script> <!-- funcionalidades -->
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet"/>
        
    </head>
    <body class="bg-body-secondary">
        <%@ include file="Componentes/Header.jsp" %>
        
        <div class="container mt-xl-4">
            
        <div class="row justify-content-around">
            
            <div class="col-md-4 align-items-top"> 
                <h2 class="">Iniciar Sesion</h2>
                <form class="row g-3 needs-validation" method="post" action="Login" novalidate>

                    <div class="col-12">
                        <label for="vNick" class="form-label">NickName</label>
                        <input type="text" class="form-control border-secondary" id="vNick" name="Nickname" required>
                        <div class="invalid-feedback">
                            Ingrese Un Nickname
                        </div>
                    </div>

                    <div class="col-12">
                        <label for="vPass" class="form-label">Contrasena</label>
                        <input type="password" class="form-control border-secondary" id="vPass" name="password" required>
                        <div class="invalid-feedback">
                           Ingrese Una Contrasena
                        </div>
                    </div>

                    <div class="col-12 text-center mt-3">
                        <button class="btn btn-primary " type="submit">Iniciar Sesion</button>
                    </div>

                </form>
            </div>

            <div class="col-md-6 "> 
                <h2>Registrarse</h2>
                <form class="row g-3 needs-validation " id="formRegistro" method="post" action="Registro" enctype="multipart/form-data"  novalidate>
                    <div class="col-12 mb-3">
                        <label for="vNickR" class="form-label">NickName</label>
                        <input type="text" class="form-control border-secondary" id="vNickR" name="NickName" required>
                        <div class="invalid-feedback" id="vNickMsg">
                            Ingrese Un Nickname
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col">
                            <div class="col-12">
                                <label for="vPassR" class="form-label">Contrasena</label>
                                <input type="password" class="form-control border-secondary" id="vPassR" name="password"  required>
                                <div class="invalid-feedback">
                                   Ingrese Una Contrasena
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="col-12">
                                <label for="vPassRR" class="form-label">Repetir Contrasena</label>
                                <input type="password" class="form-control border-secondary" id="vPassRR" name="confirmPassword" required>
                                <div class="invalid-feedback" id="vrepR">
                                   Repita La contrsena
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col">
                            <div class="col-12">
                                <label for="vNombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control border-secondary" id="vNombre" name="nombre" required>
                                <div class="invalid-feedback">
                                    Ingrese Un Nickname
                                </div>
                            </div>
                        </div>
                            
                        <div class="col">
                            <div class="col-12">
                                <label for="vApellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control border-secondary" id="vApellido" name="apellido" required>
                                <div class="invalid-feedback">
                                    Ingrese un Apellido
                                </div>
                            </div>
                        </div>
                    </div>   
                     
                    <div class="row">
                        <div class="col">
                            <div class="col-12">
                                <label for="vEmail" class="form-label">Email</label>
                                <input type="email" class="form-control border-secondary" id="vEmail" name="email" required>
                                <div class="invalid-feedback" id="vEmailmsg">
                                    Ingrese un Email valido
                                </div>
                            </div>
                        </div>
                    
                   
                        <div class="col">
                            <div class="col-12">
                                <label for="vFechaNac" class="form-label">Fecha Nacimiento</label>
                                <input type="date" class="form-control border-secondary" id="vFechaNac" name="fecha"  required>
                                <div class="invalid-feedback">
                                    Ingrese una Fecha
                                </div>
                            </div>
                        </div>
                    </div>
                    

                    <div class="d-flex justify-content-around ">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" value="Colaborador" name="tipoUsuario" id="colab" checked >
                          <label class="form-check-label" for="colab">
                            Colaborador
                          </label>
                        </div>
                        <div class="form-check mx-4">
                            <input class="form-check-input" type="radio" value="Proponente" name="tipoUsuario" id="prop" >
                            <label class="form-check-label" for="prop">
                              Proponente
                            </label>
                        </div>
                    </div>
                    
                    <div class="row  d-none invisible" id="idCamposProponente">
                        <div class="col mb-2">
                            <div class="col-12" >
                                <label for="vDireccion" class="form-label">Direccion</label>
                                <input type="text" class="form-control border-secondary" id="vDireccion" name="direccion" >
                                <div class="invalid-feedback">
                                    Ingrese una direccion
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="col-12" >
                                <label for="vPaginaWeb" class="form-label">Pagina Web</label>
                                <input type="text" class="form-control border-secondary" id="vPaginaWeb" name="paginaWeb" >
                                <div class="invalid-feedback">
                                    Ingrese su Pagina Web
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-12 mb-2">
                            <label for="vBiografia" class="form-label">Biografia</label>
                            <textarea class="form-control border-secondary" id="vBiografia" name="biografia"  rows="3"></textarea>
                            <div class="invalid-feedback">
                                Ingrese una Biografia
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-12 mb-3">
                        <label for="formFile" class="form-label">Subir Imagen</label>
                        <input class="form-control border-secondary" type="file" id="formFile" name="img">
                    </div>
                            

                    <div class="col-12 text-center mt-3">
                        <button class="btn btn-primary" type="submit" >Registrarse</button>
                    </div>

                    </form>
                </div>
            </div>
        </div>
        
        <script src="JS/datosProponente.js" ></script> <!-- funcionalidades -->
        <script src="JS/validacionNickAndEmail.js" ></script> <!-- funcionalidades -->
    </body>
</html>

