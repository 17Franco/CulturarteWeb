/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Servlets;
import Config.config;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import webservices.ControllerWS;
import webservices.ControllerWS_Service;
import webservices.DtoRegistrosAccesoWeb;
/**
 *
 * @author klaas
 */
@WebFilter(filterName = "RegistroDeAccesos", urlPatterns = {"/*"})
public class RegistroDeAccesos implements Filter 
{

    private ControllerWS obtenerPuerto() 
    {
        try 
        {
            config conf = config.getInstance();
            String host = conf.getProps("WEB_SERVICES_HOST");
            String port = conf.getProps("WEB_SERVICES_PORT");
            String serv = conf.getProps("SERVICE");

            String dir = "http://" + host + ":" + port + serv + "?wsdl";
            URI uri = URI.create(dir);
            URL url = uri.toURL();

            ControllerWS_Service service = new ControllerWS_Service(url);
            return service.getControllerWSPort();
        }
        catch (MalformedURLException e) 
        {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1, FilterChain fc) throws IOException, ServletException 
    {
        
        ControllerWS controllerPort = obtenerPuerto();
        
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

            DtoRegistrosAccesoWeb reg = new DtoRegistrosAccesoWeb();
            
            reg.setIp(ip);
            reg.setFechaReg(null);
            reg.setNavegadorWeb(navegadorWebSO);
            reg.setSo(navegadorWebSO);
            reg.setUrl(url);

            controllerPort.agregarRegistroAccesoWeb(reg);
        }
        fc.doFilter(sr, sr1);
    }
    
    @Override
    public void destroy() 
    {
        Filter.super.destroy();
    }
}
