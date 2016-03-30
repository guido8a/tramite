
<%@ page import="happy.proceso.ProcesoPersona" %>

<g:if test="${!procesoPersonaInstance}">
    <elm:notFound elem="ProcesoPersona" genero="o" />
</g:if>
<g:else>

    <g:if test="${procesoPersonaInstance?.estado}">
        <div class="row">
            <div class="col-md-2 text-info">
                Estado
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${procesoPersonaInstance}" field="estado"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${procesoPersonaInstance?.persona}">
        <div class="row">
            <div class="col-md-2 text-info">
                Persona
            </div>
            
            <div class="col-md-3">
                ${procesoPersonaInstance?.persona?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${procesoPersonaInstance?.proceso}">
        <div class="row">
            <div class="col-md-2 text-info">
                Proceso
            </div>
            
            <div class="col-md-3">
                ${procesoPersonaInstance?.proceso?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>