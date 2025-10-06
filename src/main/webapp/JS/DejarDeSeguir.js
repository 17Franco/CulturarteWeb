const contenedorTarjetas = document.getElementById('contenedorUsuarioSeguidos'); // ¡Asegúrate de que este ID exista en tu JSP!
const logueado = USUARIOLOGUEADO;


contenedorTarjetas.addEventListener("click", (event)=>{
    const botonClickeado = event.target.closest('.btnAccionSeguimiento');
    console.log(botonClickeado);
    
    if (botonClickeado) {
                
        //esto es para obtener el contenedor padre del boton clikeado y extraer el data-objetivo osea el nick 
        const tarjetaPadre = botonClickeado.closest('.tarjetaSeguidos');//aca objeto
        const objetivo = tarjetaPadre.dataset.objetivo; //aca me quedo con el texto
        
        dejarDeSeguir(logueado,objetivo,tarjetaPadre);
  
    }
    
});


    async function dejarDeSeguir(seguidor,objetivo,tarjetaPadre) {
    
  
    
    //lo envio con formatoFormulario
    const datos = new URLSearchParams();
        datos.append('seguidor', seguidor);
        datos.append('seguido', objetivo);
      
    try {   
        
        let resp = await fetch(`DejarDeSeguir`,{
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, 
            body: datos 
            
        }); 

        let data = await resp.json(); 
        console.log(data.resp);
        
        if (data.resp) {
           contenedorTarjetas.removeChild(tarjetaPadre );
        } else {
           console.log("generar mensaje");
        }
     
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
}
    