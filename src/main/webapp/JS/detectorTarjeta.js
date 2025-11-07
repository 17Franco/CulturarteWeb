/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

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

    console.log('metodoPago:', metodoPago);
    console.log('detallesPago:', detallesPago);
    console.log('botonPago:', botonPago);

    if (!metodoPago || !detallesPago || !botonPago)
    {
        console.error('Faltan elementos en el DOM');
        return;
    }

    // Obtener el formulario y prevenir validación HTML5
    const formularioPago = botonPago.closest('form');
    if (formularioPago) {
        formularioPago.setAttribute('novalidate', 'novalidate');
        
        // ===== DEPURACIÓN: Ver qué se envía =====
        formularioPago.addEventListener('submit', function(e) {
            console.log('=== SUBMIT DEL FORMULARIO ===');
            console.log('Botón disabled:', botonPago.disabled);
            
            if (botonPago.disabled) {
                console.log('⚠️ Submit bloqueado porque el botón está deshabilitado');
                e.preventDefault();
                return false;
            }
            
            const formData = new FormData(formularioPago);
            console.log('📋 Datos que se enviarán:');
            for (let [key, value] of formData.entries()) {
                console.log(`  ${key}: ${value}`);
            }
            console.log('=============================');
        });
    }

    function crearFormularioTarjeta() {
        detallesPago.innerHTML = `
        <div id="formTarjeta">
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
        `;
        console.log('✓ Formulario de tarjeta creado');
        configurarValidacionTarjeta();
    }

    function crearFormularioTransferencia() {
        detallesPago.innerHTML = `
        <div id="formTransferencia">
            <label>Nombre del titular</label>
            <input type="text" class="form-control mb-2" name="dato1" required>
            <label>Número de cuenta</label>
            <input type="text" class="form-control mb-2" name="dato2" required>
            <label>Banco</label>
            <input type="text" class="form-control mb-2" name="dato3" required>
        </div>
        `;
        console.log('✓ Formulario de transferencia creado');
        configurarValidacionGeneral();
    }

    function crearFormularioPaypal() {
        detallesPago.innerHTML = `
        <div id="formPaypal">
            <label>Número de cuenta PayPal</label>
            <input type="text" class="form-control mb-2" name="dato1" required>
            <label>Nombre del titular</label>
            <input type="text" class="form-control mb-2" name="dato2" required>
        </div>
        `;
        console.log('✓ Formulario de PayPal creado');
        configurarValidacionGeneral();
    }

    function configurarValidacionTarjeta() {
        const numTarjetaInput = document.getElementById('numTarjeta');
        const tipoTarjetaSelect = document.getElementById('tipoTarjeta');
        
        if (numTarjetaInput && tipoTarjetaSelect) {
            //En tiempo real, valida el numero de la tarjeta
            numTarjetaInput.addEventListener('input', function() {
                const numeroLimpio = this.value.replace(/\D/g,'');
                const tipoDetectado = detectarTipoTarjeta(numeroLimpio);

                this.classList.remove('is-valid','is-invalid');
                if (tipoTarjetaSelect.value && numeroLimpio.length >= 4) {
                    if (tipoDetectado === tipoTarjetaSelect.value) 
                        this.classList.add('is-valid');
                    else 
                        this.classList.add('is-invalid');
                }

                actualizarEstadoBoton();
            });

            tipoTarjetaSelect.addEventListener('change', actualizarEstadoBoton);
        }

        configurarValidacionGeneral();
    }

    function configurarValidacionGeneral() {
        //Escaneo inputs en tiempo real
        const inputs = detallesPago.querySelectorAll('input, select');
        console.log(`📝 Configurando validación para ${inputs.length} campos`);
        inputs.forEach(el => {
            el.addEventListener('input', actualizarEstadoBoton);
            el.addEventListener('change', actualizarEstadoBoton);
        });
        
        // Actualizar inmediatamente
        actualizarEstadoBoton();
    }

    function actualizarEstadoBoton() {
        let habilitar = false;

        console.log('🔍 Actualizando estado del botón...');
        console.log('  Método seleccionado:', metodoPago.value);

        if (metodoPago.value === 'tarjeta') {
            const inputs = detallesPago.querySelectorAll('input, select');
            const todosLlenos = [...inputs].every(inp => inp.value.trim() !== '');
            const tipoValido = tipoDetectadoValido();
            console.log('  Tarjeta - Todos llenos:', todosLlenos, 'Tipo válido:', tipoValido);
            habilitar = todosLlenos && tipoValido;
        } else if (metodoPago.value === 'transferencia' || metodoPago.value === 'paypal') {
            const inputs = detallesPago.querySelectorAll('input');
            console.log(`  ${metodoPago.value} - Campos encontrados:`, inputs.length);
            inputs.forEach((inp, idx) => {
                console.log(`    Campo ${idx}: name="${inp.name}", value="${inp.value}"`);
            });
            habilitar = [...inputs].every(inp => inp.value.trim() !== '');
            console.log(`  ${metodoPago.value} - Todos llenos:`, habilitar);
        }

        console.log('  ➜ Botón habilitado:', habilitar);
        botonPago.disabled = !habilitar;
    }

    function tipoDetectadoValido() {
        const numTarjetaInput = document.getElementById('numTarjeta');
        const tipoTarjetaSelect = document.getElementById('tipoTarjeta');
        
        if (!numTarjetaInput || !tipoTarjetaSelect) return false;
        
        const numeroLimpio = numTarjetaInput.value.replace(/\D/g,'');
        const tipoDetectado = detectarTipoTarjeta(numeroLimpio);
        return tipoDetectado === tipoTarjetaSelect.value;
    }

    //Detector de cambios
    metodoPago.addEventListener('change', function() {
        console.log('💳 Método de pago cambiado a:', this.value);
        detallesPago.innerHTML = ''; // Limpiar contenido
        botonPago.disabled = true; // Deshabilitar botón

        if (this.value === 'tarjeta') {
            crearFormularioTarjeta();
        } else if (this.value === 'transferencia') {
            crearFormularioTransferencia();
        } else if (this.value === 'paypal') {
            crearFormularioPaypal();
        }
    });

    botonPago.disabled = true; // Deshabilitar botón hasta que todo sea válido
    console.log('✓ Script de validación de pago inicializado');
});