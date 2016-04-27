<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 11/03/16
  Time: 11:03 AM
--%>
<g:each in="${datos}" var="d">
    <tr>
        <td>
            ${d?.fase?.descripcion}
        </td>
        <td>
            ${d?.descripcion}
        </td>
        <td>
            ${d?.valor}
        </td>
        <td>
            ${d?.tipo}
        </td>
        <td style="width: 100px">
            <a href="#" class="btn btn-success btn-sm btnEditar" title="Editar datos" desc="${d?.descripcion}" vlor="${d?.valor}" tpo="${d?.tipo}" ocul="${d?.id}">
                <i class="fa fa-pencil"></i>
            </a>
            <a href="#" class="btn btn-danger btn-sm btnBorrar" title="Borrar datos" idDato="${d?.id}" idFase="${d?.fase?.id}">
                <i class="fa fa-trash"></i>
            </a>
        </td>
    </tr>
</g:each>

<script type="text/javascript">

    $(".btnBorrar").click(function () {
        var idD = $(this).attr("idDato");
        var idFase =  $(this).attr("idFase");

        bootbox.confirm("<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>Está seguro de eliminar este dato?</p>", function (res) {
            if(res){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'dato', action: 'borrarDato_ajax')}",
                    data: {
                        id: idD
                    },
                    success: function (msg) {
                        if(msg != 'no'){
                            log("Datos borrados correctamente","success");
                            cargar(idFase);
                        }else{
                            log("Error al borrar los datos!","error")
                        }
                    }
                });
            }
        });
    });


    $(".btnEditar").click(function () {


        $("#btnGuardar").removeClass('hide');
        $("#btnAgregar").addClass('hide');
        var descripcionEditar = $(this).attr("desc");
        var valorEditar = $(this).attr("vlor");
        var tipoEditar = $(this).attr("tpo");
        var ocultoEditar = $(this).attr("ocul");


        $("#descripcion").val(descripcionEditar);
        $("#valor").val(valorEditar);
        $("#tipo").val(tipoEditar);
        $("#oculto").val(ocultoEditar)

    });




</script>
