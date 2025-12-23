package servlet;

import dao.UtilisateurDAO;
import model.Utilisateur;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Utilisateur> agents = UtilisateurDAO.getAllAgents();
        request.setAttribute("agents", agents);
        request.getRequestDispatcher("pages/admin/dashboard.jsp").forward(request, response);
    }
}
