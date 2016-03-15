
<%@ page import="happy.proceso.DetalleProceso" %>

<g:if test="${!detalleProcesoInstance}">
    <elm:notFound elem="DetalleProceso" genero="o" />
</g:if>
<g:else>

    <g:if test="${detalleProcesoInstance?.etiqueta}">
        <div class="row">
            <div class="col-md-2 text-info">
                Etiqueta
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="etiqueta"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.orden}">
        <div class="row">
            <div class="col-md-2 text-info">
                Orden
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="orden"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.rango}">
        <div class="row">
            <div class="col-md-2 text-info">
                Rango
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="rango"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.defecto}">
        <div class="row">
            <div class="col-md-2 text-info">
                Defecto
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="defecto"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.observacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observacion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="observacion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.ruta}">
        <div class="row">
            <div class="col-md-2 text-info">
                Ruta
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="ruta"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.aporte}">
        <div class="row">
            <div class="col-md-2 text-info">
                Aporte
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="aporte"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.dato}">
        <div class="row">
            <div class="col-md-2 text-info">
                Dato
            </div>
            
            <div class="col-md-3">
                ${detalleProcesoInstance?.dato?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${detalleProcesoInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.fechaModificacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Modificacion
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${detalleProcesoInstance?.fechaModificacion}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.nulo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nulo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="nulo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.numericoMaximo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numerico Maximo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="numericoMaximo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.numericoMinimo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numerico Minimo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="numericoMinimo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.posicionReporte}">
        <div class="row">
            <div class="col-md-2 text-info">
                Posicion Reporte
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${detalleProcesoInstance}" field="posicionReporte"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${detalleProcesoInstance?.proceso}">
        <div class="row">
            <div class="col-md-2 text-info">
                Proceso
            </div>
            
            <div class="col-md-3">
                ${detalleProcesoInstance?.proceso?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>