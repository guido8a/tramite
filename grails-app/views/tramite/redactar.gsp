<!DOCTYPE HTML>
<html>
    <head>
        <meta name="layout" content="main2">
        <title>Redactar trámite</title>

        <script src="${resource(dir: 'js/plugins/ckeditor', file: 'ckeditor.js')}"></script>
        <script src="${resource(dir: 'js/plugins/ckeditor/adapters', file: 'jquery.js')}"></script>
        <style type="text/css">

        .hoja {
            margin : auto;
            float  : right;
            width  : 19cm;
        }

        .nota {
            position           : absolute;
            left               : 15px;
            top                : 240px;
            padding            : 10px;
            background         : #EFEFD1;
            border             : solid 1px #867722;
            width              : 235px;
            z-index            : 1;

            -webkit-box-shadow : 7px 7px 5px 0px rgba(50, 50, 50, 0.75);
            -moz-box-shadow    : 7px 7px 5px 0px rgba(50, 50, 50, 0.75);
            box-shadow         : 7px 7px 5px 0px rgba(50, 50, 50, 0.75);
        }

        .nota .contenido {
            overflow   : auto;
        }

        .nota:after {
            position : absolute;
            top      : -10px;
            left     : 40%;
            content  : url("${resource(dir:'images',file:'pin.png')}");
            z-index  : 2;
            display  : block;
            width    : 16px;
            height   : 16px;
        }

        .padre {
            background   : #BCCCDC;
            border-color : #2C5E8F;
            width        : 290px;
        }

        .padre h4 {
            font-size     : 15px;
            margin-top    : 0;
            margin-bottom : 5px;
            height        : 40px;
            overflow      : auto;
        }

        .btn-editar {
            position : absolute;
            right    : 10px;
            top      : 32px;
        }

        .membrete {
            cursor                : pointer;
            margin-top            : 2px;
            margin-left           : 15px !important;
            font-size             : 15px;
            padding               : 3px 8px;

            -webkit-border-radius : 5px;
            -moz-border-radius    : 5px;
            border-radius         : 5px;
        }

        .res {
            height: 280px;
            margin-top: -50px;
        }


        </style>
    </head>

    <body>

        <g:if test="${tramite.nota && tramite.nota.trim() != ''}">
            <div class="nota ui-corner-all">
                <div class="contenido">
                    ${tramite.nota}
                </div>
            </div>
        </g:if>
        <g:if test="${tramite.padre}">
            <g:if test="${tramite.padre.personaPuedeLeer(session.usuario)}">
                <div class="nota padre ui-corner-all" id="divInfo" style="height: 400px;">
                    <h4 class="text-info">${tramite.padre.codigo} - ${tramite.padre.asunto}</h4>

                    <div class="contenido res" id="divInfoContenido" style="margin-top: 20px; height: 85%">
                    <util:renderHTML html="${tramite.padre.texto}"/>
                    </div>


                </div>
            </g:if>
        </g:if>

        <div class="hoja">

            <div class="btn-toolbar toolbar">
                <div class="btn-group">
                    <a href="#" class="btn btn-sm btn-success btnSave">
                        <i class="fa fa-save"></i> Guardar texto
                    </a>
                </div>
                %{--<div class="btn-group">--}%
                    %{--<a href="#" class="btn btn-sm btn-primary btnPrint">--}%
                        %{--<i class="fa fa-file"></i> ver PDF--}%
                    %{--</a>--}%
                %{--</div>--}%
                <div class="btn-group">
                    <a href="#" class="btn btn-sm btn-primary" id="descarga">
                        <i class="fa fa-file"></i>  ver PDF
                    </a>
                </div>

                <div class="btn-group">
                    <g:if test="${tramite.deDepartamento && !esEditor}">
                        <g:link controller="tramite2" action="bandejaSalidaDep" class="btnBandeja leave btn btn-sm btn-azul btnRegresar">
                            <i class="fa fa-list-ul"></i> Guardar texto y Salir
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="tramite2" action="bandejaSalida" class="btnBandeja leave btn btn-sm btn-azul btnRegresar">
                            <i class="fa fa-list-ul"></i> Guardar texto y Salir
                        </g:link>
                    </g:else>
                    <g:if test="${!esEditor}">
                        <g:if test="${tramite.deDepartamento}">
                            <g:link controller="tramite2" action="crearTramiteDep" id="${tramite.id}" params="[esRespuesta: tramite.esRespuesta, esRespuestaNueva: tramite.esRespuestaNueva]"
                                    class="leave btn-editar btn btn-sm btn-azul btnRegresar" title="Editar encabezado">
                                <i class="fa fa-pencil"></i>
                            </g:link>
                        </g:if>
                        <g:else>
                            <g:link action="crearTramite" id="${tramite.id}" params="[esRespuesta: tramite.esRespuesta, esRespuestaNueva: tramite.esRespuestaNueva]"
                                    class="leave btn-editar btn btn-sm btn-azul btnRegresar" title="Editar encabezado">
                                <i class="fa fa-pencil"></i>
                            </g:link>

                        </g:else>
                    </g:if>

                </div>



                <div class="btn-group membrete" data-con="${tramite.conMembrete ?: '0'}">
                    <g:if test="${tramite.conMembrete == '1'}">
                        <i class="fa fa-check-square-o"></i> Membrete
                    </g:if>
                    <g:else>
                        <i class="fa fa-square-o"></i> Membrete
                    </g:else>
                </div>

            </div>
            <a href="#" id="btnRevisarProcesos" class="btn btn-success" title="Registrar valores" style="float: right" data-id="${tramite?.id}">
            <i class="fa fa-tag"></i>
             </a>

            <elm:headerTramite tramite="${tramite}"/>

            <textarea id="editorTramite" class="editor" rows="100" cols="80">${tramite.texto}</textarea>
        </div>

        <script type="text/javascript">


            $("#btnRevisarProcesos").click(function () {
                    var tram = ${tramite?.id}

                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'procesoPersona', action: 'revisarProcesos_ajax')}",
                    data: {
                            idTramite: tram
                    },
                    success: function (msg) {
                        bootbox.dialog({
                            id      : "dlgRevisar",
                            title   :  "Revisar procesos de la persona",
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                aceptar  : {
                                    id        : "btnSave",
                                    label     : "<i class='fa fa-save'></i> Aceptar",
                                    className : "btn-success",
                                    callback  : function () {

                                        if($("#procesoSel").val()){
                                                location.href= "${createLink(controller: 'valorProceso', action: 'asignarValor')}/" + ${tramite?.id} + "?proceso=" + $("#procesoSel").val();
                                        }else{
                                            bootbox.alert("El cliente seleccionado no tiene un proceso asociado al tipo de trámite <br> Si desea continuar seleccione otro cliente");
                                            return false;
                                        }



                                        %{--$.ajax({--}%
                                           %{--type: 'POST',--}%
                                            %{--url: "${createLink(controller: 'tramiteProceso', action: '')}",--}%
                                            %{--data: {--}%

                                            %{--},--}%
                                            %{--success: function (msg) {--}%
                                            %{----}%
                                        %{--}--}%
                                        %{--});--}%
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                    }
                });





            });


            function arreglarTexto(texto) {
                texto = $.trim(texto);
                texto = texto.replace(/(?:\&)/g, "&amp;");
                texto = texto.replace(/(?:<)/g, "&lt;");
                texto = texto.replace(/(?:>)/g, "&gt;");
                texto = texto.replace(/(?:\r\n|\r|\n)/g, '');
                return texto;
            }

            var textoInicial = "${tramite.texto}";

            function doSave(url) {
                openLoader("Guardando");

                $.ajax({
                    type     : "POST",
                    url      : '${createLink(controller:"tramite", action: "saveTramite")}',
                    data     : {
                        id            : "${tramite.id}",
                        editorTramite : $("#editorTramite").val(),
                        para          : $("#para").val(),
                        asunto        : $("#asunto").val()
                    },
                    success  : function (msg) {
                        closeLoader();
                        var parts = msg.split("_");
                        if (parts[0] == "OK") {
                            textoInicial = arreglarTexto($("#editorTramite").val());
                        }
                        log(parts[1], parts[0] == "NO" ? "error" : "success");
                        if (url) {
                            location.href = url;
                        }
                    },
                    complete : function () {
                        resetTimer();
                    }
                });
            }

            $(function () {
                $(".membrete").click(function () {
                    var esto = $(this);
                    if (esto.data("con") == '0') {
                        esto.data("con", '1').html('<i class="fa fa-check-square-o"></i> Membrete');
                    } else {
                        esto.data("con", '0').html('<i class="fa fa-square-o"></i> Membrete');
                    }
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'tramite',action:'cambiarMembrete')}",
                        data    : {
                            id       : "${tramite.id}",
                            membrete : esto.data("con")
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "OK" ? 'success' : "error");
                        }
                    });
                });

                $(".header-tramite").append($(".btn-editar"));

                $("#divInfo").resizable({
                    maxWidth  : 450,
                    maxHeight : 600,
                    minWidth  : 240,
                    minHeight : 400
                });

                $("#btnInfoPara").click(function () {
                    var para = $("#para").val();
                    var paraExt = $("#paraExt").val();
                    var id;
                    var url = "";
                    if (para) {
                        if (parseInt(para) > 0) {
                            url = "${createLink(controller: 'persona', action: 'show_ajax')}";
                            id = para;
                        } else {
                            url = "${createLink(controller: 'departamento', action: 'show_ajax')}";
                            id = parseInt(para) * -1;
                        }
                    }
                    if (paraExt) {
                        url = "${createLink(controller: 'origenTramite', action: 'show_ajax')}";
                        id = paraExt;
                    }
                    $.ajax({
                        type    : "POST",
                        url     : url,
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Información",
                                message : msg,
                                buttons : {
                                    aceptar : {
                                        label     : "Aceptar",
                                        className : "btn-primary",
                                        callback  : function () {
                                        }
                                    }
                                }
                            });
                        }
                    });
                    return false;
                });

                $(".btnTerminar").click(function () {
                    bootbox.confirm("Está seguro de querer terminar este trámite? <br/>Esto enviará y recibirá automáticamente el trámite y no podrá ser editado.", function (res) {
                        if (res) {
                            openLoader("Guardando");
                            $.ajax({
                                type    : "POST",
                                url     : '${createLink(action: "saveDEX")}',
                                data    : {
                                    id            : "${tramite.id}",
                                    editorTramite : $("#editorTramite").val()
                                },
                                success : function (msg) {
                                    closeLoader();
                                    var parts = msg.split("*");
                                    if (parts[0] == "OK") {
                                        textoInicial = $("#editorTramite").val();
                                        location.href = parts[1];
                                    } else {
                                        bootbox.alert(parts[1]);
                                    }
                                }
                            });
                        }
                    });
                    return false;
                });

                $(".btnSave").click(function () {
                    doSave();
                    return false;
                });

                $(".btnBandeja").click(function () {
                    var url = $(this).attr("href");
                    doSave(url);
                    return false;
                });

                $("#descarga").click(function () {
                    var url = '${createLink(controller:"tramiteExport", action: "crearPdf")}';

                    var id  = "${tramite.id}";
                    var timestamp = new Date().getTime()

                    location.href = "${createLink(controller:'tramiteExport',action:'crearPdf')}?id=" + id +
                            "&type=download" + "&enviar=1" + "&timestamp=" + timestamp

                });

                //  Checks whether CKEDITOR is defined or not
                if (typeof CKEDITOR != "undefined") {
                    $('textarea.editor').ckeditor({
                        height                  : 600,
                        filebrowserBrowseUrl    : '${createLink(controller: "tramiteImagenes", action: "browser")}',
                        filebrowserUploadUrl    : '${createLink(controller: "tramiteImagenes", action: "uploader")}',
                        filebrowserWindowWidth  : 950,
                        filebrowserWindowHeight : 500,

                        toolbar                 : [
//                            [ 'Source', 'ServerSave', *//*'NewPage', *//*'CreatePdf',*/ /*'-',*/ /*'Scayt'*/],
//                            [ 'Source'],
                            ['Scayt', '-', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo'],
                            ['Find', 'Replace', '-', 'SelectAll'],
                            ['Table', 'HorizontalRule', 'PageBreak'],
                            ['Image'/*, 'Timestamp'*/, '-', 'TextColor', 'BGColor', '-', 'About'],
                            '/',
                            ['Bold', 'Italic', 'Underline', /*'Strike', */'Subscript', 'Superscript'/*, '-', 'RemoveFormat'*/],
                            ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'FontSize']
//                            [/* 'Font', 'FontSize'*/ /*, '-', 'TextColor', 'BGColor'*/]
//                            ['About' ]
                        ]
                    });
                }

                CKEDITOR.on('instanceReady', function (ev) {
                    // Prevent drag-and-drop.
                    ev.editor.document.on('drop', function (ev) {
                        ev.data.preventDefault(true);
                    });
                });

            });
        </script>
    </body>
</html>


