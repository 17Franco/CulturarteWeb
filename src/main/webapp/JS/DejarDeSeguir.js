

async function dejarDeSeguir(seguidor,objetivo,tarjetaPadre,lugar) {

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
        if(lugar==="Perfil"){
            verificarEstadoInicial();
       }else if(lugar==="Seguidos"){
            contenedorTarjetas.removeChild(tarjetaPadre );           
       }
    } else {
       console.log("generar mensaje");
    }

    } catch (err) {
    console.error("Error fatal durante la verificación:", err.message);
    }
}
    