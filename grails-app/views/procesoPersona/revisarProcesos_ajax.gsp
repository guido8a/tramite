<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/03/16
  Time: 10:39 AM
--%>

<div class="row" >

    <div class="col-xs-2 negrilla control-label">Cliente: </div>

    <div class="col-md-10" style="margin-bottom: 10px">
        <g:select name="revisar_name" class="many-to-one form-control" from="${happy.seguridad.Persona.list([sort: 'apellido', order: 'asc'])}"
                  optionKey="id" optionValue="${{it?.apellido + " " + it?.nombre}}" id="revisar"/>
    </div>
</div>


<div class="row"></div>

<div class="row" >
    <div class="col-xs-2 negrilla control-label">Proceso: </div>
    <div id="listaProcesos" class="col-md-10" style="margin-bottom: 10px"></div>
</div>


<script type="text/javascript">

    cargarProcesos($("#revisar").val());

    $("#revisar").change(function () {
            cargarProcesos($(this).val())
    });

    function cargarProcesos (idCli) {

        $.ajax({
            type: 'POST',
            url:"${createLink(controller: 'procesoPersona', action: 'procesos_ajax')}",
            data: {
                idCliente: idCli,
                tipoCodigo: '${tipo}'
            },
            success: function (msg) {
                $("#listaProcesos").html(msg)
            }

        });


    }


</script>