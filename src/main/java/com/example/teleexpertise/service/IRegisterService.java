package com.example.teleexpertise.service;

import java.util.List;

public interface IRegisterService {
    List<String> validateInput(String nom, String prenom, String email, String password, String role);
    List<String> register(String nom, String prenom, String email, String password, String role);
}
