const vNick = document.getElementById('vNickR');
const msg = document.getElementById('vNickMsg');
const formRegistro = document.getElementById("formRegistro");
vNick.addEventListener("blur", async ()=>{
    let valor = vNick.value.trim(); //obtengo el valor y saco espacios de sobra (inicio o final)
    //no debe ser vacio
    if(valor.length>0){
        try {   
              // Llamada al servlet pasandole el texto del input
              //await espera a que reciba la respuesta del servidor (la funcion debe ser async para usarla)
              let resp = await fetch("existeNickName?vNickR=" + encodeURIComponent(valor)); //aca hacemos la peticicon a al servlet
              let data = await resp.json(); //nos quedams con el contenido que nos interesa osea el respuesta
              console.log(data);
              // el jason de tengo es un objeto Object { existe: false } 
              if (data.existe) {//accedo al campo si es true osea existe ya el usuario entra

                vNick.setCustomValidity("NickName Ya en uso"); //esto hace que ponga invalid en css
                if (msg) {

                    msg.textContent = "NickName ya Usado."; //volvemos a poner el mensjae predeterminado
                    vNick.classList.add('is-invalid'); //mostramos el mensjae (el div en si)
                }
              } else {
                vNick.setCustomValidity(""); //esto que ponga valid agrega los etilos correspondientes
                if (msg) {
                    msg.textContent = "Ingrese Un Nickname"; //volvemos a poner el mensajae predeterminado
                    vNick.classList.remove('is-invalid'); //ocultamos el mensjae (el div en si)
                }
              }
          } catch (err) {//muestro en cosola el error 
            console.error("Error fatal durante la verificación del NickName:", err.message);
          }
      }else{
          vNick.setCustomValidity("");
          vNick.classList.remove('is-invalid');
          msg.textContent = "Ingrese Un Nickname";
      }
      
    
});

const vEamil = document.getElementById('vEmail');
const msgEmail = document.getElementById('vEmailmsg');

vEamil.addEventListener("blur", async ()=>{
    let valor = vEamil.value.trim(); //obtengo el valor y saco espacios de sobra (inicio o final)
    //no debe ser vacio
    if(valor.length>0){
        try {   
              // Llamada al servlet pasandole el texto del input
              //await espera a que reciba la respuesta del servidor (la funcion debe ser async para usarla)
              let resp = await fetch("emailUsado?vEmail=" + encodeURIComponent(valor)); //aca hacemos la peticicon a al servlet
              let data = await resp.json(); //nos quedams con el contenido que nos interesa osea el respuesta
              console.log(data);
              // el jason de tengo es un objeto Object { existe: false } 
              if (data.existe) {//accedo al campo si es true osea existe ya el usuario entra

                vEamil.setCustomValidity("Email Ya en uso"); //esto hace que ponga invalid en css
                if (msgEmail) {
                    msgEmail.textContent = "Email ya Usado."; //volvemos a poner el mensjae predeterminado
                    vEamil.classList.add('is-invalid'); //mostramos el mensjae (el div en si)
                }
              } else {
                vEamil.setCustomValidity(""); //esto que ponga valid agrega los etilos correspondientes
                if (msgEmail) {
                    msgEmail.textContent = "Ingrese Un Email"; //volvemos a poner el mensajae predeterminado
                    vEamil.classList.remove('is-invalid'); //ocultamos el mensjae (el div en si)
                }
              }
          } catch (err) {//muestro en cosola el error 
            console.error("Error fatal durante la verificación del Email:", err.message);
          }
      }else{
          vEamil.setCustomValidity("");
          vEamil.classList.remove('is-invalid');
          msgEmail.textContent = "Ingrese Un Email";
          
      }
    
});

