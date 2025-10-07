const contenedorTarjetas = document.getElementById('contenedorUsuarioSeguidos'); // ¡Asegúrate de que este ID exista en tu JSP!
const logueado = USUARIO_LOGUEADO;

//este el que contiene cada contenedor de usuario 
contenedorTarjetas.addEventListener("click", (event)=>{
    //me quedo con el elemento donde se origino el target
    const botonClickeado = event.target.closest('.btnAccionSeguimiento');
    console.log(botonClickeado);
    
    if (botonClickeado) {//si existe 
                
        //esto es para obtener el contenedor padre del boton clikeado y extraer el data-objetivo osea el nick 
        const tarjetaPadre = botonClickeado.closest('.tarjetaSeguidos');//aca objeto
        
        const objetivo = tarjetaPadre.dataset.objetivo; //aca me quedo con el texto
        //const divIcono = botonClickeado.closest('.iconoSeguir');//con esto me quedo con el contenedor padre del icono
        
        /*llamo a dejar de seguir con el nick de logueado el nick al que quiere deja de 
          seguir el div contenedor que muestra la info de ese usuario y
          un string para que sepa que accion visual deve hacer en el dom
        */
       
        dejarDeSeguir(logueado,objetivo,tarjetaPadre,null,"Seguidos");
  
    }
    
});

