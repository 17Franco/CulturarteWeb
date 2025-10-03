

function ocultarMensajeDeExito() {
    var msgS = document.getElementById('msgExito');
    if (msgS) {
      msgS.style.display = 'none'; // Oculta el mensaje
    }
  }
  
  setTimeout(ocultarMensajeDeExito, 4000);
  
  function ocultarMensajeDeError() {
    var msgE = document.getElementById('msgError');
    if (msgE) {
      msgE.style.display = 'none'; // Oculta el mensaje
    }
  }
  
  setTimeout(ocultarMensajeDeError, 4000);