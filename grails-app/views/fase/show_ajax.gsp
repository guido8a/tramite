
<%@ page import="happy.proceso.Fase" %>

<g:if test="${!faseInstance}">
    <elm:notFound elem="Fase" genero="o" />
</g:if>
<g:else>

    <g:if test="${faseInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${faseInstance}" field="descripcion"/>

            </div>
            
        </div>
    </g:if>
    
    <g:if test="${faseInstance?.objetivo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Objetivo
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${faseInstance}" field="objetivo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>