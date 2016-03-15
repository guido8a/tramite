<%@ page import="happy.proceso.ListaValores" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!listaValoresInstance}">
    <elm:notFound elem="ListaValores" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmListaValores" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${listaValoresInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: listaValoresInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textArea name="descripcion" cols="40" rows="5" maxlength="255" class="allCaps form-control" value="${listaValoresInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: listaValoresInstance, field: 'detalleProceso', 'error')} required">
            <span class="grupo">
                <label for="detalleProceso" class="col-md-2 control-label text-info">
                    Detalle Proceso
                </label>
                <div class="col-md-6">
                    <g:select id="detalleProceso" name="detalleProceso.id" from="${happy.proceso.DetalleProceso.list()}" optionKey="id" required="" value="${listaValoresInstance?.detalleProceso?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmListaValores").validate({
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