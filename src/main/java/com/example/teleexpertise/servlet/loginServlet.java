package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.model.MedecinSpecialiste;
import com.example.teleexpertise.service.LoginServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/login")
public class loginServlet extends HttpServlet {
    private LoginServices loginService;

    @Override
    public void init() {
        loginService = new LoginServices();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    public  void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("motDePasse");

        if (loginService.authenticate(email, password)) {
            request.getSession().setAttribute("userEmail", email);
            UtilisateurDao utilisateurDao = new UtilisateurDao();
            Utilisateur user = utilisateurDao.findByEmail(email);
            if (Utilisateur.Role.INFIRMIER.toString().equals(user.getType_medecin())) {
                response.sendRedirect("infirmier/dashboard");
            } else if (Utilisateur.Role.GENERALISTE.toString().equals(user.getType_medecin())) {
                response.sendRedirect("generaliste/dashboard");
            } else if (Utilisateur.Role.SPECIALISTE.toString().equals(user.getType_medecin())) {
                MedecinSpecialiste spec = (MedecinSpecialiste) user;
                if (spec.getSpecialite() == null || spec.getTarif() == null || spec.getDureeConsultation() == null) {
                    response.sendRedirect("specialiste/complete-profile");
                } else {
                    response.sendRedirect("specialiste/dashboard");
                }
            }
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
