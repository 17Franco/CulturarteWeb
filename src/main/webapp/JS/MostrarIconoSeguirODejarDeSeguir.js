
//cuando carga la pagina para decidir que icono va a mostrar 
document.addEventListener('DOMContentLoaded', function() {
    const objetivo = USUARIO_OBJETIVO; 
    const seguidor = USUARIO_LOGUEADO;
    const contenedorIcono = document.getElementById('iconoSeguir');
    
    if(seguidor && seguidor !== "null"){
       actualizarIcono(seguidor,objetivo,contenedorIcono); 
    }

});