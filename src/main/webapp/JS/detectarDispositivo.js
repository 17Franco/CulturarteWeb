
  document.addEventListener("DOMContentLoaded", function() {
    const esMovil = /Mobi|Android|Touch/i.test(navigator.userAgent);
    if (esMovil) {
      window.location.href = "InicioSesion_Registro.jsp";
    }
  });
