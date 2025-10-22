const contenedorTarjetas = document.getElementById('conteneedor_Colaboracion'); // ¡Asegúrate de que este ID exista en tu JSP!
//const logueado = USUARIO_LOGUEADO;

//este el que contiene cada contenedor de usuario 
contenedorTarjetas.addEventListener("click", (event)=>{
    //me quedo con el elemento donde se origino el target
    const botonClickeado = event.target.closest('.accion');
    console.log(botonClickeado);
    
    if (botonClickeado) {//si existe 
        //event.preventDefault();         
        //esto es para obtener el contenedor padre del boton clikeado y extraer el data-objetivo osea el nick 
        const tarjetaPadre = botonClickeado.closest('.tarjeta-propuesta-horizontal');//aca objeto
        console.log(tarjetaPadre);
        const objetivo = tarjetaPadre.dataset.objetivo; //aca me quedo con el texto
        console.log(objetivo);
        
        BajaColaboracion(objetivo,tarjetaPadre);
  
    }
    
});


