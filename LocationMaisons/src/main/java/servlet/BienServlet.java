package servlet;

import dao.BienDAO;
import model.Bien;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/BienServlet")
public class BienServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ici, on récupère tous les biens (comme avant)
        List<Bien> biens = BienDAO.getAllBiens();

        for (Bien bien : biens) {
            bien.setImagesBien(BienDAO.getImagesByBienId(bien.getId()));
        }

        request.setAttribute("biens", biens);

        // 🔵 Cette servlet sert SEULEMENT pour les visiteurs
        request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
    }
}
