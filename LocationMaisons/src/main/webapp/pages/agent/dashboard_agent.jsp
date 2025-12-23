<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Utilisateur" %>
<%
Utilisateur agent = (Utilisateur) session.getAttribute("user");  // ici changé
if (agent == null) {
    response.sendRedirect(request.getContextPath() + "/pages/agent/agent_login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord Agent - Velvet Escape</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS + Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background-color: #f4f6f9;
        }
        .navbar-brand {
            font-weight: bold;
            letter-spacing: 1px;
        }
        .avatar-circle {
            width: 40px;
            height: 40px;
            background-color: #6c757d;
            color: white;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            text-transform: uppercase;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }
        footer {
            background-color: #343a40;
            color: #fff;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Agent Panel</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav align-items-center">
                <li class="nav-item me-3">
                    <div class="avatar-circle" title="${user.getPrenom()} ${user.getNom()}">
                        ${user.getPrenom().substring(0,1)}${user.getNom().substring(0,1)}
                    </div>
                </li>
                <li class="nav-item me-3">
                    <span class="text-white">${user.getPrenom()} ${user.getNom()}</span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/LogoutServletAgent">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container my-5">
    <h2 class="text-center mb-4">Ajouter un Bien</h2>

    <div class="card p-4 mb-4">
        <form method="post" action="${pageContext.request.contextPath}/AjoutBienServlet" enctype="multipart/form-data" class="row g-3">
            <div class="col-md-6">
                <select name="type" class="form-select" required>
                    <option value="">Choisir Type</option>
                    <option value="appartement">Appartement</option>
                    <option value="house">Maison</option>
                    <option value="villa luxe">Villa de Luxe</option>
                </select>
            </div>
            <div class="col-md-6">
                <input type="number" step="0.01" name="prix_par_jour" class="form-control" placeholder="Prix par jour" required>
            </div>
            <div class="col-12">
                <textarea name="description" class="form-control" placeholder="Description du bien" rows="3" required></textarea>
            </div>
            <div class="col-md-6">
                <select name="disponibilite" class="form-select" required>
                    <option value="Disponible">Disponible</option>
                    <option value="Non Disponible">Non Disponible</option>
                </select>
            </div>
            <div class="col-md-6">
        <!-- Zone Drag & Drop -->
<div id="drop-zone" class="border border-secondary rounded p-5 text-center" style="position: relative;">
    <p id="drop-text">Glissez-déposez vos images ici ou cliquez pour choisir</p>
    <input type="file" name="images" id="images" accept="image/*" multiple style="opacity: 0; width: 100%; height: 100%; position: absolute; top: 0; left: 0; cursor: pointer;">
</div>

<!-- Info Nombre d'Images -->
<!-- Preview des images -->
<div id="preview-images" class="d-flex flex-wrap mt-3 justify-content-center"></div>

<!-- Script Drag & Drop -->
<script>
    const dropZone = document.getElementById('drop-zone');
    const inputImages = document.getElementById('images');
    const previewDiv = document.getElementById('preview-images');
    const dropText = document.getElementById('drop-text');
    const imageCount = document.getElementById('image-count');

    let filesList = [];

    // Empêcher comportement défaut
    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, (e) => e.preventDefault(), false);
    });

    ['dragenter', 'dragover'].forEach(eventName => {
        dropZone.addEventListener(eventName, () => dropZone.classList.add('bg-light'), false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, () => dropZone.classList.remove('bg-light'), false);
    });

    dropZone.addEventListener('drop', (e) => {
        if (e.dataTransfer.files.length) {
            filesList = Array.from(e.dataTransfer.files);
            updateInputFiles();
            displayPreview();
        }
    });

    inputImages.addEventListener('change', () => {
        filesList = Array.from(inputImages.files);
        displayPreview();
    });

    function updateInputFiles() {
        const dataTransfer = new DataTransfer();
        filesList.forEach(file => dataTransfer.items.add(file));
        inputImages.files = dataTransfer.files;
    }

    function displayPreview() {
        previewDiv.innerHTML = "";
        filesList.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = (e) => {
                const wrapper = document.createElement('div');
                wrapper.classList.add('position-relative', 'm-2');

                const img = document.createElement('img');
                img.src = e.target.result;
                img.classList.add('rounded');
                img.style.width = '120px';
                img.style.height = '120px';
                img.style.objectFit = 'cover';
                img.style.boxShadow = '0 2px 6px rgba(0,0,0,0.3)';

                const deleteBtn = document.createElement('button');
                deleteBtn.innerHTML = '❌';
                deleteBtn.classList.add('btn', 'btn-sm', 'btn-danger', 'position-absolute');
                deleteBtn.style.top = '5px';
                deleteBtn.style.right = '5px';
                deleteBtn.style.padding = '2px 6px';
                deleteBtn.onclick = () => {
                    filesList.splice(index, 1);
                    updateInputFiles();
                    displayPreview();
                };

                wrapper.appendChild(img);
                wrapper.appendChild(deleteBtn);
                previewDiv.appendChild(wrapper);
            };
            reader.readAsDataURL(file);
        });

    }
</script>
<style>
    #drop-zone {
        border: 2px dashed #ced4da;
        background-color: #f8f9fa;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    #drop-zone:hover {
        background-color: #e2e6ea;
    }
</style>


                
            </div>
            <div class="col-12 text-end">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Ajouter le Bien
                </button>
            </div>
        </form>
    </div>

    <!-- Nouveau bouton Mes Biens -->
    <div class="text-center">
        <a href="${pageContext.request.contextPath}/ListeBiensServlet" class="btn btn-outline-secondary">
            <i class="fas fa-list"></i> Mes Biens
        </a>
    </div>
</div>

<!-- Footer -->
<footer class="text-center py-4 mt-5">
    <div class="container">
        &copy; 2025 Velvet Escape - Tous droits réservés
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>


</html>

