<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 16/03/16
  Time: 12:43 PM
--%>

<div class="row">
    <div class="col-md-6 negrilla control-label" style="margin-left: 50px">Descripción del Item</div>
</div>

<div class="row">

    <div class="col-md-7" style="margin-bottom: 20px; margin-left: 50px; margin-right: 30px">
        <g:textField name="descripcion_name" id="descripcionItem" class="form-control" maxlength="255" style="width: 350px"/>
    </div>

    <div class="col-md-3" style="margin-left: 10px">
        <a href="#" id="btnAgregarItem" class="btn btn-info" title="Agregar items a la lista">
            <i class="fa fa-plus"></i>
        </a>
    </div>

</div>

<div class="row" style="margin-left: 50px">

    <div id="tablaLista" >


    </div>

</div>


<script type="text/javascript">


    cargarTabla();

    $("#btnAgregarItem").click(function () {

        var desc = $("#descripcionItem").val();

        if(desc == '' || desc == null){
            log("Debe ingresar una descripción!","error");
        }else{
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'detalleProceso', action: 'saveItems_ajax')}",
                data: {
                    descripcion: desc,
                    idDetalle: ${detalle?.id}
                },
                success: function (msg) {
                    if(msg == 'ok'){
                        log("Item agregado a la lista correctamente","success");
                        cargarTabla();
                    }else{
                        log("Error al agregar el item a la lista","error");
                    }

                }
            });
        }
    });


    function cargarTabla () {

        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'detalleProceso', action: 'tablaLista_ajax')}',
            data: {
                id: ${detalle?.id}
            },
            success: function (msg) {
                $("#tablaLista").html(msg)
            }
        });
    }


</script>
