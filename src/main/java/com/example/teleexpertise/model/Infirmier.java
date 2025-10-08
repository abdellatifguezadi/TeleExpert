package com.example.teleexpertise.model;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("Infirmier")
public class Infirmier extends Utilisateur {

    public Infirmier() {
        super();
    }
}