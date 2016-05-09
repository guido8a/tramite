<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 06/05/16
  Time: 10:33 AM
--%>


<table class="table table-bordered table-condensed table-hover table-striped">
  <thead>
  <tr>
    <td style="width: 300px">Proceso</td>
    <td style="width: 300px">Cliente</td>
    <td style="width: 150px">Fecha</td>
  </tr>
  </thead>

</table>

<div class="row-fluid"  style="width: 99.7%;height: 300px;overflow-y: auto;float: right; margin-top: -20px">
  <div class="span12">
    <div style="width: 1070px; height: 300px;">
      <table class="table table-bordered table-condensed table-hover">
        <tbody>
        <g:each in="${pccl}" var="p">
          <tr data-pro="${p?.proceso?.id}" data-per="${p?.persona?.id}">
            <td style="width: 320px">${p?.proceso?.nombre}</td>
            <td style="width: 320px">${p?.persona?.nombre + " " + p?.persona?.apellido}</td>
            <td style="width: 150px"></td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
  </div>
</div>


<script type="text/javascript">
  $(function () {


    $("tbody tr").contextMenu({
      items  : {
        header   : {
          label  : "Acciones",
          header : true
        },
        editar   : {
          label  : "Editar",
          icon   : "fa fa-pencil",
          action : function ($element) {
            var idT = $element.data("pro");
            location.href="${createLink(controller: 'tramite', action: 'redactar')}/" + idT;
          }
        },
        detalle   : {
          label  : "Definir el formulario",
          icon   : "fa fa-table",
          action : function ($element) {
            var id = $element.data("pro")
            location.href="${createLink(controller: 'detalleProceso', action: 'formulario')}/" + id
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