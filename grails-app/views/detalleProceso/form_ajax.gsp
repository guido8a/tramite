<%@ page import="happy.proceso.DetalleProceso" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!detalleProcesoInstance}">
    <elm:notFound elem="DetalleProceso" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmDetalleProceso" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${detalleProcesoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'etiqueta', 'error')} ">
            <span class="grupo">
                <label for="etiqueta" class="col-md-2 control-label text-info">
                    Etiqueta
                </label>
                <div class="col-md-6">
                    <g:textArea name="etiqueta" cols="40" rows="5" maxlength="255" class="allCaps form-control" value="${detalleProcesoInstance?.etiqueta}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'orden', 'error')} required">
            <span class="grupo">
                <label for="orden" class="col-md-2 control-label text-info">
                    Orden
                </label>
                <div class="col-md-2">
                    <g:field name="orden" type="number" value="${detalleProcesoInstance.orden}" class="digits form-control required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'rango', 'error')} ">
            <span class="grupo">
                <label for="rango" class="col-md-2 control-label text-info">
                    Rango
                </label>
                <div class="col-md-6">
                    <g:textField name="rango" maxlength="63" class="allCaps form-control" value="${detalleProcesoInstance?.rango}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'defecto', 'error')} ">
            <span class="grupo">
                <label for="defecto" class="col-md-2 control-label text-info">
                    Defecto
                </label>
                <div class="col-md-6">
                    <g:textField name="defecto" maxlength="63" class="allCaps form-control" value="${detalleProcesoInstance?.defecto}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'observacion', 'error')} ">
            <span class="grupo">
                <label for="observacion" class="col-md-2 control-label text-info">
                    Observacion
                </label>
                <div class="col-md-6">
                    <g:textArea name="observacion" cols="40" rows="5" maxlength="255" class="allCaps form-control" value="${detalleProcesoInstance?.observacion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'ruta', 'error')} ">
            <span class="grupo">
                <label for="ruta" class="col-md-2 control-label text-info">
                    Ruta
                </label>
                <div class="col-md-6">
                    <g:textField name="ruta" class="allCaps form-control" value="${detalleProcesoInstance?.ruta}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'aporte', 'error')} required">
            <span class="grupo">
                <label for="aporte" class="col-md-2 control-label text-info">
                    Aporte
                </label>
                <div class="col-md-2">
                    <g:field name="aporte" type="number" value="${fieldValue(bean: detalleProcesoInstance, field: 'aporte')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'dato', 'error')} required">
            <span class="grupo">
                <label for="dato" class="col-md-2 control-label text-info">
                    Dato
                </label>
                <div class="col-md-6">
                    <g:select id="dato" name="dato.id" from="${happy.proceso.Dato.list()}" optionKey="id" required="" value="${detalleProcesoInstance?.dato?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fecha"  class="datepicker form-control required" value="${detalleProcesoInstance?.fecha}"  />
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'fechaModificacion', 'error')} required">
            <span class="grupo">
                <label for="fechaModificacion" class="col-md-2 control-label text-info">
                    Fecha Modificacion
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaModificacion"  class="datepicker form-control required" value="${detalleProcesoInstance?.fechaModificacion}"  />
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'nulo', 'error')} ">
            <span class="grupo">
                <label for="nulo" class="col-md-2 control-label text-info">
                    Nulo
                </label>
                <div class="col-md-6">
                    <g:textField name="nulo" class="allCaps form-control" value="${detalleProcesoInstance?.nulo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'numericoMaximo', 'error')} required">
            <span class="grupo">
                <label for="numericoMaximo" class="col-md-2 control-label text-info">
                    Numerico Maximo
                </label>
                <div class="col-md-2">
                    <g:field name="numericoMaximo" type="number" value="${fieldValue(bean: detalleProcesoInstance, field: 'numericoMaximo')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'numericoMinimo', 'error')} required">
            <span class="grupo">
                <label for="numericoMinimo" class="col-md-2 control-label text-info">
                    Numerico Minimo
                </label>
                <div class="col-md-2">
                    <g:field name="numericoMinimo" type="number" value="${fieldValue(bean: detalleProcesoInstance, field: 'numericoMinimo')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'posicionReporte', 'error')} required">
            <span class="grupo">
                <label for="posicionReporte" class="col-md-2 control-label text-info">
                    Posicion Reporte
                </label>
                <div class="col-md-2">
                    <g:field name="posicionReporte" type="number" value="${detalleProcesoInstance.posicionReporte}" class="digits form-control required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detalleProcesoInstance, field: 'proceso', 'error')} required">
            <span class="grupo">
                <label for="proceso" class="col-md-2 control-label text-info">
                    Proceso
                </label>
                <div class="col-md-6">
                    <g:select id="proceso" name="proceso.id" from="${happy.proceso.Proceso.list()}" optionKey="id" required="" value="${detalleProcesoInstance?.proceso?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmDetalleProceso").validate({
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
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>