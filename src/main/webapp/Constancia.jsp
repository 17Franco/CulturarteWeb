<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="logica.DTO.DTOColaboracion" %>
<%
    DTOColaboracion dto = (DTOColaboracion) request.getAttribute("colaboracion");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Previsualizar Constancia</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: "Roboto", Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .preview-card {
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        .btn-primary {
            border-radius: 30px;
        }
    </style>
</head>

<body>
<div class="container py-5">
    <h2 class="text-center mb-4 text-primary">Previsualización de Constancia de Colaboración</h2>

    <div class="preview-card mx-auto" style="max-width: 700px;">
        <div class="row gy-3">
            <div class="col-12 col-sm-6">
                <p><strong>Plataforma:</strong> Culturarte</p>
                <p><strong>Fecha de emisión:</strong> <%= new java.util.Date() %></p>
                <p><strong>Colaborador:</strong> <%= dto.getColaborador() %></p>
            </div>
            <div class="col-12 col-sm-6">
                <p><strong>Propuesta:</strong> <%= dto.getPropuesta() %></p>
                <p><strong>Monto:</strong> <%= dto.getMonto() %></p>
                <p><strong>Tipo de Retorno:</strong> <%= dto.getTipoRetorno() %></p>
            </div>
            <div class="col-12">
                <p><strong>Fecha de Creación:</strong> <%= dto.getCreado() %></p>
            </div>
        </div>

        <div class="text-center mt-4">
            <form action="GenerarConstancia" method="post" target="_blank">
                <input type="hidden" name="idColaboracion" value="<%= dto.getId() %>" />
                <button type="submit" class="btn btn-primary px-4">Generar PDF</button>
            </form>
        </div>
    </div>
</div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> <%--responsive hecho--%>

</body>
</html>
