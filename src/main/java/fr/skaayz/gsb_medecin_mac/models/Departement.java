package fr.skaayz.gsb_medecin_mac.models;

public class Departement {
    // Variables
    private int id;
    private String libelle;
    private int pays_id;

    // Constructor
    public Departement(int id, String libelle, int pays_id) {
        this.id = id;
        this.libelle = libelle;
        this.pays_id = pays_id;
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

    public int getPays_id() {
        return pays_id;
    }

    public void setPays_id(int pays_id) {
        this.pays_id = pays_id;
    }
}
