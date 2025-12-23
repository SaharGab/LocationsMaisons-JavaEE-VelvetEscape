<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription Admin - LocationMaisons</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/alert/dist/sweetalert.css">
</head>
<body>

<input type="hidden" id="status" value="<c:out value='${status}'/>">

<div class="main">
    <!-- Sign up Form -->
    <section class="signup">
        <div class="container">
            <div class="signup-content">
                <div class="signup-form">
                    <h2 class="form-title">Créer un compte Admin</h2>
                    <form method="post" action="${pageContext.request.contextPath}/RegisterAdminServlet" class="register-form" id="register-form">
                        <div class="form-group">
                            <label for="nom"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="nom" id="nom" placeholder="Nom de l'administrateur" required />
                        </div>
                        <div class="form-group">
                            <label for="prenom"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="prenom" id="prenom" placeholder="Prénom de l'administrateur" required />
                        </div>
                        <div class="form-group">
                            <label for="email"><i class="zmdi zmdi-email"></i></label>
                            <input type="email" name="email" id="email" placeholder="Adresse email" required />
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="zmdi zmdi-lock"></i></label>
                            <input type="password" name="password" id="password" placeholder="Mot de passe" required />
                        </div>
                        <div class="form-group form-button">
                            <input type="submit" class="form-submit" value="S'inscrire" />
                        </div>
                    </form>
                    
                </div>
                <div class="signup-image">
                    <figure>
                        <img src="${pageContext.request.contextPath}/images/admin.jpg" alt="admin signup image">
                    </figure>
<a href="${pageContext.request.contextPath}/pages/admin/admin_login.jsp" class="signup-image-link">Déjà inscrit ? Se connecter</a>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- JS -->
<script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script type="text/javascript">
    var status = document.getElementById("status").value;
    if (status === "success") {
        swal("Succès", "Compte admin créé avec succès", "success");
    } else if (status === "failed") {
        swal("Erreur", "Inscription échouée. Veuillez réessayer.", "error");
    }
</script>

</body>
</html>