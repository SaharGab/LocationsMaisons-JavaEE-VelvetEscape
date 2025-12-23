package servlet;

import dao.UtilisateurDAO;
import model.Utilisateur;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

public class LoginAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Utilisateur user = UtilisateurDAO.getUtilisateur(email, password);

        if (user != null && "admin".equals(user.getRole())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
        } else {
            request.setAttribute("message", "Identifiants invalides ou accès non autorisé.");
            request.getRequestDispatcher("pages/admin/admin_login.jsp").forward(request, response);
        }
    }
}
