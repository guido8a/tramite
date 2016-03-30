<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 17/03/16
  Time: 10:57 AM
--%>

<table class="table table-bordered table-condensed table-hover" style="width: 440px">
  <thead>
  <tr>
    <th style="width: 350px">
      Descripción
    </th>
    <th style="width: 50px">
      Predeterminado
    </th>
    <th style="width: 40px">
      Acciones
    </th>
  </tr>
  </thead>
  <tbody>
  <g:each in="${lista}" var="l">
    <tr>
      <td>
        ${l?.descripcion}
      </td>
      <td style="text-align: center">
        <g:if test="${l?.defecto == '1'}">
          <g:radio name="defecto_name" class="defecto" value="${''}" checked="true" lis="${l?.id}"/>
        </g:if>
        <g:else>
          <g:radio name="defecto_name" class="defecto" value="${''}" checked="false" lis="${l?.id}"/>
        </g:else>
      </td>
      <td style="text-align: center">
        <a href="#" class="btn btn-danger btn-sm btnBorrar" title="Borrar item" data-id="${l?.id}" data-df="${l?.defecto}">
          <i class="fa fa-trash"></i>
        </a>
      </td>
    </tr>
  </g:each>
  </tbody>
</table>

<script type="text/javascript">

  $(".defecto").click(function () {

    if($(this).prop('checked')){

      var idLista = $(this).attr('lis');

      $.ajax({
        type: 'POST',
        url: "${createLink(controller: "detalleProceso", action: 'saveDefecto_ajax')}",
        data: {
            id: idLista
        },
        success: function (msg) {
          cargarTabla();
        }
      });

    }
  });

  $(".btnBorrar").click(function () {

    var idL = $(this).data('id');
    var defecto = $(this).data('df');

    if(defecto == '1'){
      bootbox.alert("<strong style='color: #ff1120'> Item predeterminado!.</strong> Primero asigne otro item como predeterminado antes de borrar el item actual.")
    }else{
      $.ajax({
        type: 'POST',
        url: "${createLink(controller: 'detalleProceso', action: 'borrarLista_ajax')}",
        data: {
            id: idL
        },
        success: function (msg) {
            if(msg == 'ok'){
              cargarTabla();
            }
        }

      });
    }

  });


</script>