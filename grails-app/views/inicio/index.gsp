<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="happy.seguridad.Persona" %>

<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>Trámites</title>
    <meta name="layout" content="main"/>
    <style type="text/css">
    @page {
        size: 8.5in 11in;  /* width height */
        margin: 0.25in;
    }

    .item {
        width: 320px;
        height: 220px;
        float: left;
        margin: 4px;
        font-family: 'open sans condensed';
        background-color: #eceeff;
        border: 1px;
        border-color: #5c6e80;
        border-style: solid;
    }

    .imagen {
        width: 200px;
        height: 160px;
        margin: auto;
        margin-top: 10px;
    }

    .texto {
        width: 90%;
        height: 50px;
        padding-top: 0px;
        margin: auto;
        margin: 8px;
        font-size: 16px;
        font-style: normal;
    }

    .fuera {
        margin-left: 15px;
        margin-top: 20px;
        /*background-color: #317fbf; */
        background-color: rgba(114, 131, 147, 0.9);
        border: none;
    }

    .titl {
        font-family: 'open sans condensed';
        font-weight: bold;
        text-shadow: -2px 2px 1px rgba(0, 0, 0, 0.25);
        color: #0070B0;
        margin-top: 20px;
    }
    </style>
</head>

<body>
<div class="dialog">
    <g:set var="inst" value="${happy.utilitarios.Parametros.get(1)}"></g:set>

    <div style="text-align: center;"><h2 class="titl">
            <p class="text-warning">${inst.institucion}</p>
            <p class="text-warning">Sistema de Administración de Procesos y Trámites</p>
        </h2>
    </div>

    <div class="body ui-corner-all" style="width: 680px;position: relative;margin: auto;margin-top: 40px;height: 280px; ">

        <g:if test="${!(session.usuario.getPuedeDirector() || session.usuario.getPuedeJefe())}">


        <g:if test="${session.usuario.esTriangulo()}">
            <a href= "${createLink(controller:'tramite3', action: 'bandejaEntradaDpto')}" style="text-decoration: none">
        </g:if>
        <g:else>
            <a href= "${createLink(controller:'tramite', action: 'bandejaEntrada')}" style="text-decoration: none">
        </g:else>
        <div class="ui-corner-all item fuera">
            <div class="ui-corner-all item">
                <div class="imagen">
                    <img src="${resource(dir: 'images', file: 'entrada.png')}" width="100%" height="100%"/>
                </div>

                <div class="texto"><span class="text-info"><strong>Entrada</strong></span> de trámites y procesos</div>
            </div>
        </div>

        </a>


        <g:if test="${session.usuario.esTriangulo()}">
            <a href= "${createLink(controller:'tramite2', action: 'bandejaSalidaDep')}" style="text-decoration: none">
        </g:if>
        <g:else>
            <a href= "${createLink(controller:'tramite2', action: 'bandejaSalida')}" style="text-decoration: none">
        </g:else>
        <div class="ui-corner-all item fuera">
            <div class="ui-corner-all item">
                <div class="imagen">
                    <img src="${resource(dir: 'images', file: 'salida.png')}" width="100%" height="100%"/>
                </div>

                <div class="texto text-success"><strong>Salida</strong> de trámites y procesos</div>
            </div>
        </div>
        </a>

    </g:if>

    <a href= "${createLink(controller:'buscarTramite', action: 'busquedaTramite')}" style="text-decoration: none">
        <div class="ui-corner-all item fuera">
            <div class="ui-corner-all item">
                <div class="imagen">
                    <img src="${resource(dir: 'images', file: 'buscar tramites.png')}" width="100%" height="100%"/>
                </div>

                <div class="texto">
                    <span class="text-success"><strong>Buscar trámites</strong></span></div>
            </div>
        </div>
        </a>

        <a href= "${createLink(controller:'proceso', action: 'buscadorProceso')}" style="text-decoration: none">
        <div class="ui-corner-all item fuera">
            <div class="ui-corner-all item">
                <div class="imagen">
                    <img src="${resource(dir: 'images', file: 'buscar procesos.png')}" width="100%" height="100%"/>
                </div>

                <div class="texto">
                    <span class="text-success"><strong>Buscar procesos</strong></span></div>
            </div>
        </div>
        </a>


    <g:if test="${session.usuario.getPuedeDirector() || session.usuario.getPuedeJefe() || session.usuario.getPuedeJefe()}">
        <div>
        <div class="ui-corner-all item fuera" style="text-align: center">
            <div class="ui-corner-all item">
            %{--<g:link controller="retrasadosWeb" action="reporteRetrasadosConsolidadoDir" class="openImagenDir" params="[dpto: Persona.get(session.usuario.id).departamento.id, inicio: '1', dir: '1']">--}%
            <g:link controller="departamento" action="arbolReportes" class="openImagenDir"
                    params="[dpto: Persona.get(session.usuario.id).departamento.id, inicio: '1', dir: '1']"  style="text-decoration: none">
                <div class="imagen">
                <img src="${resource(dir: 'images', file: 'ingreso_adm.png')}" width="240px" height="165px"/>
                </div>
            <div class="texto">
                    <span class="text-success"><strong>Reportes</strong></span></div>
            </div>
            </g:link>
        </div>
        </div>

        </div>

    </g:if>

    </div>


</div>
    <script type="text/javascript">
        $(".fuera").hover(function () {
            var d = $(this).find(".imagen")
            d.width(d.width() + 10)
            d.height(d.height() + 10)
//        $.each($(this).children(),function(){
//            $(this).width( $(this).width()+10)
//        });
        }, function () {
            var d = $(this).find(".imagen")
            d.width(d.width() - 10)
            d.height(d.height() - 10)
        })


        $(function () {
            $(".openImagenDir").click(function () {
                openLoader();
            });

            $(".openImagen").click(function () {
                openLoader();
            });
        });



    </script>
</body>
</html>
