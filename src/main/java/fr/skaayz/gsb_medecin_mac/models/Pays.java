package fr.skaayz.gsb_medecin_mac.models;

public class Pays {
    // Variables
    private int id;
    private String libelle;

    // Constructor
    public Pays(int id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }

    // Functions
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
}
