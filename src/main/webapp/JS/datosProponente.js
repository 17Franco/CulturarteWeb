const radioP = document.getElementById("prop");
const radioC = document.getElementById("colab");
const datosProponentes = document.getElementById("idCamposProponente");
const direccion = document.getElementById("vDireccion");
const web = document.getElementById("vPaginaWeb");
const biografia = document.getElementById("vBiografia");
radioP.addEventListener("change", event => {
      
      if (radioP.checked) {
        datosProponentes.classList.remove("invisible");
        datosProponentes.classList.remove("d-none");
        direccion.required =true;
        web.required =true;
        biografia.required =true;
      }  
});

radioC.addEventListener("change", event => {
      
      if (radioC.checked) {
        datosProponentes.classList.add("invisible");
        datosProponentes.classList.add("d-none"); 
        direccion.required =false;
        web.required =false;
        biografia.required =false;
      } 
});
