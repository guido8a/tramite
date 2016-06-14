<div class="row-fluid" style="width: 99.7%;height: 500px;overflow-y: auto;float: right; margin-top: -20px">
    <div class="span12">
        <div style="width: 1070px; height: 300px;">
            <table class="table table-bordered table-condensed table-hover">
                <tbody>
                <g:each in="${pccl}" var="p">
                    <tr data-pro="${p?.proceso?.id}" data-per="${p?.persona?.id}" data-pccl="${p.id}">
                        <td style="width: 320px">${p?.proceso?.nombre}</td>
                        <td style="width: 320px">${p?.persona?.nombre + " " + p?.persona?.apellido}</td>
                        <g:if test="${p?.fechaCompletado}">
                            <td style="width: 150px">${p?.fechaCompletado?.format("dd-MM-yyyy HH:mm:ss")}</td>
                        </g:if>
                        <g:else>
                            <td>No se encuentra aprobado</td>
                        </g:else>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(function () {


        $("tbody tr").contextMenu({
            items: {
                header: {
                    label: "Acciones",
                    header: true
                },
                editar: {
                    label: "Asignar Valores",
                    icon: "fa fa-pencil",
                    action: function ($element) {
                        var idT = $element.data("pccl");
                        location.href = "${createLink(controller: 'valorProceso', action: 'editarValores')}/" + idT;
                    }
                },
                detalle: {
                    label: "Definir el formulario",
                    icon: "fa fa-table",
                    action: function ($element) {
                        var id = $element.data("pro");
                        location.href = "${createLink(controller: 'detalleProceso', action: 'formulario')}/" + id
                    }
                }
            },
            onShow: function ($element) {
                $element.addClass("trHighlight");
            },
            onHide: function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });

    });


</script>