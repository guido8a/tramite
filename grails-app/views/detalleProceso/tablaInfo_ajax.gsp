<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/05/16
  Time: 12:01 PM
--%>
<g:each in="${detalle}" var="d">
    <tr>
        <td style="width: 25%">${d?.dato?.fase?.descripcion}</td>
        <td style="width: 35%;">${d?.dato?.descripcion}</td>
        <td style="width: 37%">${d?.etiqueta}</td>
    </tr>
</g:each>
