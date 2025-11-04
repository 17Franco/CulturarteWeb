
  document.addEventListener("DOMContentLoaded", function() {
    const esMovil = /Mobi|Android|Touch/i.test(navigator.userAgent);
    console.log(estaLogueado);
    if (esMovil && !estaLogueado ) {
        console.log(estaLogueado);
      window.location.href = "InicioSesion_Registro.jsp";
    }
  });
