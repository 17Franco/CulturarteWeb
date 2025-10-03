/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import logica.DTO.DTOCategoria;
import logica.Fabrica;
import logica.IController;

@MultipartConfig
@WebServlet(name="Categorias", urlPatterns={"/Categorias"})
public class Categorias extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        IController controller= Fabrica.getInstance().getController();
        // TODO: listaCategiras tiene que devolver un mapa de categorias 
        // con la lista de subcategorias
       List<DTOCategoria> categorias = controller.getCategorias();
        request.setAttribute("categorias", categorias);
      //  request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}