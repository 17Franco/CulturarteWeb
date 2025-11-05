/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Servlets;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import logica.DTO.DTORegistrosAccesoWeb;
import logica.Fabrica;
import logica.IController;
/**
 *
 * @author klaas
 */
@WebFilter(filterName = "RegistroDeAccesos", urlPatterns = {"/*"})
public class RegistroDeAccesos implements Filter 
{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1, FilterChain fc) throws IOException, ServletException 
    {
        
        IController controller = Fabrica.getInstance().getController();
        
        HttpServletRequest httpRequest = (HttpServletRequest) sr;
        
        String url = httpRequest.getRequestURL().toString();    //Request y almaceno la url
        

        if (!url.contains("/Img"))
        {
            //Se obtiene ip.
            String ip = sr.getRemoteAddr();

            //Se obtiene navegador Web
            String navegadorWebSO = httpRequest.getHeader("User-Agent");

            if (navegadorWebSO == null) 
            {
                navegadorWebSO = "dato nulo";
            }

            DTORegistrosAccesoWeb reg = new DTORegistrosAccesoWeb(ip, navegadorWebSO, navegadorWebSO, url, null);

            controller.agregarRegistroAccesoWeb(reg);
        }
        fc.doFilter(sr, sr1);
    }
    
    @Override
    public void destroy() 
    {
        Filter.super.destroy();
    }
}
