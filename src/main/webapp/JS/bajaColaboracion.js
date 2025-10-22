async function BajaColaboracion(objetivo,tarjetaPadre) {

    
      
    try {   
        
        console.log(contextPath);
       let resp = await fetch(contextPath +"/bajaColaboracion?id=" + encodeURIComponent(objetivo), {
    method: 'DELETE'});
            

        let data = await resp.json(); 
        //console.log(data.resp);
        
        if (data.resp) {
            location.reload();
            //contenedorTarjetas.removeChild(tarjetaPadre ); 
           
        } else {
           console.log("nada");
        }
     
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
    
    
    
}


