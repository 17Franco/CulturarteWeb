(() => {
    'use strict';

    // Obtener referencias a los campos de contraseña de registro y su feedback
    const passRegistro = document.getElementById('vPassR');
    const repassRegistro = document.getElementById('vPassRR');
    const feedbackRepR = document.getElementById('vrepR');
    
    
  //controlo que escriba la misma contrasena en los dos campos
    const validarContrasenasRegistro = () => {
        // si ambos tienen algo escrito
        if (passRegistro && repassRegistro && passRegistro.value !== "" && repassRegistro.value !== "") {
            
            //si no son iguales muestro mensaje y retorno false para cando valido con el submit
            if (passRegistro.value !== repassRegistro.value) {
                repassRegistro.setCustomValidity("Las contraseñas no coinciden");
                if (feedbackRepR) {
                    feedbackRepR.textContent = "Las contraseñas no coinciden.";
                    //feedbackRepR.style.display='block';
                    repassRegistro.classList.add('is-invalid');
                }
                return false;
            } else {
                repassRegistro.setCustomValidity("");
                //si son iguales defino mensaje esandar lo oculto y devulevo true
                if (feedbackRepR) {
                    feedbackRepR.textContent = "Repita La contrsena";
                    //feedbackRepR.style.display="none";
                    repassRegistro.classList.remove('is-invalid');
                }
                return true;
            }
        }
        return true;
    };
    
    //eventos para hacerlo en tiempo real
    if(passRegistro && repassRegistro) { //aca controlo que exiten eso elementos
        passRegistro.addEventListener('input', validarContrasenasRegistro);
        repassRegistro.addEventListener('input', validarContrasenasRegistro);
    }


   
    
    // me traigo los form que tengan esa clase
    const forms = document.querySelectorAll('.needs-validation');
    
    // recorro cada form
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            const radioP = document.getElementById("prop");
            
            let esRegistro = form.querySelector('#vNickR'); 
            let contrasenasValidas = true;
            // quiero controlar contrasena igual solo en el registro
            if (esRegistro) {
                // Ejecutar la validación personalizada de contraseñas justo antes de enviar
                contrasenasValidas = validarContrasenasRegistro();
                console.log(contrasenasValidas);
            }

            // si hay campos vacios o no son iguales contrasena falla
            if (!form.checkValidity() || !contrasenasValidas) {
                event.preventDefault();
                event.stopPropagation();
            }
            
            
            // esto muestra los mensajes
            form.classList.add('was-validated');
        }, false);
    });
    
})();

