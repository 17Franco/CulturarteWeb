async function BajaColaboracion(objetivo,tarjetaPadre) {
 
    try {   
        
       console.log(objetivo);
       
       let resp = await fetch(contextPath +"/bajaColaboracion?id=" + encodeURIComponent(objetivo), {
        method: 'DELETE'});
            

        let data = await resp.json(); 
        //console.log(data.resp);
        //if (!resp.ok) throw new Error(`HTTP error! status: ${resp.status}`);
        if (data.resp) {
            //location.reload();
            tarjetaPadre.remove();
           
        } else {
           console.log("nada");
        }
     
    } catch (err) {
        console.error("Error fatal durante la verificación:", err.message);
    }
    
    
    
}


