package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.CreneauDao;
import com.example.teleexpertise.dao.ICreneauDao;
import com.example.teleexpertise.dao.IMedecinSpecialisteDao;
import com.example.teleexpertise.dao.MedecinSpecialisteDao;
import com.example.teleexpertise.model.Creneau;
import com.example.teleexpertise.model.MedecinSpecialiste;
import com.example.teleexpertise.service.CreneauService;
import com.example.teleexpertise.service.ICreneauService;
import com.example.teleexpertise.service.IMedecinSpecialisteService;
import com.example.teleexpertise.service.MedecinSpecialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/generaliste/SpecialisteList")
public class SpecialisteListeServlet extends HttpServlet {

    private IMedecinSpecialisteService medecinSpecialisteService;
    private ICreneauService creneauService;
    @Override
    public void init() {
        IMedecinSpecialisteDao medecinSpecialisteDao = new MedecinSpecialisteDao();
        ICreneauDao creneauDao = new CreneauDao();
        medecinSpecialisteService = new MedecinSpecialisteService(medecinSpecialisteDao);
        creneauService = new CreneauService(creneauDao);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException , IOException {

        List<MedecinSpecialiste> specialistes = medecinSpecialisteService.findAll();

        Map<Long, List<Creneau>> creneauxParSpecialiste = new HashMap<>();

        for (MedecinSpecialiste specialiste : specialistes) {
            List<Creneau> creneaux = creneauService.creneauxByMedecinId(specialiste.getId());
            creneauxParSpecialiste.put(specialiste.getId(), creneaux);
        }


        request.setAttribute("specialistes", specialistes);
        request.setAttribute("creneauxParSpecialiste", creneauxParSpecialiste);
        request.getRequestDispatcher("/generaliste/specialisteList.jsp").forward(request, response);

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String specialiteParam = request.getParameter("specialite");
        String tarifParam = request.getParameter("tarif");

        MedecinSpecialiste.Specialite specialite = null;
        Double tarif = null;

        if (specialiteParam != null && !specialiteParam.isEmpty()) {
            try {
                specialite = MedecinSpecialiste.Specialite.valueOf(specialiteParam.toUpperCase());
            } catch (IllegalArgumentException e) {
            }
        }

        if (tarifParam != null && !tarifParam.isEmpty()) {
            try {
                tarif = Double.parseDouble(tarifParam);
            } catch (NumberFormatException e) {
            }
        }

        final MedecinSpecialiste.Specialite finalSpecialite = specialite;
        final Double finalTarif = tarif;

        List<MedecinSpecialiste> specialistes;

        if (specialite != null && tarif != null) {
            specialistes = medecinSpecialisteService.findAll().stream()
                .filter(s -> s.getSpecialite() == finalSpecialite && s.getTarif().equals(finalTarif))
                .collect(java.util.stream.Collectors.toList());
        } else if (specialite != null) {
            specialistes = medecinSpecialisteService.findBySpecialite(specialite);
        } else if (tarif != null) {
            specialistes = medecinSpecialisteService.findByTarif(tarif);
        } else {
            specialistes = medecinSpecialisteService.findAll();
        }

        Map<Long, List<Creneau>> creneauxParSpecialiste = new HashMap<>();

        for (MedecinSpecialiste specialiste : specialistes) {
            List<Creneau> creneaux = creneauService.creneauxByMedecinId(specialiste.getId());
            creneauxParSpecialiste.put(specialiste.getId(), creneaux);
        }

        request.setAttribute("specialistes", specialistes);
        request.setAttribute("creneauxParSpecialiste", creneauxParSpecialiste);
        request.getRequestDispatcher("/generaliste/specialisteList.jsp").forward(request, response);
    }


}
