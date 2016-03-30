<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 18/03/16
  Time: 01:08 PM
--%>

<table class="table table-bordered table-condensed table-hover" style="width: 700px; margin-left: 100px">
    <thead>
    <tr>
        <th style="width: 300px">
            Proceso
        </th>
        <th style="width: 100px">
            Estado
        </th>
        <th style="width: 100px">
            Acciones
        </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${procesos}" var="p">
        <tr>
            <td>
                ${p?.proceso?.nombre}
            </td>
            <td>
                <g:if test="${p?.estado == '1'}">
                 Activo
                </g:if>
                <g:else>
                 No Activo
                </g:else>
            </td>
            <td>
                <a href="#" class="btn btn-danger btn-sm btnBorrar" title="Borrar proceso" data-id="${p?.id}">
                    <i class="fa fa-trash"></i>
                </a>
            </td>
        </tr>
    </g:each>

    <script type="text/javascript">

        $(".btnBorrar").click(function () {
            var idProceso = $(this).data("id");

            bootbox.confirm("Esta seguro de remover este proceso asignado?", function (result){
               if(result){
                   $.ajax({
                       type: 'POST',
                       url: "${createLink(controller: 'procesoPersona', action: 'borrarProcesoAsignado_ajax')}",
                       data: {
                           id: idProceso
                       },
                       success: function (msg) {
                        if(msg == 'ok'){
                            log("Proceso removido","success");
                            cargarTabla(${persona?.id});
                        }else{
                            log("Error al remover el proceso");
                        }
                       }
                   });
               }
            });
        });

    </script>


    </tbody>
</table>