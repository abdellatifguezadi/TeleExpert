package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Creneau;

import java.util.List;

public interface ICreneauDao {

    void save(Creneau creneau);
    List<Creneau> findBySpecialisteId(Long specialisteId);
    Creneau findById(Long id);
    boolean updateStatus(Long creneauId, String status);
}
