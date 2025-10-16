package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.ICreneauDao;
import com.example.teleexpertise.model.Creneau;

import java.util.List;

public class CreneauService implements ICreneauService {

    private ICreneauDao creneauDao;

    public CreneauService(ICreneauDao creneauDao) {
        this.creneauDao = creneauDao;
    }


    @Override
    public List<Creneau> creneauxByMedecinId(long medecinId) {
        return creneauDao.findBySpecialisteId(medecinId);
    }

    @Override
    public Creneau findById(Long id) {
        return creneauDao.findById(id);
    }

    @Override
    public void updateCreneauStatus(Long creneauId, String status) {
        creneauDao.updateStatus(creneauId, status);
    }
}
