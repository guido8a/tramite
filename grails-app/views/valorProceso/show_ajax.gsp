
<%@ page import="happy.proceso.ValorProceso" %>

<g:if test="${!valorProcesoInstance}">
    <elm:notFound elem="ValorProceso" genero="o" />
</g:if>
<g:else>

    <g:if test="${valorProcesoInstance?.valor}">
        <div class="row">
            <div class="col-md-2 text-info">
                Valor
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${valorProcesoInstance}" field="valor"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorProcesoInstance?.observaciones}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observaciones
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${valorProcesoInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorProcesoInstance?.detalleProceso}">
        <div class="row">
            <div class="col-md-2 text-info">
                Detalle Proceso
            </div>
            
            <div class="col-md-3">
                ${valorProcesoInstance?.detalleProceso?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorProcesoInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${valorProcesoInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorProcesoInstance?.fechaModificacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Modificacion
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${valorProcesoInstance?.fechaModificacion}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${valorProcesoInstance?.procesoPersona}">
        <div class="row">
            <div class="col-md-2 text-info">
                Proceso Persona
            </div>
            
            <div class="col-md-3">
                ${valorProcesoInstance?.procesoPersona?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>