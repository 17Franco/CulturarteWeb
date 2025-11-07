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
        <title>Pagar Colaboración</title>
        <link rel="stylesheet" href="cssBootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="CssPersonalizado/Styles.css"/>
        <script src="JS/detectorTarjeta.js" defer></script>
        <script src="jsBoostrap/bootstrap.bundle.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Kite+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet"/>
    </head>
    <body>
        <%@ include file="Componentes/Header.jsp" %>
        <div class="container my-5">
            <%
                DTOColaboracion colaboracion = (DTOColaboracion) request.getAttribute("colaboracion");
                if (colaboracion != null) {
            %>
            <h3>Pagar Colaboración</h3>
            <p><strong>Propuesta:</strong> <%= colaboracion.getPropuesta()%></p>
            <p><strong>Monto declarado al colaborar:</strong> $<%= colaboracion.getMonto()%></p>
            <form action="PagarColaboracion" method="post" id="formPago" novalidate>
                <input type="hidden" name="tituloPropuesta" value="<%= colaboracion.getPropuesta()%>">
                <div class="mb-3">
                    <label for="monto">Monto a pagar</label>
                    <input type="number" class="form-control" id="monto" name="monto" min="<%= colaboracion.getMonto()%>" value="<%= colaboracion.getMonto()%>" required>
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
                <button type="submit" class="btn btn-primary mt-3" id="btnPago">Realizar Pago</button>
            </form>
            <%
            } else {
            %>
            <div class="alert alert-danger">No se encontró la colaboración.</div>
            <%
                }
            %>
        </div>
    </body>
</html>