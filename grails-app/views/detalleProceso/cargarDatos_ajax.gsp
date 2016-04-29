
<g:select id="dato" name="dato.id" from="${datos}" optionKey="id" optionValue='${{"" + it.descripcion + " (" + it.valor.trim() + ")"}}' class="many-to-one form-control"/>

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

