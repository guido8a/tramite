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
      <g:textField name="cliente_name" id="cliente" value="${trpc?.procesoPersona?.persona?.apellido + " " + trpc?.procesoPersona?.persona?.nombre}" readonly="true" class="form-control"/>
    </div>

    <div class="col-xs-1 negrilla control-label">Proceso </div>


    <div class="col-md-4" style="margin-bottom: 20px">
      <g:textField name="proceso_name" id="proceso" value="${trpc?.procesoPersona?.proceso?.nombre}" readonly="true" class="form-control"/>
    </div>

    <div>

      %{--<g:link class="btn btn-primary generar" controller="reportesPersonales" action="reporteProceso" params="[id: trpc?.id]" style="float: right">--}%
      %{--<i class="fa fa-print"></i> Imprimir--}%
      %{--</g:link>--}%

      <a href="#" id="btnImprimir" class="btn btn-primary" title="Imprimir formulario" style="float: right">
        <i class="fa fa-print"> Imprimir</i>
      </a>

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
            <div class="col-md-5" style="margin-bottom: 20px">
              <g:select name="nombre_${d?.id}" from="${happy.proceso.ListaValores.findAllByDetalleProceso(d)}" id="etiqueta_${d?.id}"
                        data-vl="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.id}" value="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.valor}"
                        optionKey="descripcion" optionValue="descripcion" class="form-control"/>
            </div>
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
            <g:textArea name="obser" id="observaciones_${d?.id}" value="${happy.proceso.ValorProceso.findByDetalleProceso(d)?.observaciones}" class="form-control" maxlength="255" style="resize: none" title="Observaciones"/>
          </div>

          <div class="col-md-2">
            <a href="#" id="btnGuardar" class="btn btn-success btnG" title="Guardar valores" data-id="${d?.id}" style="float: right">
              <i class="fa fa-save"></i>
            </a>
          </div>
        </div>
      </g:each>
    </div>

  </g:form>



</div>


<script type="text/javascript">


  $("#btnImprimir").click(function () {
      var $form = $("#frmValor");
      if($form.valid()){
        location.href="${createLink(controller: 'reportesPersonales', action: 'reporteProceso', id: trpc?.id )}";
      }else{
        return false
      }
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