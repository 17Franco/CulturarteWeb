

async function dejarDeSeguir(seguidor,objetivo,tarjetaPadre,contenedorIcono,accion) {

//lo envio con formatoFormulario
const datos = new URLSearchParams();
    datos.append('seguidor', seguidor);
    datos.append('seguido', objetivo);

try {   
    //hago la peticion y mando los datos en el cuerpo 
    let resp = await fetch(`DejarDeSeguir`,{
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, 
        body: datos 

    }); 

    let data = await resp.json(); 
    //console.log(data.resp);

    if (data.resp) {
        if(accion==="Perfil"){
            //esta accion se realizaria cundo esta en la pagina del perfilUsuario
            actualizarIcono(seguidor,objetivo,contenedorIcono);
       }else if(accion==="Seguidos"){
           //esta accion se realizaria cundo esta en la pagina del usuariosSeguidos
            contenedorTarjetas.removeChild(tarjetaPadre );           
       }
    } else {
       console.log("generar mensaje");
    }

    } catch (err) {
    console.error("Error fatal durante la verificación:", err.message);
    }
}
    