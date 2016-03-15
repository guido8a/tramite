<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/03/16
  Time: 03:45 PM
--%>

<div class="col-xs-1 negrilla control-label">Etiqueta: </div>

<div class="col-md-6" style="margin-bottom: 20px">
    <g:textField name="etiqueta_name" id="etiqueta" value="${detalleProceso?.etiqueta}" class="form-control" maxlength="255" style="width: 530px"/>
</div>

<div class="col-xs-1 negrilla control-label">Orden: </div>

<div class="col-md-4" style="margin-bottom: 20px">
    <g:textField name="orden_name" id="orden" value="${detalleProceso?.orden}" class="form-control" maxlength="1" style="width: 100px"/>
</div>

<div class="col-xs-1 negrilla control-label">Rango: </div>

<div class="col-xs-1 negrilla control-label">Desde </div>


<div class="col-md-2" style="margin-bottom: 20px">
    <g:textField name="desde_name" id="desde" value="${detalleProceso?.rango}" class="form-control" maxlength="14" style="width:100px"/>
</div>

<div class="col-xs-1 negrilla control-label">Hasta </div>

<div class="col-md-7" style="margin-bottom: 20px">
    <g:textField name="hasta_name" id="hasta" value="${detalleProceso?.rango}" class="form-control" maxlength="14" style="width:100px"/>
</div>



<div class="row"></div>
<div class="col-md-2 negrilla control-label">Aporte: </div>

<div class="col-md-2" style="margin-bottom: 20px">
    <g:textField name="aporte_name" id="aporte" value="${detalleProceso?.aporte}" class="form-control" maxlength="5" style="width: 100px"/>
</div>

<div class="col-md-1 negrilla control-label">Posición reporte: </div>

<div class="col-md-2" style="margin-bottom: 20px">
    <g:textField name="posicion_name" id="posicion" value="${detalleProceso?.posicionReporte}" class="form-control" maxlength="3" style="width: 100px"/>
</div>



<div class="row"></div>
<div class="col-md-1 negrilla control-label">Observaciones: </div>

<div class="col-md-6" style="margin-bottom: 20px">
    <g:textField name="observacion_name" id="observacion" value="${detalleProceso?.observacion}" class="form-control" maxlength="255" style="width: 530px"/>
</div>

<div class="col-md-1 negrilla control-label">Nulo: </div>

<div class="col-md-1" style="margin-bottom: 20px">
    <g:checkBox name="nulo_name" id="nulo"/>
</div>

<div class="col-md-1 negrilla control-label">Ruta: </div>

<div class="col-md-1" style="margin-bottom: 20px">
    <g:checkBox name="ruta_name" id="ruta"/>
</div>



<div class="row"></div>
<div class="col-xs-1 negrilla control-label">Lista: </div>

<div class="col-md-6" style="margin-bottom: 20px">
    <g:select id="fase" name="fase.id" from="${happy.proceso.ListaValores.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>
</div>

<div class="col-md-3">
    <a href="#" id="btnAgregar" class="btn btn-info" title="Agregar items a la lista">
        <i class="fa fa-plus"> Agregar</i>
    </a>
</div>


<div class="col-xs-2" style="float: right; margin-bottom: 20px">
    <a href="#" id="btnGuardar" class="btn btn-success" title="Guardar detalle">
        <i class="fa fa-save"> Guardar detalle</i>
    </a>
</div>

<script type="text/javascript">

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

        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'detalleProceso', action: 'saveDetalle_ajax')}',
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

            }
        });

    });

</script>