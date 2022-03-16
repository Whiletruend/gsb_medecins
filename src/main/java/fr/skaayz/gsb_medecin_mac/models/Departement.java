package fr.skaayz.gsb_medecin_mac.models;

public class Departement {
    // Variables
    private final int id;
    private final String libelle;
    private final int pays_id;

    // Constructor
    public Departement(int id, String libelle, int pays_id) {
        this.id = id;
        this.libelle = libelle;
        this.pays_id = pays_id;
    }

    // Functions
    public int getID() {
        return id;
    }

    public String getName() {
        return libelle;
    }

    public int getCountryID() {
        return pays_id;
    }
}
