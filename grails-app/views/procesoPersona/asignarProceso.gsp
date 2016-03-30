<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 18/03/16
  Time: 12:42 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Asignar procesos</title>
</head>

<body>

<div style="margin-top: 30px;min-height: 80px" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -10px;">Cliente </p>

    <div class="linea"></div>

    <div class="row">

        <div class="col-xs-1 negrilla control-label">Clientes: </div>

        <div class="col-md-4" style="margin-bottom: 20px">
                <g:select id="cliente" name="cliente_name" from="${happy.seguridad.Persona.list([sort: 'apellido', order: 'asc'])}" optionKey="id" optionValue="${{it?.apellido + " " + it?.nombre}}" class="many-to-one form-control"/>
        </div>


    </div>
</div>

<div style="margin-top: 30px;min-height: 80px" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -10px;">Proceso </p>

    <div class="linea"></div>

    <div class="row">

        <div class="col-xs-1 negrilla control-label">Agregar Proceso: </div>

        <div class="col-md-4" style="margin-bottom: 20px">
            <g:select id="proceso" name="proceso_name" from="${happy.proceso.Proceso.list()}" optionKey="id" optionValue="nombre" class="many-to-one form-control"/>
        </div>

        <div class="col-xs-1 negrilla control-label">Estado del Proceso: </div>

        <div class="col-md-4" style="margin-bottom: 20px">
            <g:select id="estado" name="estado_name" from="${['Activo',"No Activo"]}" class="many-to-one form-control"/>
        </div>

        <div class="col-xs-2" style="margin-top: 5px">
            <a href="#" id="btnAgregar" class="btn btn-success" title="Agregar proceso al cliente">
                <i class="fa fa-plus"> Agregar</i>
            </a>
        </div>


    </div>
</div>

<div style="margin-top: 30px;min-height: 200px" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -10px;">Procesos asignados </p>

    <div class="linea"></div>

    <div class="row" id="tablaAsignados">


    </div>
</div>

<script type="text/javascript">

        cargarTabla($("#cliente").val());

       function cargarTabla (idPersona) {

           $.ajax({
               type: 'POST',
               url: "${createLink(controller: 'procesoPersona', action: 'tablaAsignados_ajax')}",
               data: {
                   id: idPersona
               },
               success: function (msg){
                   $("#tablaAsignados").html(msg)
               }
           });
       }

      $("#cliente").change(function (){
            cargarTabla($(this).val())
        });

        $("#btnAgregar").click(function () {
            var idCliente = $("#cliente").val();
            var idProceso = $("#proceso").val();
            var est = $("#estado").val();

            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'procesoPersona', action: 'saveProcesoPersona_ajax')}",
                data: {
                    idC: idCliente,
                    idP: idProceso,
                    estado: est
                },
                success:  function (msg) {
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        cargarTabla(idCliente);
                    }else{
                        if(parts[1] == 'existente'){
                            bootbox.alert("Este proceso ya ha sido asignado al cliente!")
                        }else{
                            log("Error al agregar el proceso","error")
                        }
                    }

                }
            })
        });

</script>

</body>
</html>