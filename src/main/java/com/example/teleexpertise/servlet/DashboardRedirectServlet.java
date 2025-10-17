package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardRedirectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String userEmail = (String) session.getAttribute("userEmail");
        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmail(userEmail);
        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Utilisateur.Role role = utilisateur.getRole();
        if (role == Utilisateur.Role.SPECIALISTE) {
            response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");
        } else if (role == Utilisateur.Role.GENERALISTE) {
            response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
        } else if (role == Utilisateur.Role.INFIRMIER) {
            response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}

