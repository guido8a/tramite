<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 04/05/16
  Time: 03:40 PM
--%>

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
            <g:textField name="memorando" value="" maxlength="20" class="form-control allCaps" style="width: 180px;margin-left: -20px"/>
        </div>

        <div class="col-md-2">
            <label>Cliente</label>
            <g:textField name="asunto" value="" style="width: 300px" maxlength="30" class="form-control"/>
        </div>

        <div class="col-md-2" style="margin-left: 150px">
            <label>Fecha Completado hasta</label>
            <elm:datepicker name="fechaRecepcion" class="datepicker form-control" value=""/>
        </div>

        <div style="padding-top: 25px">
            <a href="#" name="busqueda" class="btn btn-success btnBusqueda btn-ajax"><i
                    class="fa fa-check-square-o"></i> Buscar</a>

            <a href="#" name="borrar" class="btn btn-primary btnBorrar"><i
                    class="fa fa-eraser"></i> Limpiar</a>

        </div>

    </div>

</div>

<div style="margin-top: 30px; min-height: 460px" class="vertical-container">

    <p class="css-vertical-text">Procesos</p>

    <div class="linea"></div>

    <div id="tablaProcesos">

    </div>

</div>


<script type="text/javascript">

    $("#busqueda").click(function () {
        $("#tablaProcesos").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
    });




</script>


</body>
</html>