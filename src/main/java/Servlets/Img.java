/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import logica.DTO.DTOColaborador;
import logica.Fabrica;
import logica.IController;

/**
 *
 * @author fran
 */
@WebServlet(name = "Img", urlPatterns = {"/Img"})
public class Img extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        IController controller= Fabrica.getInstance().getController();
         String ruta = request.getParameter("ruta");
         String extension = ruta.substring(ruta.lastIndexOf(".") + 1).toLowerCase();//nesesito saber si es png o jpg
         String ext; //aca se guardara contentType segun sea la extencion
        try{
           if(!("").equals(ruta)){
               //DTOColaborador c=controller.getDTOColaborador(usrTipo);
               
                byte[] img=controller.getImg(ruta); //me  traigo el array de bytes de la img
                switch (extension) {
                    case "png":
                        ext = "image/png";
                        break;
                    case "jpg":
                        ext = "image/jpg";
                        break;
                    case "jpeg": 
                        ext = "image/jpg";
                        break;
                    default:
                        ext = "image/jpeg";
                        break;
                }

                response.setContentType(ext);//el tipo de contenido img o html o otra cosa
                response.setContentLength(img.length); //tamano del contenido
                response.getOutputStream().write(img);//write le transfiere cada byte de la img a el metodo getOutputStream() y este al navegador este ultimo interpretea y muestra           
           }
           
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           processRequest(request, response);
    }
}
