const btnC = document.getElementById('btnC');
const msg = document.getElementById('msgError');
const msg2 = document.getElementById('msgError2');
const msgS = document.getElementById('msgSucces');
const form = document.getElementById('formE');

btnC.addEventListener("click" , async (e)=>{
    e.preventDefault();
    const nick = document.getElementById('nick');

    if(nick && nick.value===USUARIO_LOGUEADO){
        msg.textContent = "";
        msgS.textContent = "";
        
    //llamo a una funcion que haga el fetch
    //lo envio con formatoFormulario
    const datos = new URLSearchParams();
        datos.append('NickName', nick.value);
        
      
    try {   
        
            let resp = await fetch(contextPath+`/EliminarCuenta`,{
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, 
                body: datos 

            }); 

            let data = await resp.json(); 
            //console.log(data.resp);

            if (data.resp) {
                msgS.textContent = "Usuario eliminado Con exito";
                setTimeout(() => {
                    window.location.replace(contextPath+"/");
                }, 2000);
            }else {
               msg2.textContent = "No se pudo Eliminar Usuario"; 
            }

        }catch (err) {
            console.error("Error fatal durante la verificación:", err.message);
        }
        //recibo una respuesta si es ok redirijo al index si no muestro mensaje no se pudo eliminar usuario
        
        
    }else{
      msg2.textContent="";
      msg.textContent = "NickName incorrecto";  
        
    }
    
});

