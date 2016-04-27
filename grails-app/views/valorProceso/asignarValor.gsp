<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 22/03/16
  Time: 11:17 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
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

  </div>
</div>




<div style="margin-top: 30px;min-height: 80px" class="vertical-container">
  <p class="css-vertical-text" style="margin-top: -10px;">Datos</p>

  <div class="linea"></div>


%{--<g:form class="form-horizontal" name="frmValor" role="form" action="" method="POST">--}%


  <div class="row">
    <g:each in="${datos}" var="d" status="l">
      <div class="col-md-12" style="margin-left: 10px; margin-bottom: 20px">
        <div class="col-md-1 negrilla control-label">
          ${d?.etiqueta}
        </div>
        <g:if test="${d?.rango == "numerico"}">
          <div class="col-md-5" style="margin-bottom: 20px">
            <g:textField name="nombre_${l}" id="etiqueta_${d?.id}" value="${vlpc[l]?.valor}" data-vl="${vlpc[l]?.id}" class="form-control ${d?.nulo == '1' ? 'required' : ''}" minlength="${d?.numericoMinimo}" maxlength="${d?.numericoMaximo}"/>
          </div>
        </g:if>
        <g:else>
          <div class="col-md-5" style="margin-bottom: 20px">
            <g:textField name="nombre_${l}" id="etiqueta_${d?.id}" value="${vlpc[l]?.valor}" data-vl="${vlpc[l]?.id}" class="form-control ${d?.nulo == '1' ? 'required' : ''}" minlength="${d?.rango?.split(",")[0]}" maxlength="${d?.rango?.split(",")[1]}"/>
          </div>
        </g:else>
        <div class="col-md-4">
          <g:textArea name="obser" id="observaciones_${d?.id}"  value="${vlpc[l]?.observaciones}" class="form-control" maxlength="255" style="resize: none" title="Observaciones"/>
        </div>

        <div class="col-md-2">
          <a href="#" id="btnGuardar" class="btn btn-info btnG" title="Guardar valores" data-id="${d?.id}" style="float: right">
            <i class="fa fa-save"></i>
          </a>
        </div>
      </div>
    </g:each>
  </div>

%{--</g:form>--}%



</div>


<script type="text/javascript">

  $(".btnG").click(function () {

//    console.log($(this).data("id"));

    var idRow = $(this).data("id");
    var valor = $("#etiqueta_" + idRow).val();
    var observa = $("#observaciones_" + idRow).val();
    var proPer = '${pccl?.id}';
    var vl = $("#etiqueta_" + idRow).data("vl");

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