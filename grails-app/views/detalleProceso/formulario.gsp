<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/03/16
  Time: 03:13 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Formulario de detalle de Proceso</title>
</head>

<body>


<div style="margin-top: 30px;min-height: 80px" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -10px;">Proceso </p>

    <div class="linea"></div>


    <div class="row">
        <div class="col-xs-1 negrilla control-label">Nombre del proceso: </div>

        <div class="col-md-4" style="margin-bottom: 20px">
            <g:textField name="proceso_name" id="proceso" value="${proceso?.nombre}" class="form-control" maxlength="1023" style="width: 350px" />
        </div>

        <div class="col-xs-1 negrilla control-label">Objetivo del proceso: </div>

        <div class="col-md-4" style="margin-bottom: 20px">
            <g:textField name="objetivo_name" id="objetivo" value="${proceso?.objetivo}" class="form-control" maxlength="1023" style="width: 350px"/>
        </div>

        <div class="col-xs-2">
            <a href="#" id="btnGuardar" class="btn btn-success" title="Guardar proceso">
                <i class="fa fa-save"> Guardar</i>
            </a>
        </div>

        <div class="col-xs-2" style="margin-top: 5px">
            <a href="#" id="btnNuevo" class="btn btn-info" title="Nuevo proceso">
                <i class="fa fa-plus"> Nuevo</i>
            </a>
        </div>


    </div>
</div>

<g:if test="${proceso?.id}">
    <div style="margin-top: 30px;" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Fase</p>

        <div class="linea"></div>

        <div class="row "  >

            <div class="col-xs-1 negrilla control-label">Fase: </div>

            <div class="col-md-4" style="margin-bottom: 20px">
                <g:if test="${proceso?.id}">
                    <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>
                </g:if>
                <g:else>
                    <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control" disabled=""/>
                </g:else>

            </div>

            <div class="col-xs-1 negrilla control-label">Dato: </div>

            <div class="col-md-4" style="margin-bottom: 20px" id="divDatos">

            </div>

        </div>
    </div>
</g:if>
<g:else>

</g:else>


<g:if test="${proceso?.id}">
    <div style="margin-top: 30px;min-height: 200px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Detalle de datos</p>

        <div class="linea"></div>

        <div class="row" id="divTabla">


        </div>
    </div>
</g:if>
<g:else>

</g:else>


<script type="text/javascript">

    $("#btnGuardar").click(function () {
        var  nombreProceso = $("#proceso").val();
        var  objetivoProceso = $("#objetivo").val();
        var idProceso = '${proceso?.id}';

        if(nombreProceso == '' || objetivoProceso == '' || nombreProceso == null || objetivoProceso == null){
            log("Debe ingresar los dos campos solicitados!","error")
        }else{

            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'detalleProceso', action: 'saveProceso_ajax')}',
                data: {
                    proceso: nombreProceso,
                    objetivo: objetivoProceso,
                    id: idProceso
                },
                success: function (msg) {
                    var parts =  msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Proceso guardado correctamente!","success");

                        setTimeout(function () {
                            location.href = "${createLink(controller:'detalleProceso',action:'formulario')}/" + parts[1];
                        }, 1000);

                    } else {
                        log("Ocurrió un error al guardar el proceso!","error")
                    }

                }
            })
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



</script>


</body>
</html>