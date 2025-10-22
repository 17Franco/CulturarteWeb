/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */



    // Seleccionamos todos los botones + para desplegar subcategorías
    const toggleButtons = document.querySelectorAll('.toggle-subcategory');

    toggleButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            event.preventDefault(); // evitar acción del enlaceS
            event.stopPropagation();

            const subcategory = button.parentElement.nextElementSibling;

            if (subcategory.hasAttribute('hidden')) {
                subcategory.removeAttribute('hidden');
                button.textContent = "−"; // cambia a − cuando está abierto
            } else {
                subcategory.setAttribute('hidden', '');
                button.textContent = "+"; // vuelve a +
            }
        });
    });
     document.querySelectorAll('.propuesta').forEach(function(item) {
      item.addEventListener('click', function() {
        const id = item.getAttribute('data-id');
        window.location.href = contextPath + "/Buscador?categoria=" + encodeURIComponent(id);
      });
    });

    document.addEventListener('DOMContentLoaded', function() {
      var hasBootstrap = !!window.bootstrap && !!bootstrap.Tab;
      if (!hasBootstrap) {
        document.querySelectorAll('#estadoTabs .nav-link').forEach(function(btn) {
          btn.addEventListener('click', function(e) {
            e.preventDefault();
            // activar botón
            document.querySelectorAll('#estadoTabs .nav-link').forEach(function(x){ x.classList.remove('active'); });
            btn.classList.add('active');
            // mostrar pane
            document.querySelectorAll('#estadoTabsContent .tab-pane').forEach(function(p){ p.classList.remove('show','active'); });
            var target = document.querySelector(btn.getAttribute('data-bs-target'));
            if (target) { target.classList.add('show','active'); }
          });
        });
      }
    });
