package fr.skaayz.gsb_medecin_mac.models;

public class Specialite {
    // Variables
    private Integer id;
    private String libelle;

    // Constructor
    public Specialite(Integer id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }

    // Functions
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
}
