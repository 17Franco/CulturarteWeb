<%-- 
    Document   : pago
    Created on : 5 nov 2025, 3:56:32
    Author     : klaas
--%>
<%@page import="logica.DTO.DTOColaboracion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/> <!-- estilos -->
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/> <!-- estilos -->
        <script  src="JS/Validacion.js" defer></script> <!-- funcionalidades -->
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script> <!-- funcionalidades -->
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet"/>
    </head>
    <body>
        
        <%@ include file="Componentes/Header.jsp" %>
        
        <div class="container my-5">
            <%
                DTOColaboracion colaboracion = (DTOColaboracion) request.getAttribute("colaboracion");
                if (colaboracion != null) {
            %>
            <h3>Pagar Colaboración</h3><br>
            <p><strong>Propuesta:</strong> <%= colaboracion.getPropuesta()%></p>
            <p><strong>Monto declarado al colaborar:</strong> $<%= colaboracion.getMonto()%></p>

            <form action="PagarColaboracion" method="post" id="formPago" novalidate>
                <input type="hidden" name="tituloPropuesta" value="<%= colaboracion.getPropuesta()%>">

                <div class="mb-3">
                    <label for="monto">Monto a pagar</label>
                    <input type="number" class="form-control" id="monto" name="monto"
                           min="<%= colaboracion.getMonto()%>" value="<%= colaboracion.getMonto()%>" required>
                </div>

                <div class="mb-3">
                    <label for="metodoPago">Método de pago</label>
                    <select class="form-select" id="metodoPago" name="formaPago" required>
                        <option value="">Seleccione...</option>
                        <option value="tarjeta">Tarjeta de crédito/débito</option>
                        <option value="transferencia">Transferencia bancaria</option>
                        <option value="paypal">PayPal</option>
                    </select>
                </div>

                <div id="detallesPago"></div>

                <button type="submit" class="btn btn-primary mt-3" id="btnPago" disabled>Realizar Pago</button>
            </form>

            <script>
            const metodoPago = document.getElementById('metodoPago');
            const detallesPago = document.getElementById('detallesPago');
            const botonPago = document.getElementById('btnPago');

            metodoPago.addEventListener('change', function()
            {
                const valor = this.value;
                detallesPago.innerHTML = '';
                botonPago.disabled = true;

                if (valor === 'tarjeta')
{
    detallesPago.innerHTML = `
    <fieldset>
        <legend>Pago con tarjeta</legend>
        <label>Tipo de tarjeta</label>
        <select class="form-select mb-2" name="dato3" required>
            <option value="">Seleccione...</option>
            <option value="visa">Visa</option>
            <option value="oca">OCA</option>
            <option value="mastercard">Master Card</option>
        </select>

        <label>Nombre del titular</label>
        <input type="text" class="form-control mb-2" name="dato1" required>

        <label>Número de tarjeta</label>
        <input type="text" class="form-control mb-2" name="dato2" maxlength="19" required>

        <label>Fecha de vencimiento</label>
        <div id="contenedorFecha"></div>

        <label>CVC</label>
        <input type="text" class="form-control mb-2" name="dato5" maxlength="4" required>
    </fieldset>`;

    const contenedor = detallesPago.querySelector('#contenedorFecha');
    crearSelectorMesAnio(contenedor);
}
else if (valor === 'transferencia')
                    {
                        detallesPago.innerHTML = `
                    <fieldset>
                        <legend>Transferencia bancaria</legend>
                        <label>Nombre del titular</label>
                        <input type="text" class="form-control mb-2" name="dato1" required>

                        <label>Número de cuenta</label>
                        <input type="text" class="form-control mb-2" name="dato2" required>

                        <label>Banco</label>
                        <input type="text" class="form-control mb-2" name="dato3" required>
                    </fieldset>`;
                    } else if (valor === 'paypal')
                    {
                        detallesPago.innerHTML = `
                    <fieldset>
                        <legend>PayPal</legend>
                        <label>Número de cuenta PayPal</label>
                        <input type="text" class="form-control mb-2" name="dato2" required>

                        <label>Nombre del titular</label>
                        <input type="text" class="form-control mb-2" name="dato1" required>
                    </fieldset>`;
                    }

                    configurarValidacion();
                });

                function configurarValidacion()
                {
                    const inputs = detallesPago.querySelectorAll('input, select');
                    inputs.forEach(inp =>
                    {
                        inp.addEventListener('input', actualizarEstadoBoton);
                        inp.addEventListener('change', actualizarEstadoBoton);
                    });
                    actualizarEstadoBoton();
                }

                function actualizarEstadoBoton()
                {
                    const visibles = detallesPago.querySelectorAll('input[required], select[required]');
                    const todosLlenos = Array.from(visibles).every(e => e.value.trim() !== '');
                    botonPago.disabled = !todosLlenos;
                }
            </script>


            <%
            } else {
            %>
            <div class="alert alert-danger">No se encontró la colaboración.</div>
            <%
                }
            %>
        </div>
    </body>
    <script src="JS/validarFechaVenc.js"></script>

</html>
