
    document.addEventListener("DOMContentLoaded", function() {
        const botones = document.querySelectorAll(".btn-generar-constancia");

        botones.forEach(btn => {
            btn.addEventListener("click", function(e) {
                e.preventDefault();

                const id = this.dataset.id;
                const colaborador = this.dataset.colaborador;
                const propuesta = this.dataset.propuesta;
                const monto = this.dataset.monto;
                const retorno = this.dataset.retorno;
                const creado = this.dataset.creado;

                document.getElementById("fechaEmision").innerText = new Date().toLocaleDateString();
                document.getElementById("colabNombre").innerText = colaborador;
                document.getElementById("colabPropuesta").innerText = propuesta;
                document.getElementById("colabMonto").innerText = monto;
                document.getElementById("colabRetorno").innerText = retorno;
                document.getElementById("colabCreado").innerText = creado;
                document.getElementById("idColaboracionModal").value = id;

                const modal = new bootstrap.Modal(document.getElementById("modalConstancia"));
                modal.show();
            });
        });
    });
 