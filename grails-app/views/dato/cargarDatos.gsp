<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 10/03/16
  Time: 03:55 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Cargar Datos de Fases</title>
</head>

<body>
<div style="margin-top: 30px;" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -10px;">Fase</p>

    <div class="linea"></div>

    <div class="row">

        <div class="col-xs-1 negrilla control-label">Fase: </div>

        <div class="col-md-4" style="margin-bottom: 20px">
            <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>
        </div>

    </div>
</div>


<div style="margin-top: 30px; min-height: 100px" class="vertical-container divDatos">
    <p class="css-vertical-text" style="margin-top: -10px;">Datos</p>

    <div class="linea"></div>

    <div class="row">
        <g:hiddenField name="id_name" value="" id="oculto"/>
        <div class="col-xs-1 negrilla">Descripción:</div>

        <div class="col-xs-9">
            <g:textField name="descripcion_name" id="descripcion" class="form-control" maxlength="255" style="width: 800px"/>
        </div>

        <div class="col-xs-2">
            <a href="#" id="btnAgregar" class="btn btn-info" title="Agregar datos">
                <i class="fa fa-plus"> Agregar</i>
            </a>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-1 negrilla">Valor:</div>

        <div class="col-xs-4">
            <g:textField name="valor_name" id="valor" class="form-control" maxlength="255" style="width: 350px"/>
        </div>

        <div class="col-xs-1 negrilla">Tipo:</div>

        <div class="col-xs-4">
            <g:textField name="tipo_name" id="tipo" class="form-control" maxlength="63" style="width: 335px"/>
        </div>

        <div class="col-xs-2">
            <a href="#" id="btnGuardar" class="btn btn-success hide" title="Guardar datos">
                <i class="fa fa-save"> Guardar</i>
            </a>
        </div>

    </div>

</div>

<div style="margin-top: 30px; min-height: 300px" class="vertical-container ">
    <p class="css-vertical-text" style="margin-top: -10px;">Datos Asignados</p>

    <div class="linea"></div>


    <table class="table table-bordered  table-condensed table-hover">
    <thead>
    <tr>
            <th>Fase</th>
        <th>Descripción</th>
        <th>Valor</th>
        <th>Tipo</th>
        <th style="width: 100px">Acciones</th>
    </tr>
    </thead>
    <tbody id="divTabla">

    </tbody>
    </table>
</div>



<script type="text/javascript">

    cargar($("#fase").val());

    $("#fase").change(function () {
//        $(".divDatos").removeClass('hide');
        var id = $("#fase").val();
        $("#descripcion").val('');
        $("#valor").val('');
        $("#tipo").val('');
        cargar(id);
    });

    function cargar (faseId) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'dato', action: 'tablaDatos_ajax')}",
            data: {
                idFase: faseId
            },
            success: function (msg) {
                $("#divTabla").html(msg)
            }
        });
    }

    $("#btnAgregar").click(function () {
        guardar();
    });

    $("#btnGuardar").click(function () {
        guardar();
        $("#btnAgregar").removeClass('hide');
        $("#btnGuardar").addClass('hide')
    });

    function guardar () {
        var desc = $("#descripcion").val();
        var vlor = $("#valor").val();
        var tpo = $("#tipo").val();
        var idFase = $("#fase").val();
        var idO = $("#oculto").val();

        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'dato', action: 'saveDato_ajax')}",
            data: {
                descripcion: desc,
                valor:vlor,
                tipo: tpo,
                id: idFase,
                idDato: idO

            },
            success: function (msg){
                if(msg == "ok"){
                    log("Datos guardados correctamente","success");
                    cargar(idFase);
                    $("#descripcion").val('');
                    $("#valor").val('');
                    $("#tipo").val('');
                    $("#oculto").val('');
                }else{
                    log("Error al grabar los datos!", "error")
                }

            }
        });

    }



</script>



</body>
</html>