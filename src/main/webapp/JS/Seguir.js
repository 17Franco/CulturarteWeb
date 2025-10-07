async function seguir(seguidor,objetivo,contenedorIcono,accion) {

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
            
           actualizarIcono(seguidor,objetivo,contenedorIcono);
        } else {
           console.log("nada");
        }
     
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
    
    
    
}
