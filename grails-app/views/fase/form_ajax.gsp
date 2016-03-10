<%@ page import="happy.proceso.Fase" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!faseInstance}">
    <elm:notFound elem="Fase" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmFase" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${faseInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: faseInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    <g:textArea name="descripcion" style="width: 400px; height: 150px; resize: none" maxlength="1023" required=""  class="form-control required" value="${faseInstance?.descripcion}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: faseInstance, field: 'objetivo', 'error')} required">
            <span class="grupo">
                <label for="objetivo" class="col-md-2 control-label text-info">
                    Objetivo
                </label>
                <div class="col-md-6">
                    <g:textArea name="objetivo" style="width: 400px; height: 150px; resize: none" maxlength="1023" required="" class="form-control required" value="${faseInstance?.objetivo}"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmFase").validate({
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