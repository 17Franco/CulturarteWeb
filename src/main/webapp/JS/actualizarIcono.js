async function actualizarIcono(seguidor,objetivo,contenedorIcono) {
    
    try {   
        //peticion get al servlet SigueAUsuario devuelve true o false pasandole nick del logueado y el de que quiere saber si sigue o no
        let resp = await fetch(`SigueAUsuario?seguidor=${seguidor}&seguido=${objetivo}`); 
        // se hace con await porque nesesito la repuesta para que siga con ejecutando la funcion
        let data = await resp.json(); 
        console.log(data.seguido);
        //si es true muestro icono dejar de seguir metiendo el html dentro del contenedor padre
        if (data.seguido) {
            if(contenedorIcono){
                contenedorIcono.innerHTML = `
                <button id="btnDejarDeSeguir_${objetivo}" class="btnsDeS"> 
                   <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-dash-fill" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M11 7.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5"/>
                        <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                   </svg>
                
                 </button>
               `;
            }
        } else {
             //si es true muestro icono seguir metiendo el html dentro del contenedor padre
            if(contenedorIcono){
                contenedorIcono.innerHTML = `
                <button id="btnSeguir_${objetivo}" class="btnsDeS"> 
                   <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-plus-fill icono-no-seguido" viewBox="0 0 16 16">
                       <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                       <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
                   </svg>
                 
                 </button>
               `;
            }
        }
        //me quedo con el elemento button seguir y dejar de seguir 
        const btnSeguir = document.getElementById(`btnSeguir_${objetivo}`); 
        const btnDejarDeSeguir = document.getElementById(`btnDejarDeSeguir_${objetivo}`);
            
        //dependiendo de quien existe agrego evento donde se ejecutara seguir o dejar de seguir    
        if (btnSeguir) {
            //aca paso la info con accion en perfil por lo tanto debe ir el contenedorIcono
             btnSeguir.addEventListener("click", ()=> seguir(seguidor,objetivo,contenedorIcono,null)); 
        }
        if (btnDejarDeSeguir ) {
            //aca paso la info con accion en perfil por lo tanto debe ir el contenedorIcono 
             btnDejarDeSeguir .addEventListener("click", ()=> dejarDeSeguir(seguidor,objetivo,null,contenedorIcono,"Perfil")); 
        }
        
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
}