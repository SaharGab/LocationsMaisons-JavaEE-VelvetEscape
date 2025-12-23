package servlet;

import util.connexion_db;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.security.MessageDigest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String rawPassword = request.getParameter("password");
        String password = hashPassword(rawPassword);
        String role = "client";

        try (Connection con = connexion_db.getConnection()) {
            String sql = "INSERT INTO utilisateur (nom, prenom, email, mot_de_passe, typeUser) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nom);
            ps.setString(2, prenom);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, role);

            ps.executeUpdate();

            // ✅ Pour SweetAlert dans register.jsp
            request.setAttribute("status", "success");
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            // ✅ En cas d'erreur → SweetAlert échoue
            request.setAttribute("status", "failed");
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);
        }
    }

    // 🔐 Hachage SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors du hash du mot de passe", e);
        }
    }
}
