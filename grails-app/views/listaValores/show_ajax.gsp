
<%@ page import="happy.proceso.ListaValores" %>

<g:if test="${!listaValoresInstance}">
    <elm:notFound elem="ListaValores" genero="o" />
</g:if>
<g:else>

    <g:if test="${listaValoresInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${listaValoresInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${listaValoresInstance?.detalleProceso}">
        <div class="row">
            <div class="col-md-2 text-info">
                Detalle Proceso
            </div>
            
            <div class="col-md-3">
                ${listaValoresInstance?.detalleProceso?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>