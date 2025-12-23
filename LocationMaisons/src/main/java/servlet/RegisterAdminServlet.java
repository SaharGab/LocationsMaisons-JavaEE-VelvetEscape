package servlet;

import dao.UtilisateurDAO;
import model.Utilisateur;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

public class RegisterAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Utilisateur admin = new Utilisateur();
        admin.setNom(nom);
        admin.setPrenom(prenom);
        admin.setEmail(email);
        admin.setPassword(password);
        admin.setRole("admin");

        boolean success = UtilisateurDAO.ajouterUtilisateur(admin);

        if (success) {
            request.setAttribute("status", "success");
            request.setAttribute("message", "Compte administrateur créé avec succès.");
        } else {
            request.setAttribute("status", "failed");
            request.setAttribute("message", "Erreur lors de l'inscription.");
        }

        request.getRequestDispatcher("pages/admin/admin_register.jsp").forward(request, response);
    }
}
