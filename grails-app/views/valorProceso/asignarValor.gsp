<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 22/03/16
  Time: 11:17 AM
--%>

<%@ page import="happy.proceso.ValorProceso" contentType="text/html;charset=UTF-8" %>
<html>
<head>


  <meta name="layout" content="main">
  <title>Registro de Valores por Proceso</title>
</head>
<body>
<div style="margin-top: 30px;min-height: 80px" class="vertical-container">
  <p class="css-vertical-text" style="margin-top: -10px;">Info</p>

  <div class="linea"></div>

  <div class="row">

    <div class="col-xs-1 negrilla control-label">Cliente </div>

    <div class="col-md-4" style="margin-bottom: 20px">
      <g:textField name="cliente_name" id="cliente" value="${pccl?.persona?.apellido + " " + pccl?.persona?.nombre}" readonly="true" class="form-control"/>
    </div>

    <div class="col-xs-1 negrilla control-label">Proceso </div>


    <div class="col-md-4" style="margin-bottom: 20px">
      <g:textField name="proceso_name" id="proceso" value="${pccl?.proceso?.nombre}" readonly="true" class="form-control"/>
    </div>

    <div>
      %{--<div class="btn-group">--}%
        <a href="#" id="btnImprimir" class="btn btn-primary" title="Imprimir formulario" style="float: right">
          <i class="fa fa-print"> Imprimir</i>
        </a>
      <g:if test="${!pccl?.fechaCompletado}">
        <a href="#" id="btnAprobar" class="btn btn-success" title="Aprobar formulario" style="float: right">
          <i class="fa fa-check-circle-o"> Aprobar</i>
        </a>
      </g:if>

      %{--</div>--}%
    </div>

  </div>
</div>


<div style="margin-top: 30px;min-height: 80px" class="vertical-container">
  <p class="css-vertical-text" style="margin-top: -10px;">Datos</p>

  <div class="linea"></div>


  <g:form class="form-horizontal" name="frmValor" role="form" action="" method="POST">


    <div class="row">


      <g:each in="${datos}" var="d" status="l">
        <div class="col-md-12" style="margin-left: 10px; margin-bottom: 20px">
          <div class="col-md-1 negrilla control-label">
            ${d?.etiqueta}
          </div>
          <g:if test="${happy.proceso.ListaValores.findAllByDetalleProceso(d)}">

            <g:if test="${d?.dato?.tipo == 'Selección Múltiple'}">
              <div class="col-md-5" style="margin-bottom: 20px">

                <table class="table table-bordered table-condensed table-hover" style="width: 450px">
                  <thead>
                  </thead>
                  <tbody>
                  <g:each in="${happy.proceso.ListaValores.findAllByDetalleProceso(d)}" var="z">
                    <tr>
                      <td>
                        ${z?.descripcion}
                      </td>
                      <td style="text-align: center">
                          <g:checkBox name="multi_name" class="multi" lis="${z?.id}" value=""
                                      checked="${happy.proceso.ValorProceso.findByDetalleProcesoAndValor(d, z?.id?.toString()) ? 'true' : 'false'}"/>
                      </td>
                    </tr>
                  </g:each>
                  </tbody>
                </table>
              </div>

            </g:if>
            <g:else>
              <div class="col-md-5" style="margin-bottom: 20px">
                <g:select name="nombre_${d?.id}" from="${happy.proceso.ListaValores.findAllByDetalleProceso(d)}" id="etiqueta_${d?.id}"
                          data-vl="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.id}" value="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.valor}"
                          optionKey="descripcion" optionValue="descripcion" class="form-control"/>
              </div>
            </g:else>
          </g:if>
          <g:else>
            <g:if test="${d?.rango == "numerico"}">
              <div class="col-md-5" style="margin-bottom: 20px">
                <span class="grupo">
                  <g:textField name="nombre_${d?.id}" id="etiqueta_${d?.id}" value="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.valor}"
                               data-vl="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.id}" class="form-control ${d?.nulo == '0' ? 'required' : ''}"
                               minlength="${d?.numericoMinimo}" maxlength="${d?.numericoMaximo}"/>
                </span>
              </div>
            </g:if>
            <g:else>
              <div class="col-md-5" style="margin-bottom: 20px">
                <span class="grupo">
                  <g:textField name="nombre_${d?.id}" id="etiqueta_${d?.id}" value="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.valor}"
                               data-vl="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.id}" class="form-control ${d?.nulo == '0' ? 'required' : ''}"
                               minlength="${d?.rango?.split(",")[0]}" maxlength="${d?.rango?.split(",")[1]}"/>
                </span>
              </div>
            </g:else>
          </g:else>
          <div class="col-md-4">
            <g:if test="${d?.observacionRequerida == '1'}">
              <g:textArea name="obser" id="observaciones_${d?.id}" value="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.observaciones}" class="form-control" maxlength="255" style="resize: none" title="Observaciones"/>
            </g:if>
            <g:else>
              <g:textArea name="obser" id="observaciones_${d?.id}" value="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.observaciones}" class="form-control hide" maxlength="255" style="resize: none" title="Observaciones"/>
            </g:else>
          </div>

          <div class="col-md-2">
            <g:if test="${d?.dato?.tipo == 'Selección Múltiple'}">
              <a href="#" id="btnGuardar" class="btn btn-success btnS" title="Guardar valores" data-id="${d?.id}" style="float: right">
                <i class="fa fa-save"></i>
              </a>
            </g:if>
            <g:else>
              <a href="#" id="btnGuardar" class="btn btn-success btnG" title="Guardar valores" data-id="${d?.id}" style="float: right">
                <i class="fa fa-save"></i>
              </a>
            </g:else>

          </div>
        </div>
      </g:each>
    </div>

  </g:form>



