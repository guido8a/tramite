<%@ page import="happy.proceso.ValorProceso" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!valorProcesoInstance}">
    <elm:notFound elem="ValorProceso" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmValorProceso" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${valorProcesoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: valorProcesoInstance, field: 'valor', 'error')} ">
            <span class="grupo">
                <label for="valor" class="col-md-2 control-label text-info">
                    Valor
                </label>
                <div class="col-md-6">
                    <g:textField name="valor" class="allCaps form-control" value="${valorProcesoInstance?.valor}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: valorProcesoInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-6">
                    <g:textField name="observaciones" class="allCaps form-control" value="${valorProcesoInstance?.observaciones}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: valorProcesoInstance, field: 'detalleProceso', 'error')} required">
            <span class="grupo">
                <label for="detalleProceso" class="col-md-2 control-label text-info">
                    Detalle Proceso
                </label>
                <div class="col-md-6">
                    <g:select id="detalleProceso" name="detalleProceso.id" from="${happy.proceso.DetalleProceso.list()}" optionKey="id" required="" value="${valorProcesoInstance?.detalleProceso?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: valorProcesoInstance, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fecha"  class="datepicker form-control required" value="${valorProcesoInstance?.fecha}"  />
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: valorProcesoInstance, field: 'fechaModificacion', 'error')} required">
            <span class="grupo">
                <label for="fechaModificacion" class="col-md-2 control-label text-info">
                    Fecha Modificacion
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaModificacion"  class="datepicker form-control required" value="${valorProcesoInstance?.fechaModificacion}"  />
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: valorProcesoInstance, field: 'procesoPersona', 'error')} required">
            <span class="grupo">
                <label for="procesoPersona" class="col-md-2 control-label text-info">
                    Proceso Persona
                </label>
                <div class="col-md-6">
                    <g:select id="procesoPersona" name="procesoPersona.id" from="${happy.proceso.ProcesoPersona.list()}" optionKey="id" required="" value="${valorProcesoInstance?.procesoPersona?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmValorProceso").validate({
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