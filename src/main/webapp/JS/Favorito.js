/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener("DOMContentLoaded", () => {
    const btn = document.getElementById("btnFavorito");
    if (!btn)
        return;

    btn.addEventListener("click", async function () {
        const titulo = this.dataset.titulo;
        const esFavorita = this.dataset.estado === "true";
        const accion = esFavorita ? "quitar" : "agregar";

        try {
            const response = await fetch("FavoritoServlet", {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: new URLSearchParams({
                    tituloPropuesta: titulo,
                    accion: accion
                })
            });

            if (response.ok) {
                this.dataset.estado = (!esFavorita).toString();
                this.classList.toggle("btn-outline-primary");
                this.classList.toggle("btn-danger");
                this.textContent = esFavorita ? "❤️ Marcar Favorito" : "❤️ Quitar Favorito";
            } else {
                alert("Error al cambiar favorito.");
            }
        } catch (e) {
            console.error(e);
            alert("No se pudo conectar con el servidor.");
        }
    });
});