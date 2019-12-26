<%@ page import="happy.proceso.Dato" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Datos para la Fase del Proceso</title>
</head>

<body>
<div style="width: 100%; text-align: center; margin-top: -10px"><h3>Datos para cada fase del Proceso</h3></div>
<div style="margin-top: 0px;" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -20px;">Fase</p>

    <div class="linea"></div>
    <div class="row">
        <div class="col-md-2 negrilla control-label">Denominación de la Fase: </div>

        <div class="col-md-8" style="margin-bottom: 20px">
            <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>
        </div>
    </div>
</div>

<g:form class="form-horizontal" name="frmCargarDatos" role="form" action="save" method="POST">
    <div style="margin-top: 20px; min-height: 100px" class="vertical-container divDatos">
        <p class="css-vertical-text" style="margin-top: -10px;">Datos</p>

        <div class="linea"></div>

        <div class="row">
            <g:hiddenField name="id_name" value="" id="oculto"/>
            <div class="col-xs-1 negrilla">Nombre del dato:</div>

            <span class="grupo">
                <div class="col-xs-9">
                    <g:textField name="descripcion_name" id="descripcion" class="form-control required" maxlength="255" />
                </div>
            </span>

            <div class="col-xs-2">
                <a href="#" id="btnAgregar" class="btn btn-info" title="Agregar datos">
                    <i class="fa fa-plus"> Agregar</i>
                </a>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-1 negrilla">Descripción del dato:</div>
            <span class="grupo">
                <div class="col-xs-6">
                    <g:textField name="valor_name" id="valor" class="form-control required" maxlength="255"/>
                </div>
            </span>

            <div class="col-xs-1 negrilla">Tipo de dato:</div>

            <div class="col-xs-2">
                %{--<g:select id="tipo" name="tipo.id" from="${happy.proceso.Dato.constraints.tipo.inList}" class="many-to-one form-control"/>--}%
                <g:select id="tipo" name="tipo.id" from="${["Alfanumérico" : "Alfanumérico","Numérico" : "Numérico","Selección Múltiple" : "Selección Múltiple"]}" optionKey="key" optionValue="value" class="many-to-one form-control"/>
            </div>

            <div class="col-xs-2">
                <a href="#" id="btnGuardar" class="btn btn-success hide" title="Guardar datos">
                    <i class="fa fa-save"> Guardar</i>
                </a>
            </div>

        </div>

    </div>
</g:form>

<div style="margin-top: 20px; min-height: 300px" class="vertical-container ">
    <p class="css-vertical-text" style="margin-top: -10px;">Datos Requeridos</p>

    <div class="linea"></div>


    <table class="table table-bordered  table-condensed table-hover">
        <thead>
        <tr>
            <th>Fase</th>
            <th>Nombre del dato</th>
            <th>Descripción del dato requerido</th>
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
        var $form = $("#frmCargarDatos");
        if($form.valid()){
            guardar();
        }else{
            return false;
        }
    });

    $("#btnGuardar").click(function () {
        var $form = $("#frmCargarDatos");
        if($form.valid()) {
            guardar();
        }else{
            return false;
        }
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



    var validator = $("#frmCargarDatos").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });

</script>



</body>
</html>