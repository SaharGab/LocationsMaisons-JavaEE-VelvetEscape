package servlet;

import model.Utilisateur;
import model.Bien;
import util.connexion_db;
import dao.BienDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.Paths;
import java.util.Collection;

@WebServlet("/AjoutBienServlet")
@MultipartConfig
public class AjoutBienServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("===== DÉBUT AjoutBienServlet =====");

        HttpSession session = request.getSession();
        Utilisateur agent = (Utilisateur) session.getAttribute("user");

        if (agent == null || !"agent".equals(agent.getRole())) {
            System.out.println("🚫 Utilisateur non connecté ou non agent");
            response.sendRedirect(request.getContextPath() + "/pages/agent/agent_login.jsp");
            return;
        }

        String type = request.getParameter("type");
        String description = request.getParameter("description");
        String strPrix = request.getParameter("prix_par_jour");
        String disponibiliteStr = request.getParameter("disponibilite");

        double prix = 0;
        try {
            prix = Double.parseDouble(strPrix);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Erreur prix invalide !");
            request.getRequestDispatcher("/pages/agent/dashboard_agent.jsp").forward(request, response);
            return;
        }

        boolean dispo = "Disponible".equals(disponibiliteStr);

        Bien bien = new Bien();
        bien.setType(type);
        bien.setDescription(description);
        bien.setPrixParJour(prix);
        bien.setDisponibilite(dispo ? "1" : "0");
        bien.setIdUtilisateur(agent.getId());

        // 1. Ajouter le Bien et récupérer son ID
        int idBienCree = BienDAO.ajouterBienEtRetournerId(bien);

        if (idBienCree > 0) {
            System.out.println("✅ Bien ajouté avec ID : " + idBienCree);

         // 2. Traitement des images multiples
            String uploadPath = getServletContext().getRealPath("/images");
            new File(uploadPath).mkdirs();

            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    part.write(uploadPath + File.separator + fileName); // Ici File.separator est bon dans .write()

                    // Enregistrer le chemin de l'image en BDD
                    BienDAO.ajouterImagePourBien(idBienCree, fileName);
                }
            }


            // Redirection vers la liste des biens
            response.sendRedirect(request.getContextPath() + "/ListeBiensServlet");

        } else {
            System.out.println("🚫 Erreur lors de l'ajout du bien !");
            request.setAttribute("message", "Erreur lors de l'ajout du bien !");
            request.getRequestDispatcher("/pages/agent/dashboard_agent.jsp").forward(request, response);
        }

        System.out.println("===== FIN AjoutBienServlet =====");
    }
}
