package com.example.teleexpertise.service;

import com.example.teleexpertise.model.Creneau;

import java.util.List;

public interface ICreneauService {
    List<Creneau> creneauxByMedecinId(long medecinId);
    Creneau findById(Long id);
    void updateCreneauStatus(Long creneauId, String status);
}
