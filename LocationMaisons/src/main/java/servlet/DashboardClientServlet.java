package servlet;

import dao.BienDAO;
import model.Bien;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/DashboardClientServlet")
public class DashboardClientServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("✅ DashboardClientServlet doGet() déclenché !");

        List<Bien> biens = BienDAO.getAllBiens();
        for (Bien bien : biens) {
            bien.setImagesBien(BienDAO.getImagesByBienId(bien.getId()));
        }

        request.setAttribute("biens", biens);
        request.getRequestDispatcher("/pages/dashboard_client.jsp").forward(request, response);
    }
}
