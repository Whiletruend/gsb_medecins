package fr.skaayz.gsb_medecin_mac.models;

public class Utilisateur {
    // Variables
    private final int id;
    private final String nom_utilisateur;
    private final String mot_de_passe;
    private static Utilisateur utilisateurActuel = null;

    // Constructor
    public Utilisateur(int id, String nom_utilisateur, String mot_de_passe) {
        this.id = id;
        this.nom_utilisateur = nom_utilisateur;
        this.mot_de_passe = mot_de_passe;
    }

    // Functions
    public int getId() {
        return id;
    }

    public String getNom_utilisateur() {
        return nom_utilisateur;
    }

    public String getMot_de_passe() {
        return mot_de_passe;
    }

    public static Utilisateur getUtilisateurActuel() {
        return Utilisateur.utilisateurActuel;
    }

    public static void setUtilisateurActual(Utilisateur utilisateur) {
        Utilisateur.utilisateurActuel = utilisateur;
    }

    public static void disconnectUser() {
        Utilisateur.utilisateurActuel = null;
    }

    public static boolean isConnected() {
        return true;
        //return Utilisateur.getUtilisateurActuel() != null;
    }
}
