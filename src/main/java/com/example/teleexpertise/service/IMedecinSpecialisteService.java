package com.example.teleexpertise.service;

import com.example.teleexpertise.model.MedecinSpecialiste;
import java.util.List;

public interface IMedecinSpecialisteService {
    List<MedecinSpecialiste> findAll();
    List<MedecinSpecialiste> findBySpecialite(MedecinSpecialiste.Specialite specialite);
    List<MedecinSpecialiste> findByTarif(Double tarif);
    MedecinSpecialiste findById(Long id);
}