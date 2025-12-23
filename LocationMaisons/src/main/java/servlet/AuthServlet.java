package servlet;

import dao.UtilisateurDAO;
import model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("username");
        String password = request.getParameter("password");

        Utilisateur user = UtilisateurDAO.getUtilisateur(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("message", "Bienvenue " + user.getPrenom() + " !");
            response.sendRedirect(request.getContextPath() + "/pages/dashboard_client.jsp");
        } else {
            request.setAttribute("status", "failed");
            request.getRequestDispatcher("pages/login.jsp").forward(request, response);
        }
    }
}
