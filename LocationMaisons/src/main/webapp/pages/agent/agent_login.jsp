<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion Agent - Velvet Escape</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Icon -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/material-icon/css/material-design-iconic-font.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<input type="hidden" id="status" value="<c:out value='${status}'/>">

<div class="main">
    <!-- Section Connexion -->
    <section class="sign-in">
        <div class="container">
            <div class="signin-content">
                <div class="signin-image">
                    <figure>
                        <img src="${pageContext.request.contextPath}/images/sign.jpg" alt="agent login image" />
                    </figure>
                </div>

                <div class="signin-form">
                    <h2 class="form-title">Connexion Agent</h2>
                    <form method="post" action="${pageContext.request.contextPath}/LoginAgentServlet" class="register-form" id="login-form">
                        <div class="form-group">
                            <label for="email"><i class="zmdi zmdi-email"></i></label>
                            <input type="email" name="email" id="email" placeholder="Adresse email" required />
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="zmdi zmdi-lock"></i></label>
                            <input type="password" name="password" id="password" placeholder="Mot de passe" required />
                        </div>
                        <div class="form-group form-button">
                            <input type="submit" class="form-submit" value="Se connecter" />
                        </div>
                    </form>
                    
                    <!-- Affichage d'un message d'erreur si échec -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger mt-3">${message}</div>
                    </c:if>

                </div>
            </div>
        </div>
    </section>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>

<!-- SweetAlert -->
<script type="text/javascript">
    var status = document.getElementById("status").value;
    if (status === "failed") {
        swal("Erreur", "Email ou mot de passe incorrect", "error");
    }
</script>

</body>
</html>
