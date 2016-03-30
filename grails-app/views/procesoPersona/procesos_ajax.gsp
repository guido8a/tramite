<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/03/16
  Time: 11:00 AM
--%>

<g:if test="${proceso}">
    <g:textField name="procesoSel_name" id="procesoSel" value="${proceso?.proceso?.nombre}" class="form-control" readonly="true" data-id="${proceso?.id}"/>
</g:if>
<g:else>
    <strong style="color: #d83917"> El cliente seleccionado no tiene un proceso asociado a este tipo de trámite</strong>
</g:else>


