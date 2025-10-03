/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */


<script>
    // Seleccionamos todos los botones + para desplegar subcategorías
    const toggleButtons = document.querySelectorAll('.toggle-subcategory');

    toggleButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            event.preventDefault(); // evitar acción del enlace
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
</script>