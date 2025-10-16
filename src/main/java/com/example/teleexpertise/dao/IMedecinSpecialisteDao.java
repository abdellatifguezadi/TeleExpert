package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.MedecinSpecialiste;
import java.util.List;

public interface IMedecinSpecialisteDao {
    List<MedecinSpecialiste> findAll();
    List<MedecinSpecialiste> findBySpecialite(MedecinSpecialiste.Specialite specialite);
    List<MedecinSpecialiste> findByTarif(Double tarif);
    MedecinSpecialiste findById(Long id);
}