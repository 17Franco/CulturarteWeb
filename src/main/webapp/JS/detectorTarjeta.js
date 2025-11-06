function detectarTipoTarjeta(num) //Para saber si es cada tarjeta en tiempo real
{
    if (num.startsWith('4'))    //Si es con 4 es visa
    {
        return 'visa';
    }

    const masterCardNumeros = ['51','52','53','54','55','22','23','24','25','26','27']; //Numeros de mc

    let pass = false;
    
    for (const p of masterCardNumeros) 
    {
        if (num.startsWith(p)) 
        {
            pass = true;
            break;
        }
    }

    if (pass === true) 
    {
        return 'mastercard';
    }
   
    if (num.startsWith('589562'))   //Creo que es este el de oca
    {
        return 'oca';
    }

    return null;
}

document.addEventListener('DOMContentLoaded', function () 
{
    const metodoPago = document.getElementById('metodoPago');
    const detallesPago = document.getElementById('detallesPago');
    const botonPago = document.querySelector('button[type="submit"]');

    if (!metodoPago || !detallesPago || !botonPago)
    {
        return;
    }

    //Formularios switcheables
    detallesPago.innerHTML = `
    <div id="formTarjeta" class="d-none">
        <label>Tipo de tarjeta</label>
        <select class="form-select mb-2" id="tipoTarjeta" name="dato3" required>
            <option value="">Seleccione...</option>
            <option value="visa">Visa</option>
            <option value="oca">OCA</option>
            <option value="mastercard">Master Card</option>
        </select>
        <label>Nombre del titular</label>
        <input type="text" class="form-control mb-2" name="dato1" required>
        <label>Número de tarjeta</label>
        <input type="text" class="form-control mb-2" name="dato2" id="numTarjeta" maxlength="19" required>
        <label>Fecha de vencimiento</label>
        <input type="month" class="form-control mb-2" name="dato4" required>
        <label>CVC</label>
        <input type="text" class="form-control mb-2" name="dato5" maxlength="4" required>
    </div>

    <div id="formTransferencia" class="d-none">
        <label>Nombre del titular</label>
        <input type="text" class="form-control mb-2" name="dato1" required>
        <label>Número de cuenta</label>
        <input type="text" class="form-control mb-2" name="dato2" required>
        <label>Banco</label>
        <input type="text" class="form-control mb-2" name="dato3" required>
    </div>

    <div id="formPaypal" class="d-none">
        <label>Número de cuenta PayPal</label>
        <input type="number" class="form-control mb-2" name="dato1" required>
        <label>Nombre del titular</label>
        <input type="text" class="form-control mb-2" name="dato2" required>
    </div>
    `;

    const formTarjeta = document.getElementById('formTarjeta');
    const formTransferencia = document.getElementById('formTransferencia');
    const formPaypal = document.getElementById('formPaypal');
    const numTarjetaInput = document.getElementById('numTarjeta');
    const tipoTarjetaSelect = document.getElementById('tipoTarjeta');

    function actualizarEstadoBoton() 
    {
        let habilitar = false;

        // Validación de cada método de pago
        if (metodoPago.value === 'tarjeta') 
        {
            const inputs = formTarjeta.querySelectorAll('input, select');
            habilitar = [...inputs].every(inp => inp.checkValidity()) && tipoDetectadoValido();
        } 
        else if (metodoPago.value === 'transferencia') 
        {
            const inputs = formTransferencia.querySelectorAll('input');
            habilitar = [...inputs].every(inp => inp.checkValidity());
        } 
        else if (metodoPago.value === 'paypal') 
        {
            const inputs = formPaypal.querySelectorAll('input');
            habilitar = [...inputs].every(inp => inp.checkValidity());
        }

        botonPago.disabled = !habilitar;
    }

    function tipoDetectadoValido() 
    {
        const numeroLimpio = numTarjetaInput.value.replace(/\D/g,'');
        const tipoDetectado = detectarTipoTarjeta(numeroLimpio);
        return tipoDetectado === tipoTarjetaSelect.value;
    }

    //Detector de cambios
    metodoPago.addEventListener('change', function() 
    {
        formTarjeta.classList.add('d-none');
        formTransferencia.classList.add('d-none');
        formPaypal.classList.add('d-none');

        if (this.value === 'tarjeta') formTarjeta.classList.remove('d-none');
        if (this.value === 'transferencia') formTransferencia.classList.remove('d-none');
        if (this.value === 'paypal') formPaypal.classList.remove('d-none');

        actualizarEstadoBoton();
    });

    //Escaneo inputs en tiempo real
    formTarjeta.querySelectorAll('input, select').forEach(el => 
    {
        el.addEventListener('input', actualizarEstadoBoton);
        el.addEventListener('change', actualizarEstadoBoton);
    });

    formTransferencia.querySelectorAll('input').forEach(el => 
    {
        el.addEventListener('input', actualizarEstadoBoton);
        el.addEventListener('change', actualizarEstadoBoton);
    });

    formPaypal.querySelectorAll('input').forEach(el => 
    {
        el.addEventListener('input', actualizarEstadoBoton);
        el.addEventListener('change', actualizarEstadoBoton);
    });

    //En tiempo real, valida el numero de la tarejta
    if (numTarjetaInput && tipoTarjetaSelect) 
    {
        numTarjetaInput.addEventListener('input', function() 
        {
            const numeroLimpio = this.value.replace(/\D/g,'');
            const tipoDetectado = detectarTipoTarjeta(numeroLimpio);

            this.classList.remove('is-valid','is-invalid');
            if (tipoTarjetaSelect.value && numeroLimpio.length >= 4) 
            {
                if (tipoDetectado === tipoTarjetaSelect.value) 
                    this.classList.add('is-valid');
                else 
                    this.classList.add('is-invalid');
            }

            actualizarEstadoBoton();
        });

        tipoTarjetaSelect.addEventListener('change', actualizarEstadoBoton);
    }

    botonPago.disabled = true; // Deshabilitar botón hasta que todo sea válido
});
