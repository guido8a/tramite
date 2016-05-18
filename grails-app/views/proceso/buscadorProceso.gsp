<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 04/05/16
  Time: 03:40 PM
--%>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<link href="${resource(dir: '/css/custom', file: 'tablas.css')}" rel="stylesheet">

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <meta name="layout" content="main">
    <title>Buscador de Procesos</title>
</head>

<body>


<div style="margin-top: 0px;" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -10px;">Buscar</p>

    <div class="linea"></div>

    <div style="margin-bottom: 20px">
        <div class="col-md-2">
            <label>Proceso</label>
            <g:textField name="proceso_name" id="proceso" value="" maxlength="20" class="form-control" style="width: 180px;margin-left: -20px"/>
        </div>

        <div class="col-md-2">
            <label>Cliente</label>
            <g:textField name="cliente_name" id="cliente" value="" style="width: 300px" maxlength="30" class="form-control"/>
        </div>

        <div class="col-md-2" style="margin-left: 150px">
            <label>Fecha Completado hasta</label>
            <elm:datepicker name="fecha_name" id="fecha" class="datepicker form-control" value=""/>
        </div>

        <div style="padding-top: 25px">
            <a href="#" name="busqueda" class="btn btn-success btnBusqueda btn-ajax"><i
                    class="fa fa-check-square-o"></i> Buscar</a>

            <a href="#" name="borrar" class="btn btn-primary btnBorrar"><i
                    class="fa fa-eraser"></i> Limpiar</a>

        </div>

    </div>

</div>


<div style="margin-top: 30px; min-height: 350px" class="vertical-container">

    <p class="css-vertical-text">Procesos</p>
    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed">
        <thead>
        <tr>
            <th style="width: 300px">Proceso</th>
            <th style="width: 300px">Cliente</th>
            <th style="width: 150px">Fecha de aprobación</th>
        </tr>
        </thead>
    </table>


    <div id="tablaProcesos">

    </div>

</div>


<script type="text/javascript">

    $(".btnBusqueda").click(function () {
        $("#tablaProcesos").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        cargarTablaProcesos();
    });

    function cargarTablaProcesos () {
        var pro = $("#proceso").val();
        var cli = $("#cliente").val();
        var fec = $("#fecha").val();
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'tablabuscarProceso')}',
            data:{
                proceso: pro,
                cliente: cli,
                fecha: fec
            },
            success: function (msg) {
                $("#tablaProcesos").html(msg)
            }
        });
    }


    $(".btnBorrar").click(function () {
        $("#proceso").val("");
        $("#cliente").val("");
        $("#fecha").val('');
    });




</script>


</body>
</html>