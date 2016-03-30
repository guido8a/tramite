<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/03/16
  Time: 03:45 PM
--%>

<g:form class="form-horizontal" name="frmTabla" role="form" action="" method="POST">


    <div class="col-xs-1 negrilla control-label">Etiqueta: </div>

    <div class="col-md-6" style="margin-bottom: 20px">
        <g:textField name="etiqueta_name" id="etiqueta" value="${detalleProceso?.etiqueta}" class="form-control required" maxlength="255" style="width: 530px"/>
    </div>

    <div class="col-xs-1 negrilla control-label">Orden: </div>

    <div class="col-md-2" style="margin-bottom: 20px">
        <g:textField name="orden_name" id="orden" value="${detalleProceso?.orden}" class="form-control required number" maxlength="1" style="width: 100px"/>
    </div>

    <div class="row"></div>

    <div class="col-xs-1 negrilla control-label">Rango: </div>

    <div class="col-xs-1 negrilla control-label">Desde </div>


    <g:if test="${detalleProceso}">

        <g:if test="${dato?.tipo == 'String'}">

            <div class="col-md-2" style="margin-bottom: 20px">
                <g:textField name="desde_name" id="desde" value="${(detalleProceso?.rango?.split(",")[0]) ?:  ''}" class="form-control required number" maxlength="14" style="width:100px"/>
            </div>

            <div class="col-xs-1 negrilla control-label">Hasta </div>

            <div class="col-md-2" style="margin-bottom: 20px">
                <g:textField name="hasta_name" id="hasta" value="${(detalleProceso?.rango?.split(",")[1])  ?: ''}" class="form-control required number" maxlength="14" style="width:100px"/>
            </div>
        </g:if>
        <g:else>
            <div class="col-md-2" style="margin-bottom: 20px">
                <g:textField name="desde_name" id="desde" value="${detalleProceso?.numericoMinimo ?: ''}" class="form-control required number" maxlength="14" style="width:100px"/>
            </div>

            <div class="col-xs-1 negrilla control-label">Hasta </div>

            <div class="col-md-2" style="margin-bottom: 20px">
                <g:textField name="hasta_name" id="hasta" value="${detalleProceso?.numericoMaximo ?: ''}" class="form-control required number" maxlength="14" style="width:100px"/>
            </div>
        </g:else>

    </g:if>
    <g:else>
        <div class="col-md-2" style="margin-bottom: 20px">
            <g:textField name="desde_name" id="desde" value="${''}" class="form-control required number" maxlength="14" style="width:100px"/>
        </div>

        <div class="col-xs-1 negrilla control-label">Hasta </div>

        <div class="col-md-2" style="margin-bottom: 20px">
            <g:textField name="hasta_name" id="hasta" value="${''}" class="form-control required number" maxlength="14" style="width:100px"/>
        </div>
    </g:else>



    <div class="row"></div>
    <div class="col-md-2 negrilla control-label">Aporte: </div>

    <div class="col-md-2" style="margin-bottom: 20px">
        <g:textField name="aporte_name" id="aporte" value="${detalleProceso?.aporte}" class="form-control required number" maxlength="5" style="width: 100px"/>
    </div>

    <div class="col-md-1 negrilla control-label">Posición reporte: </div>

    <div class="col-md-2" style="margin-bottom: 20px">
        <g:textField name="posicion_name" id="posicion" value="${detalleProceso?.posicionReporte}" class="form-control required number" maxlength="3" style="width: 100px"/>
    </div>



    <div class="row"></div>
    <div class="col-md-1 negrilla control-label">Observaciones: </div>

    <div class="col-md-6" style="margin-bottom: 20px">
        <g:textField name="observacion_name" id="observacion" value="${detalleProceso?.observacion}" class="form-control" maxlength="255" style="width: 530px"/>
    </div>

    <div class="col-md-1 negrilla control-label">Nulo: </div>

    <g:if test="${detalleProceso?.nulo == '1'}">
        <div class="col-md-1" style="margin-bottom: 20px">
            <g:checkBox name="nulo_name" id="nulo" checked="true"/>
        </div>
    </g:if>
    <g:else>
        <div class="col-md-1" style="margin-bottom: 20px">
            <g:checkBox name="nulo_name" id="nulo"/>
        </div>
    </g:else>


    <div class="col-md-1 negrilla control-label">Ruta: </div>

    <g:if test="${detalleProceso?.ruta == '1'}">
        <div class="col-md-1" style="margin-bottom: 20px">
            <g:checkBox name="ruta_name" id="ruta" checked="true"/>
        </div>
    </g:if>
    <g:else>
        <div class="col-md-1" style="margin-bottom: 20px">
            <g:checkBox name="ruta_name" id="ruta"/>
        </div>
    </g:else>


    <div class="row"></div>
    <div class="col-xs-1 negrilla control-label">Lista: </div>

    <div class="col-md-6" style="margin-bottom: 20px">
        <g:select id="lista" name="lista.id" from="${happy.proceso.ListaValores.findAllByDetalleProceso(detalleProceso, [sort: 'defecto', order: 'desc'])}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>
    </div>

    <div class="col-md-3">
        <a href="#" id="btnAgregar" class="btn btn-info" title="Agregar items a la lista">
            <i class="fa fa-plus"> Agregar</i>
        </a>
    </div>


    <div class="col-xs-2" style="float: right; margin-bottom: 20px">
        <a href="#" id="btnGuardarDetalle" class="btn btn-success" title="Guardar detalle">
            <i class="fa fa-save"> Guardar detalle</i>
        </a>
    </div>

