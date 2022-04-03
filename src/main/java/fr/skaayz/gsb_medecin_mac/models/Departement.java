package fr.skaayz.gsb_medecin_mac.models;

public class Departement {
    // Variables
    private int id;
    private String libelle;
    private Pays pays;

    // Constructor
    public Departement(int id, String libelle, Pays pays) {
        this.id = id;
        this.libelle = libelle;
        this.pays = pays;
    }

    // Functions
    public int getId() {
        return id;
    }

    public String getLibelle() {
        return libelle;
    }

    public Pays getPays() {
        return pays;
    }

    public int getPays_id() {
        return pays.getId();
    }
}
