<%@ page import="happy.proceso.Dato" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!datoInstance}">
    <elm:notFound elem="Dato" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmDato" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${datoInstance?.id}" />


        <div class="form-group ${hasErrors(bean: datoInstance, field: 'fase', 'error')} required">
            <span class="grupo">
                <label for="fase" class="col-md-2 control-label text-info">
                    Fase
                </label>
                <div class="col-md-6">
                    <g:if test="${datoInstance}">
                        <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" disabled="" optionValue="descripcion" required="" value="${datoInstance?.fase?.id}" class="many-to-one form-control"/>
                    </g:if>
                    <g:else>
                        <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" required="" value="${datoInstance?.fase?.id}" class="many-to-one form-control"/>

                    </g:else>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: datoInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-9">
                    <g:textArea name="descripcion" style="width: 420px; height: 140px; resize: none" maxlength="255" required="" class="form-control required" value="${datoInstance?.descripcion}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: datoInstance, field: 'valor', 'error')} required">
            <span class="grupo">
                <label for="valor" class="col-md-2 control-label text-info">
                    Valor
                </label>
                <div class="col-md-9">
                    <g:textArea name="valor" style="width: 420px; height: 140px; resize: none" maxlength="255" required="" class="form-control required" value="${datoInstance?.valor}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: datoInstance, field: 'tipo', 'error')} required">
            <span class="grupo">
                <label for="tipo" class="col-md-2 control-label text-info">
                    Tipo
                </label>
                <div class="col-md-6">
                    <g:textField name="tipo" maxlength="63" required="" class="allCaps form-control required" value="${datoInstance?.tipo}"/>
                </div>
                 *
            </span>
        </div>
        

        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmDato").validate({
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