</div>


<script type="text/javascript">


  $(".btnS").click(function () {


    var idRow = $(this).data("id");
    var observa = $("#observaciones_" + idRow).val();
    var proPer = '${pccl?.id}';
    var arr = []
    var strIds = ""


    $(".multi").each(function () {
      if($(this).prop("checked") == true){
//      console.log("-->"  + $(this).attr("lis"))
//      arr += $(this).attr("lis")
        if (strIds != "") {
          strIds += ",";
        }
        strIds += $(this).attr("lis")
      }
    });


    $.ajax({
      type:'POST',
      url: '${createLink(controller: 'valorProceso', action: 'guardarListaMarcada_ajax')}',
      data:{
        dtpc: idRow,
        arreglo: strIds,
        obs: observa,
        pccl: proPer
      },
      success: function (msg) {
        if(msg == 'ok'){
          log("Elementos seleccionados correctamente","success")
        }else{
          log("Error al guardar la selección de elementos","error")
        }
      }
    });
  });

  $(".btnG").click(function () {

    var $form = $("#frmValor");
    var idRow = $(this).data("id");
    var valor = $("#etiqueta_" + idRow).val();
    var observa = $("#observaciones_" + idRow).val();
    var proPer = '${pccl?.id}';
    var vl = $("#etiqueta_" + idRow).data("vl");

    if($form.valid()){
      $.ajax({
        type:'POST',
        url: "${createLink(controller: 'valorProceso', action: 'saveValor_ajax')}",
        data: {
          dtpc: idRow,
          val: valor,
          obs: observa,
          pccl: proPer,
          vlpc: vl
        },
        success: function (msg) {
          if(msg == 'ok'){
            log("Valor guardado correctamente","success")
          }else{
            log("Error al guardar el valor","error")
          }
        }
      });
    }else{
      return false
    }
  });


  $("#btnImprimir").click(function () {
    var $form = $("#frmValor");
    if($form.valid()){
      location.href="${createLink(controller: 'reportesPersonales', action: 'reporteProceso', id: trpc?.id )}";
    }else{
      return false
    }
  });


  $("#btnAprobar").click(function (){
    bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de aprobar este formulario?", function (result) {
      if(result){

        $.ajax({
          type: 'POST',
          url: '${createLink(controller: 'valorProceso', action: 'aprobar_ajax')}',
          data:{
            id: '${pccl?.id}'
          },
          success: function (msg) {
            if(msg == 'ok'){
              log("Formulario aprobado correctamente","success");
              setTimeout(function () {
                location.reload(true)
              }, 1500);
            }else{
              log("Error al aprobar el formulario","error")
            }
          }
        })

      }
    });
  });





  var validator = $("#frmValor").validate({
    errorClass     : "help-block",
    errorPlacement : function (error, element) {
      if (element.parent().hasClass("input-group")) {
        error.insertAfter(element.parent());
      } else {
        error.insertAfter(element);
      }
      element.parents(".grupo").addClass('has-error');
    },
    success        : function (label) {
      label.parents(".grupo").removeClass('has-error');
    }
  });




</script>


</body>
</html>