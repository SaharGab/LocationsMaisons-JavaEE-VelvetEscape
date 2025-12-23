<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mes Biens</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<h2 class="mb-4">Liste de mes biens</h2>

<table class="table table-striped">
    <thead class="table-dark">
        <tr>
            <th>#</th>
            <th>Type</th>
            <th>Prix / jour</th>
            <th>Description</th>
            <th>Disponibilité</th>
            <th>Image</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="bien" items="${biens}">
        <tr>
            <td>${bien.id}</td>
            <td>${bien.type}</td>
            <td>${bien.prixParJour} TND</td>
            <td>${bien.description}</td>
            <td>
                <c:choose>
                    <c:when test="${bien.disponibilite == 1}">
                        <span class="text-success">Disponible</span>
                    </c:when>
                    <c:otherwise>
                        <span class="text-danger">Non Disponible</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${not empty bien.imagesBien}">
                    <img src="${pageContext.request.contextPath}/images/${bien.imagesBien[0].chemin}" width="100" alt="Image Bien">
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<a href="${pageContext.request.contextPath}/pages/agent/dashboard_agent.jsp" class="btn btn-secondary mt-3">Retour</a>

</body>
</html>