</g:form>




<script type="text/javascript">


    $("#btnGuardarDetalle").click(function () {
        var idDato = ${dato?.id};
        var idProc = ${proceso?.id};
        var idDeta

        <g:if test="${detalleProceso?.id}">
        idDeta = ${detalleProceso?.id};
        </g:if>

        var eti = $("#etiqueta").val();
        var ord = $("#orden").val();
        var des = $("#desde").val();
        var has = $("#hasta").val();
        var apo = $("#aporte").val();
        var pos = $("#posicion").val();
        var obs = $("#observacion").val();
        var nul = $("#nulo").prop('checked');
        var rut = $("#ruta").prop('checked');
        var $frm = $("#frmTabla");


       if ($frm.valid()) {

           $.ajax({
               type: 'POST',
               url: '${createLink(controller: 'detalleProceso', action: 'saveDetalle_ajax')}',
               async: false,
               data: {
                   idD: idDato,
                   idP: idProc,
                   idDP: idDeta,
                   etiqueta: eti,
                   orden: ord,
                   desde : des,
                   hasta: has,
                   aporte: apo,
                   posicion: pos,
                   observacion: obs,
                   nulo: nul,
                   ruta: rut

               },
               success: function (msg) {
                   var dt = msg.split("_");
                   if(dt[0] == 'ok'){
                       log("Detalle guardado correctamente","success")
                   }else{
                       log("Error al guardar el detalle","error")
                   }
               }
           });

       }

    });


    $("#btnAgregar").click(function () {

        var idDato = ${dato?.id};
        var idProc = ${proceso?.id};
        var idDeta
        <g:if test="${detalleProceso?.id}">
                idDeta = ${detalleProceso?.id};
        </g:if>

        var eti = $("#etiqueta").val();
        var ord = $("#orden").val();
        var des = $("#desde").val();
        var has = $("#hasta").val();
        var apo = $("#aporte").val();
        var pos = $("#posicion").val();
        var obs = $("#observacion").val();
        var nul = $("#nulo").prop('checked');
        var rut = $("#ruta").prop('checked');
        var $frm = $("#frmTabla");

        if ($frm.valid()) {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'detalleProceso', action: 'saveDetalle_ajax')}',
                async: false,
                data: {
                    idD: idDato,
                    idP: idProc,
                    idDP: idDeta,
                    etiqueta: eti,
                    orden: ord,
                    desde : des,
                    hasta: has,
                    aporte: apo,
                    posicion: pos,
                    observacion: obs,
                    nulo: nul,
                    ruta: rut

                },
                success: function (msg) {
                    var dt = msg.split("_");
                    if(dt[0] == 'ok'){
                        $.ajax({
                            type: "POST",
                            url: "${createLink(controller: 'detalleProceso', action:  'lista_ajax')}",
                            data : {
                                idDetalle: dt[1]
                            },
                            success: function (msg1){
                                bootbox.dialog({
                                    id: "dlgLista",
                                    title: "Lista",
                                    message: msg1,
                                    buttons: {
                                        cancelar :{
                                            label     : '<i class="fa fa-times"></i> Cancelar',
                                            className : 'btn-danger',
                                            callback  : function () {
                                                openLoader();
                                                location.href = "${createLink(controller:'detalleProceso',action:'formulario')}/" + idProc
                                                closeLoader();
                                            }
                                        }
                                    }
                                })
                            }
                        });
                    }
                }
            });
        }



    });


    var validator = $("#frmTabla").validate({
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