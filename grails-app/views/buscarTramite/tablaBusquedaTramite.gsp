<%@ page import="happy.tramites.DocumentoTramite; happy.tramites.RolPersonaTramite; happy.tramites.EstadoTramite; happy.tramites.PersonaDocumentoTramite; happy.seguridad.Persona; happy.tramites.Tramite" %>

<style type="text/css">
    table {
        table-layout: fixed;
        overflow-x: scroll;
        font-size: 9pt;
    }

    th, td {
        overflow: hidden;
        text-overflow: ellipsis;
        word-wrap: break-word;
    }
</style>

<util:renderHTML html="${msg}"/>

<div class="row-fluid" style="width: 99.7%;height: ${msg == '' ? 600 : 585}px;overflow-y: auto;float: right; margin-top: -20px">
    <div class="span12">
        <table class="table table-bordered table-condensed table-hover" width="1060px">
            <tbody>
                <g:set var="estadoAnulado" value="${EstadoTramite.findByCodigo('E006')}"/>
                <g:set var="estadoRecibido" value="${EstadoTramite.findByCodigo('E004')}"/>

                <g:set var="rolRecibe" value="${RolPersonaTramite.findByCodigo('E003')}"/>
                <g:set var="rolEnvia" value="${RolPersonaTramite.findByCodigo('E004')}"/>
                <g:set var="rolPara" value="${RolPersonaTramite.findByCodigo('R001')}"/>

                <g:each in="${tramites}" var="tramite" status="z">

                    <g:set var="recibe" value="${PersonaDocumentoTramite.findByTramiteAndRolPersonaTramite(tramite, rolRecibe)}"/>
                    <g:set var="envia" value="${PersonaDocumentoTramite.findByTramiteAndRolPersonaTramite(tramite, rolEnvia)}"/>
                    <g:set var="receptoresAnulados" value="${(tramite.allCopias + tramite.para).findAll {
                        it?.estado == estadoAnulado
                    }}"/>

                    <g:set var="padre" value=""/>
                    <g:set var="clase" value="${'nada'}"/>
                    <g:set var="de" value="${tramite.deDepartamentoId ?: tramite?.de?.departamentoId}"/>

                    <g:if test="${tramite.de?.id == session.usuario.id ||
                            tramite.deDepartamento?.id == session.usuario.departamentoId ||
                            (session.usuario.esTriangulo && de == session.usuario.departamentoId)}">
                        <g:set var="clase" value="${'principal'}"/>
                        <g:if test="${tramite.padre}">
                            <g:set var="padre" value="${tramite.padre?.id}"/>
                            <g:set var="clase" value="${'padre'}"/>
                        </g:if>
                    </g:if>

                    <g:if test="${tramite.anexo == 1}">
                        <g:set var="clase" value="${clase + ' conAnexo'}"/>
                    </g:if>

                    <g:if test="${recibe && recibe.fechaRecepcion}">
                        <g:set var="clase" value="${clase + ' recibido'}"/>
                    </g:if>

                    <g:set var="copiasExternas" value="${tramite.copias.findAll { it.departamento?.externo == 1 }}"/>
                    <g:set var="externo" value=""/>
                    <g:if test="${tramite.externo == '1' || tramite.tipoDocumento.codigo == 'DEX'}">
                        <g:set var="externo" value="externo"/>
                    </g:if>

                    <g:if test="${copiasExternas.estado.codigo.contains('E003')}">
                        <g:set var="externo" value="${externo} externoCC"/>
                    </g:if>
                    <g:if test="${tramite?.deId == session.usuario.id || (tramite?.departamento?.id == session.departamento.id && session.usuario.esTriangulo)}">
                        <g:set var="clase" value="${clase + ' mio'}"/>
                    </g:if>
                    <g:set var="para" value="${tramite?.para?.persona ? tramite?.para?.persona?.departamentoId : tramite?.para?.departamentoId}"/>
                    <g:each in="${tramite.copias}" var="copia">
                        <g:set var="para" value="${para + ',' + (copia.persona ? copia.persona?.departamentoId : copia.departamentoId)}"/>
                    </g:each>

                    <g:set var="respuestas" value="${tramite.respuestas.size()}"/>

                    <g:if test="${tramite.fechaEnvio}">
                        <g:set var="clase" value="${clase + ' enviado'}"/>
                    </g:if>

                    <tr id="${tramite.id}" data-id="${tramite.id}" padre="${padre}" class="${clase} ${externo}" anulados="${receptoresAnulados.size()}"
                        dep="${tramite?.de?.departamentoId}" principal="${tramite.tramitePrincipal}" para="${para}" respuestas="${respuestas}"
                        de="${tramite.tipoDocumento.codigo == 'DEX' ? 'E_' + tramite.id :
                                (tramite.deDepartamento ? 'D_' + tramite.deDepartamento?.id : 'P_' + tramite.de?.id)}">

                        <td class="codigo" style="width: 80px">
                            <g:if test="${tramite?.tipoTramite?.codigo == 'C'}">
                                <i class="fa fa-eye-slash"></i>
                            </g:if>
                            <g:if test="${tramite?.anexo == 1 && DocumentoTramite.countByTramite(tramite) > 0}">
                                <i class="fa fa-paperclip"></i>
                            </g:if>
                            ${tramite?.codigo}
                            <g:if test="${tramite.externo == '1' || tramite.tipoDocumento.codigo == 'DEX'}">
                                (ext)
                            </g:if>
                        </td>

                        <td class="creacion" style="width: 80px">
                            ${tramite.fechaCreacion.format('dd-MM-yyyy HH:mm')}
                        </td>

                        <td class="de" style="width: 150px">
                            <g:if test="${tramite.tipoDocumento.codigo == 'DEX'}">
                                ${tramite.paraExterno} (ext)
                            </g:if>
                            <g:else>
                                <g:if test="${tramite.deDepartamento}">
                                    ${tramite.deDepartamento.descripcion}
                                </g:if>
                                <g:elseif test="${tramite.de}">
                                    ${tramite.de.nombre} ${tramite.de.apellido} (${tramite.de.departamento.codigo})
                                </g:elseif>
                            </g:else>
                        </td>

                        <td class="para" style="width: 150px">
                            <g:if test="${tramite.tipoDocumento.codigo == 'OFI'}">
                                ${tramite.paraExterno} (ext)
                            </g:if>
                            <g:else>
                                <g:if test="${tramite.para}">
                                    <g:if test="${tramite.para.persona}">
                                        ${tramite.para.persona.nombre} ${tramite.para.persona.apellido} (${tramite.para.persona.departamento?.codigo})
                                    </g:if>
                                    <g:elseif test="${tramite.para.departamento}">
                                        ${tramite.para.departamento.descripcion}
                                    </g:elseif>
                                </g:if>
                                <g:if test="${tramite.copias && tramite.copias.size() > 0}">
                                    <span class="small">
                                        <strong>CC:</strong>
                                        <g:each in="${tramite.copias}" var="c" status="i">
                                            <g:if test="${c.persona}">
                                                ${c.persona.nombre} ${c.persona.apellido} (${c.persona.departamento?.codigo})${i < tramite.copias.size() - 1 ? ', ' : ''}
                                            </g:if>
                                            <g:elseif test="${c.departamento}">
                                                ${c.departamento.codigo}${i < tramite.copias.size() - 1 ? ', ' : ''}
                                            </g:elseif>
                                        </g:each>
                                    </span>
                                </g:if>
                            </g:else>
                        </td>


                        <td class="asunto" style="width: 280px">
                            ${tramite.asunto}
                        </td>

                        <td class="prioridad" style="width: 60px">
                            ${tramite.prioridad.descripcion}
                        </td>

                        <td class="envia" style="width: 110px">
                            <g:if test="${envia}">
                                ${envia.persona.nombre} ${envia.persona.apellido}
                            </g:if>
                        </td>
                        <td class="envio" style="width: 75px">
                            <g:if test="${tramite.fechaEnvio}">
                                ${tramite.fechaEnvio.format('dd-MM-yyyy HH:mm')}
                            </g:if>
                        </td>

                        <td class="recepcion" style="width: 75px">
                            <g:if test="${recibe && recibe.fechaRecepcion && tramite.estadoTramite == estadoRecibido}">
                                ${recibe.fechaRecepcion.format('dd-MM-yyyy HH:mm')}
                            </g:if>
                        </td>
                    </tr>
                </g:each>

            </tbody>
        </table>

    %{--</span>--}%

    </div>
</div>


<script type="text/javascript">
    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });
    });
</script>
