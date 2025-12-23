<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.BienDAO, model.Bien, model.Imagebien" %>
<%@ page session="true" %>
<%
    String idBienStr = request.getParameter("id");
    int idBien = Integer.parseInt(idBienStr);
    Bien bien = BienDAO.getBienById(idBien);
    java.util.List<Imagebien> images = BienDAO.getImagesByBienId(idBien);
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Bien - Velvet Escape</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="background-color: #f8f9fa;">

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <div class="card shadow-sm">
                <div class="row g-0">
                    <div class="col-md-6">

                        <%-- Carousel d'images --%>
                        <div id="carouselImages" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <%
                                    for (int i = 0; i < images.size(); i++) {
                                        Imagebien img = images.get(i);
                                %>
                                    <div class="carousel-item <%= (i == 0 ? "active" : "") %>">
                                        <img src="<%= contextPath %>/images/<%= img.getChemin() %>" class="d-block w-100 img-fluid" style="height: 300px; object-fit: cover;" alt="Image Bien">
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselImages" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Précédent</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselImages" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Suivant</span>
                            </button>
                        </div>

                    </div>

                    <div class="col-md-6">
                        <div class="card-body d-flex flex-column h-100">
                            <h3 class="card-title mb-3"><%= bien.getType() %></h3>
                            <p class="card-text mb-4"><%= bien.getDescription() %></p>
                            <p class="card-text"><strong>Prix :</strong> <%= bien.getPrixParJour() %> TND / jour</p>

                            <div class="mt-auto">
                                <div class="d-grid gap-2">
                                    <%
                                        if (session.getAttribute("user") == null) {
                                    %>
                                        <a href="<%= contextPath %>/pages/register.jsp" class="btn btn-primary btn-lg">Inscrivez-vous pour Réserver</a>
                                    <%
                                        } else {
                                    %>
                                        <a href="<%= contextPath %>/pages/reservation.jsp?id=<%= bien.getId() %>" class="btn btn-success btn-lg">Réserver Maintenant</a>
                                    <%
                                        }
                                    %>
                                    <a href="<%= contextPath %>/" class="btn btn-outline-secondary">← Retour à l'Accueil</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
