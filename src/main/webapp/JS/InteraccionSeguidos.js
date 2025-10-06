const contenedorTarjetas = document.getElementById('contenedorUsuarioSeguidos'); // ¡Asegúrate de que este ID exista en tu JSP!
const logueado = USUARIOLOGUEADO;


contenedorTarjetas.addEventListener("click", (event)=>{
    const botonClickeado = event.target.closest('.btnAccionSeguimiento');
    console.log(botonClickeado);
    
    if (botonClickeado) {
                
        //esto es para obtener el contenedor padre del boton clikeado y extraer el data-objetivo osea el nick 
        const tarjetaPadre = botonClickeado.closest('.tarjetaSeguidos');//aca objeto
        const objetivo = tarjetaPadre.dataset.objetivo; //aca me quedo con el texto
        
        dejarDeSeguir(logueado,objetivo,tarjetaPadre,"Seguidos");
  
    }
    
});

