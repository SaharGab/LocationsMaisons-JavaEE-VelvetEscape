package servlet;

import dao.UtilisateurDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utilisateur;

import java.io.IOException;

public class ModifierAgentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Utilisateur agent = new Utilisateur();
            agent.setId(id);
            agent.setNom(nom);
            agent.setPrenom(prenom);
            agent.setEmail(email);

            // Ne pas mettre à jour le mot de passe s'il est vide
            if (password != null && !password.trim().isEmpty()) {
                agent.setPassword(password);
            } else {
                agent.setPassword(null); // pour que le DAO sache ne pas l'update
            }

            UtilisateurDAO.updateAgent(agent);

            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Erreur lors de la mise à jour.");
            request.getRequestDispatcher("pages/admin/dashboard.jsp").forward(request, response);
        }
    }
}
