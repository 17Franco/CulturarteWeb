/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Config.config;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import kong.unirest.Config;
import kong.unirest.JsonNode;
import kong.unirest.Unirest;


@WebServlet(name = "TrelloApi", urlPatterns = {"/TrelloApi"})
public class TrelloApi extends HttpServlet {

   
   

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("application/json;charset=UTF-8");
         
         String nick = request.getParameter("nick");
         
         if (nick == null || nick.isEmpty()) {
            response.getWriter().write("{\"mensaje\":\"ERROR: falta nick\"}");
            return;
        }
       
    //intancia clase config (este me trae el archivo de configuracion)
    config conf = config.getInstance();
    //me traigo la ip desde el config.propertie
    String host = conf.getProps("WEB_SERVICES_HOSTR");
    //me traigo la port desde el config.propertie
    String port = conf.getProps("WEB_SERVICES_PORTR");
    //servicio que quiero traer (manejamos solo uno igual)
    String serv = conf.getProps("SERVICER");
    //esto es para que si cambia la url del servicio solo modificamos el config y estaria

    //contruir url   
    String dir="http://"+host+":"+port+serv+"/"+nick;
    System.out.println("URL GENERADA: " + dir);
    // convertir el String a URI 
    try {
        
        //EMPIEZA LA SOLICITUD AL REST
        
        //CREO CLIENTE HTTP
        HttpClient client = HttpClient.newHttpClient();
        
        //genero la peticion get al servicio rest
        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(dir))
                .GET()
                .build();
        //envio solicitud y guardo respuesta
        HttpResponse<String> restResponse = client.send(req, HttpResponse.BodyHandlers.ofString());

        // respuesta
        String body = restResponse.body();

        //devuelvo como respuesta el json al front (es para ver si esta llegando la info)
        response.getWriter().write(body);
        
        JsonObject obj = JsonParser.parseString(body).getAsJsonObject();
        //nickname del proponente
        String nickProponente = obj.get("nickname").getAsString();
        
        //propuestas creadas
        JsonArray propCreadasArray = obj.getAsJsonArray("propCreadas");
        
        //crear tablero
        String apiKey = conf.getProps("API_KEY");
        
        String apiToken = conf.getProps("API_TOKEN");  
        
        String nombreDelTablero = "Propuestas de " + nickProponente;
        
        //esto proque segun chatgpt nesesita mas tiepo para mandar la img y no funcionaba antes
        Unirest.config().connectTimeout(10000).socketTimeout(90000);
        
        kong.unirest.HttpResponse<String> responseTrelloTablero = Unirest.post("https://api.trello.com/1/boards/")
            .queryString("name", nombreDelTablero)
            .queryString("key", apiKey)
            .queryString("token", apiToken)
            .queryString("defaultLists", false)
            .asString();

        //System.out.println(responseTrello.getBody());
        
        //guardo la la respuesta como string
        String jsonStringFromTrello = responseTrelloTablero.getBody();
        //parseo a json 
        JsonObject json = JsonParser.parseString(jsonStringFromTrello).getAsJsonObject();
        
        //Me quedo con el id del tablero 
        String boardId = json.get("id").getAsString();

        //genero listas
        for (JsonElement element : propCreadasArray) {
           
            JsonObject propuesta = element.getAsJsonObject();

            String tituloLista = propuesta.get("Titulo").getAsString();
            
            String fecha = propuesta.get("FechaPublicacionString").getAsString();

            kong.unirest.HttpResponse<String> responseList = Unirest.post("https://api.trello.com/1/lists")
            .queryString("name", tituloLista + " " +fecha)
            .queryString("idBoard", boardId)
            .queryString("key", apiKey)
            .queryString("token", apiToken)
            .asString();
            
            String respList = responseList.getBody();
            
            //parseo a json 
            JsonObject jsonList = JsonParser.parseString(respList).getAsJsonObject();

            //Me quedo con el id de la lista
            String ListId = jsonList.get("id").getAsString();
            
            //me lo traigo por el tipo img
            String rutaImagen = (propuesta.has("Imagen") && !propuesta.get("Imagen").isJsonNull())
                    ? propuesta.get("Imagen").getAsString() : "";
            
            
            //la img base 64
            String img = (propuesta.has("img") && !propuesta.get("img").isJsonNull())
                   ? propuesta.get("img").getAsString() : "";
            
            //no quiero tarjeta con img si la propuesta no tiene img
            if (!rutaImagen.isEmpty() && !img.isEmpty()) {
                //aca empieza tarjeta para la img adjunta

                //creo tarjeta
                kong.unirest.HttpResponse<JsonNode> responseTarjeta = Unirest.post("https://api.trello.com/1/cards")
                .header("Accept", "application/json")
                .queryString("idList", ListId)
                .queryString("key", apiKey)
                .queryString("token", apiToken)
                .asJson();

                //id tarjeta
                String idTarjeta = responseTarjeta.getBody().getObject().getString("id");
            
                int lastDotIndex = rutaImagen.lastIndexOf('.');

                String extension = "";

                String tipoImg = "application/octet-stream";

                if (lastDotIndex > 0) {  
                    extension = rutaImagen.substring(lastDotIndex).toLowerCase();

                    if (extension.equals(".jpg") || extension.equals(".jpeg")) {
                        tipoImg = "image/jpeg";
                    } else if (extension.equals(".png")) {
                        tipoImg = "image/png";
                    }     
                }

                //pasarlo a binario
                byte[] imagenBytes = java.util.Base64.getDecoder().decode(img);

                File archivoImagen = java.io.File.createTempFile("trello_adjunto_", extension); 
                archivoImagen.deleteOnExit();

                try (java.io.FileOutputStream fos = new java.io.FileOutputStream(archivoImagen)) {
                    fos.write(imagenBytes);
                } catch (java.io.IOException e) {

                    e.printStackTrace();
                }

                //aca agrego img a tarjeta
                kong.unirest.HttpResponse<JsonNode> responseTarjetaAdjunto = Unirest.post("https://api.trello.com/1/cards/"+idTarjeta+"/attachments")
                .header("Accept", "application/json")
                .field("file", archivoImagen, tipoImg)
                .queryString("key", apiKey)
                .queryString("token", apiToken)
                .asJson();
            }
           //System.out.println(response.getBody());
           
        }
     
       
        //System.out.println(nickProponente);

    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("{\"mensaje\":\"ERROR Creando tablero en Trello: " + e.getMessage() + "\"}");
    }
    }
  

    
        
}

   
   

    


