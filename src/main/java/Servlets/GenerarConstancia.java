package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import logica.Colaboracion.GeneradorPDF;
import logica.DTO.DTOColaboracion;
import logica.Manejadores.ManejadorColaboracion;

@WebServlet("/GenerarConstancia")
public class GenerarConstancia extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            //obtengo la id desde el form
            Long idColaboracion = Long.parseLong(request.getParameter("idColaboracion"));

            // obtengo la colab desde el manejadorcolab 
            ManejadorColaboracion manejador = ManejadorColaboracion.getInstance();
            DTOColaboracion dto = manejador.getColaboracionPorId(idColaboracion);

            if (dto == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "No se encontró la colaboración.");
                return;
            }

            // generar pdf desde la clase GeneradorPDF.java
            File pdfFile = GeneradorPDF.generar(dto);

            if (pdfFile == null || !pdfFile.exists()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el PDF.");
                return;
            }

            // conf Request http
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=\"" + pdfFile.getName() + "\"");
            response.setContentLength((int) pdfFile.length());

            // se manda el pdf al navegador en uso
            try (FileInputStream fis = new FileInputStream(pdfFile);
                 OutputStream os = response.getOutputStream()) {

                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Ocurrió un error al generar la constancia de pago.");
        }
    }
}
