<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/05/16
  Time: 12:01 PM
--%>
<g:each in="${detalle}" var="d">
    <tr>
        <td style="width: 21%">${d?.dato?.fase?.descripcion}</td>
        <td style="width: 40%;">${d?.dato?.descripcion}</td>
        <td style="width: 39%">${d?.etiqueta}</td>
    </tr>
</g:each>
