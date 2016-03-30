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

  <div class="row">
    <div class="" style="margin-left: 100px">
      <div id="tablaDatos">
        <g:each in="${datos}" var="d" status="l">
          <div class="col-xs-2 negrilla control-label" style="margin-top: 10px">${d?.etiqueta} </div>
          <g:if test="${d?.rango == "numerico"}">
            <div class="col-md-4" style="margin-bottom: 20px">
              <g:textField name="nombre_${l}" id="etiqueta_${l}" data-id="${d?.id}" class="form-control" minlength="${d?.numericoMinimo}" maxlength="${d?.numericoMaximo}"/>
            </div>
          </g:if>
          <g:else>
            <div class="" style="margin-bottom: 20px">
              <g:textField name="nombre_${l}" id="etiqueta_${l}" data-id="${d?.id}" class="form-control" minlength="${d?.rango?.split(",")[0]}" maxlength="${d?.rango?.split(",")[1]}"/>
            </div>
          </g:else>

          <div class="">
            <g:textArea name="obser" id="observaciones" data-id="${d?.id}" class="form-control" style="resize: none" title="Observaciones"/>
          </div>

          <a href="#" id="btnGuardar" class="btn btn-success" title="Guardar valores" style="float: right">
            <i class="fa fa-save"> Guardar</i>
          </a>

        </g:each>
      </div>

      <div style="margin-top: 10px">

      </div>
    </div>
  </div>
</div>


<script type="text/javascript">

  $("#btnGuardar").click(function () {
//    var


  });


</script>


</body>
</html>