package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.IMedecinSpecialisteDao;
import com.example.teleexpertise.model.MedecinSpecialiste;
import java.util.List;

public class MedecinSpecialisteService implements IMedecinSpecialisteService {
    private final IMedecinSpecialisteDao medecinSpecialisteDao;

    public MedecinSpecialisteService(IMedecinSpecialisteDao medecinSpecialisteDao) {
        this.medecinSpecialisteDao = medecinSpecialisteDao;
    }

    @Override
    public List<MedecinSpecialiste> findAll() {
        return medecinSpecialisteDao.findAll();
    }

    @Override
    public List<MedecinSpecialiste> findBySpecialite(MedecinSpecialiste.Specialite specialite) {
        return medecinSpecialisteDao.findBySpecialite(specialite);
    }
}
