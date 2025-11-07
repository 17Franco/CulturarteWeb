/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener('DOMContentLoaded', () => {

  function crearSelectorMesAnio(contenedor) {
    contenedor.innerHTML = `
      <div class="d-flex gap-2 mb-2">
        <select id="mes" class="form-select" required>
          <option value="">Mes</option>
          <option value="01">Enero</option>
          <option value="02">Febrero</option>
          <option value="03">Marzo</option>
          <option value="04">Abril</option>
          <option value="05">Mayo</option>
          <option value="06">Junio</option>
          <option value="07">Julio</option>
          <option value="08">Agosto</option>
          <option value="09">Septiembre</option>
          <option value="10">Octubre</option>
          <option value="11">Noviembre</option>
          <option value="12">Diciembre</option>
        </select>
        <select id="anio" class="form-select" required></select>
      </div>
      <input type="hidden" name="dato4" id="fechaVenc" required>
    `;

    const selMes = contenedor.querySelector('#mes');
    const selAnio = contenedor.querySelector('#anio');
    const inputHidden = contenedor.querySelector('#fechaVenc');

    const hoy = new Date();
    const anioActual = hoy.getFullYear();
    const mesActual = hoy.getMonth() + 1;

    // genera opciones de año (actual hasta +15)
    for (let i = 0; i < 15; i++) {
      const y = anioActual + i;
      const opt = document.createElement('option');
      opt.value = y;
      opt.textContent = y;
      selAnio.appendChild(opt);
    }

    function actualizarValor() {
      const anioSel = parseInt(selAnio.value);
      const mesSel = parseInt(selMes.value);

      if (!anioSel || !mesSel) {
        inputHidden.value = '';
        return;
      }

      // valida que no sea fecha pasada
      if (
        anioSel < anioActual ||
        (anioSel === anioActual && mesSel < mesActual)
      ) {
        alert('La fecha de vencimiento no puede ser anterior al mes actual.');
        selMes.value = '';
        inputHidden.value = '';
        return;
      }

      // formato YYYY-MM
      inputHidden.value = anioSel + '-' + String(mesSel).padStart(2, '0');
    }

    selMes.addEventListener('change', actualizarValor);
    selAnio.addEventListener('change', actualizarValor);
  }

  // expone la función globalmente para que puedas llamarla desde el JSP
  window.crearSelectorMesAnio = crearSelectorMesAnio;
});

