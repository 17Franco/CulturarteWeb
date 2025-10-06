async function verificarEstadoInicial() {
    const objetivo = USUARIO_OBJETIVO; 
    const seguidor = USUARIO_LOGUEADO;
    const contenedorIcono = document.getElementById('iconoSeguir');
    
    try {   
        
        let resp = await fetch(`SigueAUsuario?seguidor=${seguidor}&seguido=${objetivo}`); 

        let data = await resp.json(); 
        console.log(data.seguido);
        
        if (data.seguido) {
            if(contenedorIcono){
                contenedorIcono.innerHTML = `
                <button id="btnDejarDeSeguir" class="btnsDeS"> 
                   <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-dash-fill" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M11 7.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5"/>
                        <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                   </svg>
                
                 </button>
               `;
            }
        } else {
            if(contenedorIcono){
                contenedorIcono.innerHTML = `
                <button id="btnSeguir" class="btnsDeS"> 
                   <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-plus-fill icono-no-seguido" viewBox="0 0 16 16">
                       <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                       <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
                   </svg>
                 
                 </button>
               `;
            }
        }
        
        const btnSeguir = document.getElementById('btnSeguir'); 
        const btnDejarDeSeguir = document.getElementById('btnDejarDeSeguir'); 
            
            
        if (btnSeguir) {
             btnSeguir.addEventListener("click", seguir); 
        }
        if (btnDejarDeSeguir ) {
             btnDejarDeSeguir .addEventListener("click", dejarDeSeguir); 
        }
        
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
}

async function seguir() {
    const objetivo = USUARIO_OBJETIVO; 
    const seguidor = USUARIO_LOGUEADO;
    
    //lo envio con formatoFormulario
    const datos = new URLSearchParams();
        datos.append('seguidor', seguidor);
        datos.append('seguido', objetivo);
      
    try {   
        
        let resp = await fetch(`Seguir`,{
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, 
            body: datos 
            
        }); 

        let data = await resp.json(); 
        //console.log(data.resp);
        
        if (data.resp) {
           verificarEstadoInicial();
        } else {
           console.log("nada");
        }
     
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
    
    
    
}


async function dejarDeSeguir() {
    
   const objetivo = USUARIO_OBJETIVO; 
    const seguidor = USUARIO_LOGUEADO;
    
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
           verificarEstadoInicial();
        } else {
           console.log("generar mensaje");
        }
     
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
}

document.addEventListener('DOMContentLoaded', function() {

    verificarEstadoInicial();
    
    
    
      
    
});