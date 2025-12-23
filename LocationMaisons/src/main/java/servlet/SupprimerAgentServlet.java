package servlet;

import dao.UtilisateurDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

public class SupprimerAgentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        UtilisateurDAO.supprimerUtilisateur(id);
        response.sendRedirect("AdminDashboardServlet");
    }
}
