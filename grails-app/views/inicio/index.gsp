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
        width: 260px;
        height: 260px;
        float: left;
        margin: 4px;
        font-family: 'open sans condensed';
        border: none;

    }

    .imagen {
        width: 160px;
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
        background-color: rgba(200, 200, 200, 0.9);
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
            <p class="text-info">${inst.institucion}</p>
            <p class="text-info">Sistema de Administración de Procesos y Trámites</p>
        </h2>
    </div>

    <g:if test="${!(session.usuario.getPuedeDirector() || session.usuario.getPuedeJefe())}">

        <div class="body ui-corner-all" style="width: 575px;position: relative;margin: auto;margin-top: 40px;height: 280px; ">
    %{--<div class="body ui-corner-all" style="width: 575px;position: relative;margin: auto;margin-top: 0px;height: 280px; background: #40709a;">--}%

        <g:if test="${session.usuario.esTriangulo()}">
            <a href= "${createLink(controller:'tramite3', action: 'bandejaEntradaDpto')}" style="text-decoration: none">
        </g:if>
        <g:else>
            <a href= "${createLink(controller:'tramite', action: 'bandejaEntrada')}" style="text-decoration: none">
        </g:else>
        <div class="ui-corner-all  item fuera">
            <div class="ui-corner-all ui-widget-content item">
                <div class="imagen">
                    <img src="${resource(dir: 'images', file: 'personales1.png')}" width="100%" height="100%"/>
                </div>

                <div class="texto"><span class="text-success"><strong>Bandeja de entrada</strong></span>: trámites que le han enviado y pendientes de contestación</div>
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
            <div class="ui-corner-all ui-widget-content item">
                <div class="imagen">
                    <img src="${resource(dir: 'images', file: 'salida1.png')}" width="100%" height="100%"/>
                </div>

                <div class="texto"><span class="text-info"><strong>Bandeja de salida</strong></span>: Documentos por enviar y trámites que no le han recibido</div>
            </div>
        </div>
        </a>

    </g:if>

    <div style="text-align: center; margin-top: 40px">

        <g:if test="${session.usuario.getPuedeDirector()}">
            %{--<g:link controller="retrasadosWeb" action="reporteRetrasadosConsolidadoDir" class="openImagenDir" params="[dpto: Persona.get(session.usuario.id).departamento.id, inicio: '1', dir: '1']">--}%
            <g:link controller="departamento" action="arbolReportes" class="openImagenDir" params="[dpto: Persona.get(session.usuario.id).departamento.id, inicio: '1', dir: '1']">
                <img src="${resource(dir: 'images', file: 'ingreso_adm1.jpeg')}" width="240px" height="165px"/>
            </g:link>
        </g:if>

        <g:if test="${session.usuario.getPuedeJefe()}">
            %{--<g:link controller="retrasadosWeb" action="reporteRetrasadosConsolidado" class="openImagen" params="[dpto: Persona.get(session.usuario.id).departamento.id, inicio: '1']">--}%
            <g:link controller="departamento" action="arbolReportes" class="openImagen" params="[dpto: Persona.get(session.usuario.id).departamento.id, inicio: '1']">
                <img src="${resource(dir: 'images', file: 'ingreso_adm1.jpeg')}" width="640px" height="330px"/>
            </g:link>
        </g:if>

        <p>Reportes de trámites generados, retrasados y Gestión de trámites</p>

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
