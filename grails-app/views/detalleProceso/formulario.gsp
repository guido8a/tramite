<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Formulario del Proceso</title>

    <style type="text/css">
    /*input{*/
    /*font-size: 14px !important;*/
    /*margin: 0px;*/
    /*}*/
    </style>
</head>

<body>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="proceso" action="list" class="btn btn-primary">
            <i class="fa fa-arrow-left"></i> Volver a lista de Procesos
        </g:link>
    </div>
    <div style="width: 100%; text-align: center; margin-top: -10px"><h3>Formulario del proceso: ${proceso?.nombre}</h3></div>
</div>

<div style="margin-top: 30px;min-height: 80px" class="vertical-container">
<p class="css-vertical-text" style="margin-top: -10px;">Proceso </p>

<div class="linea"></div>


<g:form class="form-horizontal" name="frmProceso" role="form" action="save" method="POST">
    <div class="row">

        <div class="col-md-6">
            <div class="col-md-2 negrilla control-label">Proceso: </div>

            <div class="col-md-9" style="margin-bottom: 20px">
                <g:textField name="proceso_name" id="proceso" value="${proceso?.nombre}" class="form-control required" maxlength="1023" />
            </div>

            <div class="col-md-2 negrilla control-label">Aplica a Documentos: </div>

            <div class="col-md-9" style="margin-bottom: 20px">
                <g:select name="tipo_name" from="${happy.tramites.TipoDocumento.list()}" value="${procesoDocumento?.tipoDocumento?.id}" optionKey="id"  optionValue="descripcion" id="tipo" class="many-to-one form-control"/>
            </div>

            <div class="col-md-2 negrilla control-label">Objetivo del proceso: </div>

            <div class="col-md-9" style="margin-bottom: 20px">
                <g:textArea name="objetivo_name" id="objetivo" value="${proceso?.objetivo}" class="form-control" maxlength="1023" style="resize: none"/>
            </div>

            <div class="col-md-3"></div>

            <div class="btn-group col-md-7">
                <a href="#" id="btnGuardar" class="btn btn-success" title="Guardar cambios al proceso">
                    <i class="fa fa-save"> Guardar</i>
                </a>
                <a href="#" id="btnNuevo" class="btn btn-info" title="Crear un nuevo proceso">
                    <i class="fa fa-plus"> Nuevo Proceso</i>
                </a>
            </div>
        </div>

        <div class="col-md-6" style="margin-top: -30px; margin-left: -20px">
            <div class="col-md-9 negrilla control-label">Datos que se Registran para el Proceso</div>
            <div class="col-md-12" style="height: 200px;">
                <table class="table table-bordered table-hover table-condensed" >
                    <thead>
                    <tr>
                        <th style="width:25%;">Fase</th>
                        <th style="width:35%;">Dato</th>
                        <th style="width:37%;">Etiqueta</th>
                        <th style="width:3%;"></th>
                    </tr>
                    </thead>
                 </table>

                <div class="row-fluid"  style="width: 99.7%;height: 180px;overflow-y: auto;float: right; margin-top: -20px">
                    <div class="span12" style="border: solid; border-width: thin">
                        <table  class="table table-bordered table-hover table-condensed">
                            <tbody id="tablaInfo">

                            </tbody>
                        </table>
                </div>
                </div>
            </div>
        </div>
    </div>

    </div>
</g:form>

<g:if test="${proceso?.id}">
    <div style="margin-top: 20px;" class="contenedor-vertical">
        <p class="css-vertical-text" style="margin-top: 0px;">Datos</p>

        <div class="linea"></div>

        <div class="row" >

            <div class="col-xs-1 negrilla control-label">Fase del Proceso: </div>

            <div class="col-md-3" style="margin-bottom: 20px">
                <g:if test="${proceso?.id}">
                    <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>
                </g:if>
                <g:else>
                    <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control" disabled=""/>
                </g:else>

            </div>

            <div class="col-xs-1 negrilla control-label">Dato a definir: </div>

            %{--<div class="col-md-7 text-info" style="margin-bottom: 20px" id="divDatos">--}%
            <div class="col-md-7 text-info" style="margin-left: -10px" id="divDatos">

            </div>

        </div>
    </div>
</g:if>
<g:else>

</g:else>


<g:if test="${proceso?.id}">
    <div style="margin-top: -20px;min-height: 200px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Detalle de datos</p>

        <div class="linea" style="color: #888; !important;"></div>

        <div class="row" id="divTabla">


        </div>
    </div>
</g:if>
<g:else>

</g:else>


<script type="text/javascript">

    //función para cargar la tabla de informacion de datos por proceso

    cargarTablaInfo();

    function cargarTablaInfo () {
        var idProce = ${proceso?.id}
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'detalleProceso', action: 'tablaInfo_ajax')}',
            data:{
                id: idProce
            },
            success: function (msg){
                $("#tablaInfo").html(msg)
            }
        });
    }



    $("#btnGuardar").click(function () {
        var $form = $("#frmProceso");
        var  nombreProceso = $("#proceso").val();
        var  objetivoProceso = $("#objetivo").val();
        var idProceso = '${proceso?.id}';
        var tipoDoc = $("#tipo").val();

        if($form.valid()){
            if(nombreProceso == '' || objetivoProceso == '' || nombreProceso == null || objetivoProceso == null){
                log("Debe ingresar los dos campos solicitados!","error")
            }else{

                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'detalleProceso', action: 'saveProceso_ajax')}',
                    async: false,
                    data: {
                        proceso: nombreProceso,
                        objetivo: objetivoProceso,
                        id: idProceso
                    },
                    success: function (msg) {
                        var parts =  msg.split("_");
                        if(parts[0] == 'ok'){

                            $.ajax({
                                type: 'POST',
                                url: "${createLink(controller: 'procesoDocumento', action: 'saveProcesoDocumento_ajax')}",
                                data: {
                                    tipo: tipoDoc,
                                    id: parts[1]
                                },
                                success: function (msg) {
                                    if(msg == 'ok'){
                                        log("Proceso guardado correctamente!","success");

                                        setTimeout(function () {
                                            location.href = "${createLink(controller:'detalleProceso',action:'formulario')}/" + parts[1];
                                        }, 1000);
                                    }else{
                                        log("Ocurrió un error al guardar el proceso!","error")
                                    }
                                }
                            });
                        } else {
                            log("Ocurrió un error al guardar el proceso!","error")
                        }

                    }
                })
            }
        }else{
            return false;
        }



    });


    cargarCombo($("#fase").val());

    $("#fase").change(function () {
        var idFase = $(this).val();
        cargarCombo(idFase)
    });

    function cargarCombo (idF){

        var idProceso

        <g:if test="${proceso?.id}">
        idProceso = ${proceso?.id}
                </g:if>


                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'detalleProceso', action: 'cargarDatos_ajax')}',
                    data: {
                        id: idF,
                        idPro: idProceso
                    },
                    success: function (msg){
                        $("#divDatos").html(msg);
                    }
                });
    }

    $("#btnNuevo").click(function () {
        location.href = "${createLink(controller:'detalleProceso',action:'formulario')}"
    });

    var validator = $("#frmProceso").validate({
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