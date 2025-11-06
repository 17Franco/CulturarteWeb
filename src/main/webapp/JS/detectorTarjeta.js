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

    if (!metodoPago || !detallesPago)
    {
        return;
    }
    
    metodoPago.addEventListener('change', function () 
    {
        let html = '';
        switch (this.value) 
        {
            case 'tarjeta':
                
                html = `
                        <label>Tipo de tarjeta</label>
                        <select class="form-select mb-2" name="dato1" required>
                            <option value="">Seleccione...</option>
                            <option value="visa">Visa</option>
                            <option value="oca">OCA</option>
                            <option value="mastercard">Master Card</option>
                        </select>
                        <label>Número de tarjeta</label>
                        <input type="text" class="form-control mb-2" name="dato2" maxlength="19" required>
                        <label>Fecha de vencimiento</label>
                        <input type="month" class="form-control mb-2" name="dato3" required>
                        <label>CVC</label>
                        <input type="text" class="form-control mb-2" name="dato4" maxlength="4" required>
                        <label>Nombre del titular</label>
                        <input type="text" class="form-control mb-2" name="dato5" required>
                    `;

                
                break;
                
            case 'transferencia':
                
                html = `
                        <label>Banco</label>
                        <input type="text" class="form-control mb-2" name="dato1" required>
                        <label>Número de cuenta</label>
                        <input type="text" class="form-control mb-2" name="dato2" required>
                        <label>Nombre del titular</label>
                        <input type="text" class="form-control mb-2" name="dato3" required>
                    `;

                    
                break;
                
            case 'paypal':
                
                html = `
                        <label>Cuenta PayPal</label>
                        <input type="email" class="form-control mb-2" name="dato1" required>
                        <label>Nombre del titular</label>
                        <input type="text" class="form-control mb-2" name="dato2" required>
                        `;

                        
                break;
                
            default:
                
                html = '';
        }
        
        detallesPago.innerHTML = html;

        // En tiempo real
        if (this.value === 'tarjeta') 
        {
            setTimeout(() => 
            {
                const numTarjetaInput = document.getElementById('numTarjeta');
                const tipoTarjetaSelect = document.getElementById('tipoTarjeta');

                if (!numTarjetaInput || !tipoTarjetaSelect)
                {
                    return;
                }
                
                numTarjetaInput.addEventListener('input', function () 
                {
                    const tipoSeleccionado = tipoTarjetaSelect.value;
                    const numeroLimpio = this.value.replace(/\D/g, '');
                    const tipoDetectado = detectarTipoTarjeta(numeroLimpio);

                    this.classList.remove('is-valid', 'is-invalid');

                    if (tipoSeleccionado && numeroLimpio.length >= 4) 
                    {
                        if (tipoDetectado === tipoSeleccionado) 
                        {
                            this.classList.add('is-valid'); // Bien
                        } 
                        else 
                        {
                            this.classList.add('is-invalid'); // Está ingresando un num incorrecto
                        }
                    }
                });
            }, 100);
        }
    });
});

