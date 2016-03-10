<%@ page import="happy.tramites.EstadoTramiteExterno" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Estado del Trámite Externo</title>
    </head>

    <body>

        <elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="parametros"><i class="fa fa-arrow-left"></i> Regresar</g:link>
            <div class="btn-group">
                <g:link action="form" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Crear
                </g:link>
            </div>
          <div class="btn-group pull-right col-md-3">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <g:link action="list" class="btn btn-default btn-search" type="button">
                            <i class="fa fa-search"></i>&nbsp;
                        </g:link>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <h3>Lista de Estado del Trámite Externo</h3>
        <table class="table table-condensed table-bordered table-striped">
            <thead>
                <tr>
                    <g:sortableColumn property="codigo" title="Código"/>
                    <g:sortableColumn property="descripcion" title="Descripción"/>
                </tr>
            </thead>
            <tbody>
                <g:each in="${estadoTramiteExternoInstanceList}" status="i" var="estadoTramiteExternoInstance">
                    <tr data-id="${estadoTramiteExternoInstance.id}">

                        <td>${fieldValue(bean: estadoTramiteExternoInstance, field: "codigo")}</td>

                        <td>${fieldValue(bean: estadoTramiteExternoInstance, field: "descripcion")}</td>

                    </tr>
                </g:each>
            </tbody>
        </table>

        <elm:pagination total="${estadoTramiteExternoInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            //            var id = null;
            function submitForm() {
                var $form = $("#frmEstadoTramiteExterno");
                var $btn = $("#dlgCreateEdit").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    $.ajax({
                        type    : "POST",
                        url     : '${createLink(action:'save_ajax')}',
                        data    : $form.serialize(),
                        success : function (msg) {
                            var parts = msg.split("_");
                            log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "OK") {
                                location.reload(true);
                            } else {
                                spinner.replaceWith($btn);
                                return false;
                            }
                        }
                    });
                } else {
                    return false;
                } //else
            }
            function deleteRow(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el EstadoTramiteExterno seleccionado? Esta acción no se puede deshacer.</p>",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-trash-o'></i> Eliminar",
                            className : "btn-danger",
                            callback  : function () {
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("_");
                                        log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "OK") {
                                            location.reload(true);
                                        }
                                    }
                                });
                            }
                        }
                    }
                });
            }
            function createEditRow(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? {id : id} : {};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgCreateEdit",
                            title   : title + " Estado Trámite Externo",
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                guardar  : {
                                    id        : "btnSave",
                                    label     : "<i class='fa fa-save'></i> Guardar",
                                    className : "btn-success",
                                    callback  : function () {
                                        return submitForm();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit

            $(function () {

                $(".btnCrear").click(function () {
                    createEditRow();
                    return false;
                });

                $("tr").contextMenu({
                    items  : {
                        header   : {
                            label  : "Acciones",
                            header : true
                        },
                        ver      : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function ($element) {
                                var id = $element.data("id");
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(action:'show_ajax')}",
                                    data    : {
                                        id : id
                                    },
                                    success : function (msg) {
                                        bootbox.dialog({
                                            title   : "Ver Estado de Trámite Externo",
                                            message : msg,
                                            buttons : {
                                                ok : {
                                                    label     : "Aceptar",
                                                    className : "btn-primary",
                                                    callback  : function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                createEditRow(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deleteRow(id);
                            }
                        }
                    },
                    onShow : function ($element) {
                        $element.addClass("trHighlight");
                    },
                    onHide : function ($element) {
                        $(".trHighlight").removeClass("trHighlight");
                    }
                });

            });
        </script>

    </body>
</html>
