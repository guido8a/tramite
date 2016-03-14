
<%@ page import="happy.proceso.Proceso" %>

<g:if test="${!procesoInstance}">
    <elm:notFound elem="Proceso" genero="o" />
</g:if>
<g:else>

    <g:if test="${procesoInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${procesoInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${procesoInstance?.objetivo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Objetivo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${procesoInstance}" field="objetivo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>