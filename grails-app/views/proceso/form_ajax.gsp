<%@ page import="happy.proceso.Proceso" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!procesoInstance}">
    <elm:notFound elem="Proceso" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmProceso" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${procesoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: procesoInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-9">
                    <g:textArea name="nombre" style="width: 400px; height: 130px; resize: none" maxlength="1023" required="" class="form-control required" value="${procesoInstance?.nombre}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: procesoInstance, field: 'objetivo', 'error')} required">
            <span class="grupo">
                <label for="objetivo" class="col-md-2 control-label text-info">
                    Objetivo
                </label>
                <div class="col-md-9">
                    <g:textArea name="objetivo" style="width: 400px; height: 130px; resize: none" maxlength="1023" required="" class="form-control required" value="${procesoInstance?.objetivo}"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmProceso").validate({
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