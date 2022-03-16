package fr.skaayz.gsb_medecin_mac.models;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UtilisateurAccess extends Database {
    public static Utilisateur getUtilisateur(String username, String password) {
        Utilisateur user = null;

        try {
            ResultSet request = Database.query("SELECT * FROM utilisateur WHERE nom_utilisateur = '" + username + "' AND mot_de_passe = '" + password + "' LIMIT 1;");

            if(request.next()) {
                user = new Utilisateur(
                    request.getInt("id"),
                    request.getString("nom_utilisateur"),
                    request.getString("mot_de_passe")
                );
            }

            Utilisateur.setUtilisateurActual(user);
        } catch(SQLException e) {
            e.printStackTrace();
            return null;
        }

        return user;
    }
}