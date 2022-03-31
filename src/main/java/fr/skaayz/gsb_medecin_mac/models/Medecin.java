package fr.skaayz.gsb_medecin_mac.models;

public class Medecin {
    // Variables
    private int id;
    private String nom;
    private String prenom;
    private String adresse;
    private String tel;
    private int specialite_id;
    private int departement_id;

    // Constructor
    public Medecin(int id, String nom, String prenom, String adresse, String tel, int specialite_id, int departement_id) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.adresse = adresse;
        this.tel = tel;
        this.specialite_id = specialite_id;
        this.departement_id = departement_id;
    }

    // Functions
    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getAdresse() {
        return adresse;
    }

    public String getTel() {
        return tel;
    }

    public Integer getSpecialite_id() {
        return specialite_id;
    }

    public int getDepartement_id() {
        return departement_id;
    }
}
