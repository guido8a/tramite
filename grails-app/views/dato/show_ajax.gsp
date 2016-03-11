
<%@ page import="happy.proceso.Dato" %>

<g:if test="${!datoInstance}">
    <elm:notFound elem="Dato" genero="o" />
</g:if>
<g:else>

    <g:if test="${datoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${datoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${datoInstance?.valor}">
        <div class="row">
            <div class="col-md-2 text-info">
                Valor
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${datoInstance}" field="valor"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${datoInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${datoInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${datoInstance?.fase}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fase
            </div>
            
            <div class="col-md-3">
                ${datoInstance?.fase?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>