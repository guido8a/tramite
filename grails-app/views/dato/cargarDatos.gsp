<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 10/03/16
  Time: 03:55 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
<div style="margin-top: 0px;" class="vertical-container">
    <p class="css-vertical-text" style="margin-top: -10px;">Fase</p>

    <div class="linea"></div>

    <div style="margin-bottom: 20px">
        <label for="fase" class="col-md-2 control-label text-info">
            Fase
        </label>
        <div class="col-md-6">
                <g:select id="fase" name="fase.id" from="${happy.proceso.Fase.list()}" optionKey="id" optionValue="descripcion" class="many-to-one form-control"/>
        </div>



    </div>

</div>

</body>
</html>