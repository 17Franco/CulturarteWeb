<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Propuestas por Estado</title>

  <script defer>
    // Cambio de pestañas
    document.addEventListener("DOMContentLoaded", () => {
      const tabs = document.querySelectorAll("[data-tab]");
      const contents = document.querySelectorAll(".tab-content");

      tabs.forEach(tab => {
        tab.addEventListener("click", () => {
          // Quitar y agregar clases activas
          tabs.forEach(t => t.classList.remove("active"));
          contents.forEach(c => c.classList.add("hidden"));
          tab.classList.add("active");
          document.getElementById(tab.dataset.tab).classList.remove("hidden");
        });
      });
    });
  </script>

  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
      padding: 20px;
    }

    h2 {
      margin-bottom: 20px;
    }

    /* Contenedor de pestañas */
    .tabs {
      display: flex;
      flex-wrap: wrap;
      border-bottom: 2px solid #ccc;
      margin-bottom: 20px;
    }

    .tab {
      padding: 10px 18px;
      cursor: pointer;
      background-color: #eaeaea;
      border: 1px solid #ccc;
      border-bottom: none;
      margin-right: 5px;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
      transition: background-color 0.3s ease;
    }

    .tab:hover {
      background-color: #ddd;
    }

    .tab.active {
      background-color: #fff;
      border-bottom: 2px solid white;
      font-weight: bold;
    }

    /* Contenedor principal de contenido */
    .tab-content {
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 0 0 10px 10px;
      padding: 20px;
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    .hidden {
      display: none;
    }

    /* Tarjeta de propuesta */
    .propuesta {
      border: 1px solid #ddd;
      border-radius: 10px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      width: 280px;
      overflow: hidden;
      background: #fafafa;
      display: flex;
      flex-direction: column;
    }

    .propuesta img {
      width: 100%;
      height: 150px;
      object-fit: cover;
    }

    .propuesta .info {
      padding: 10px;
    }

    .propuesta h3 {
      font-size: 1rem;
      margin-bottom: 5px;
    }

    .propuesta p {
      font-size: 0.9rem;
      color: #555;
    }

    .barra-progreso {
      height: 10px;
      background-color: #ddd;
      border-radius: 5px;
      overflow: hidden;
      margin-top: 5px;
      margin-bottom: 8px;
    }

    .progreso {
      height: 10px;
      background-color: #4caf50;
    }

    .detalles {
      font-size: 0.85rem;
      color: #444;
      display: flex;
      justify-content: space-between;
    }
  </style>
</head>
<body>
  <h2>Propuestas por Estado</h2>

  <!-- Barra de pestañas -->
  <div class="tabs">
    <div class="tab active" data-tab="INGRESADA">Ingresadas</div>
    <div class="tab" data-tab="PUBLICADA">Publicadas</div>
    <div class="tab" data-tab="EN_FINANCIACION">En Financiación</div>
    <div class="tab" data-tab="FINANCIADA">Financiadas</div>
    <div class="tab" data-tab="NO_FINANCIADA">No Financiadas</div>
    <div class="tab" data-tab="CANCELADA">Canceladas</div>
  </div>

  <!-- Contenido de cada pestaña -->
  <div id="INGRESADA" class="tab-content">
    <div class="propuesta">
      <img src="https://via.placeholder.com/300x150" alt="Propuesta ingresada">
      <div class="info">
        <h3>Propuesta Ingresada Ejemplo</h3>
        <p>Descripción breve de la propuesta ingresada.</p>
      </div>
    </div>
  </div>

  <div id="PUBLICADA" class="tab-content hidden">
    <div class="propuesta">
      <img src="https://via.placeholder.com/300x150" alt="Propuesta publicada">
      <div class="info">
        <h3>Propuesta Publicada Ejemplo</h3>
        <p>Información sobre la propuesta publicada.</p>
      </div>
    </div>
  </div>

  <div id="EN_FINANCIACION" class="tab-content hidden">
    <div class="propuesta">
      <img src="https://via.placeholder.com/300x150" alt="Propuesta en financiación">
      <div class="info">
        <h3>Propuesta en Financiación</h3>
        <p>Recaudado: $200.000 UYU</p>
        <div class="barra-progreso"><div class="progreso" style="width:35%"></div></div>
        <div class="detalles"><span>10 días</span><span>100 colaboradores</span></div>
      </div>
    </div>
  </div>

  <div id="FINANCIADA" class="tab-content hidden">
    <div class="propuesta">
      <img src="https://via.placeholder.com/300x150" alt="Propuesta financiada">
      <div class="info">
        <h3>Propuesta Financiada</h3>
        <p>Proyecto exitosamente financiado.</p>
        <div class="barra-progreso"><div class="progreso" style="width:100%"></div></div>
        <div class="detalles"><span>Completado</span><span>250 colaboradores</span></div>
      </div>
    </div>
  </div>

  <div id="NO_FINANCIADA" class="tab-content hidden">
    <p>No hay propuestas no financiadas actualmente.</p>
  </div>

  <div id="CANCELADA" class="tab-content hidden">
    <div class="propuesta">
      <img src="https://via.placeholder.com/300x150" alt="Propuesta cancelada">
      <div class="info">
        <h3>Propuesta Cancelada</h3>
        <p>Proyecto cancelado antes de finalizar el período.</p>
      </div>
    </div>
  </div>

</body>
</html>
