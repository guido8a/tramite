<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/03/16
  Time: 03:24 PM
--%>

  <g:select id="dato" name="dato.id" from="${datos}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>

<script type="text/javascript">

  cargarTabla($("#dato").val());

  $("#dato").change(function () {
    var idDato = $(this).val();
    cargarTabla(idDato);
  });

  function cargarTabla(idD) {
    $.ajax({
      type: 'POST',
      url: "${createLink(controller: 'detalleProceso', action: 'tablaDatos_ajax')}",
      data: {
        id: idD,
        idPro:${proceso?.id}
      },
      success: function (msg) {
        $("#divTabla").html(msg)
      }
    });
  }


</script>

