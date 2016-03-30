<%@ page import="happy.proceso.ProcesoPersona" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!procesoPersonaInstance}">
    <elm:notFound elem="ProcesoPersona" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmProcesoPersona" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${procesoPersonaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: procesoPersonaInstance, field: 'estado', 'error')} ">
            <span class="grupo">
                <label for="estado" class="col-md-2 control-label text-info">
                    Estado
                </label>
                <div class="col-md-6">
                    <g:textField name="estado" class="allCaps form-control" value="${procesoPersonaInstance?.estado}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: procesoPersonaInstance, field: 'persona', 'error')} required">
            <span class="grupo">
                <label for="persona" class="col-md-2 control-label text-info">
                    Persona
                </label>
                <div class="col-md-6">
                    <g:select id="persona" name="persona.id" from="${happy.seguridad.Persona.list()}" optionKey="id" required="" value="${procesoPersonaInstance?.persona?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: procesoPersonaInstance, field: 'proceso', 'error')} required">
            <span class="grupo">
                <label for="proceso" class="col-md-2 control-label text-info">
                    Proceso
                </label>
                <div class="col-md-6">
                    <g:select id="proceso" name="proceso.id" from="${happy.proceso.Proceso.list()}" optionKey="id" required="" value="${procesoPersonaInstance?.proceso?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmProcesoPersona").validate({
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