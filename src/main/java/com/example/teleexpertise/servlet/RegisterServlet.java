package com.example.teleexpertise.servlet;

import com.example.teleexpertise.service.IRegisterService;
import com.example.teleexpertise.service.RegisterService;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private IRegisterService registerService;

    @Override
    public void init() {
        registerService = new RegisterService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String password = req.getParameter("motDePasse");
        String role = req.getParameter("role");

        try {
            List<String> errors = registerService.register(nom, prenom, email, password, role);
            if (errors != null && !errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("nom", nom);
                req.setAttribute("prenom", prenom);
                req.setAttribute("email", email);
                req.setAttribute("role", role);
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                return;
            }

            resp.sendRedirect("index.jsp");
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de l'inscription: " + e.getMessage());
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}