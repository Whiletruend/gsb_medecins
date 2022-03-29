package fr.skaayz.gsb_medecin_mac.models;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MedecinAccess extends Database {
    public static ObservableList<Medecin> getAll() {
        ObservableList<Medecin> medecins_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query("SELECT * FROM medecin;");

            while(request.next()) {
                medecins_List.addAll(
                    new Medecin(
                        request.getInt("id"),
                        request.getString("nom"),
                        request.getString("prenom"),
                        request.getString("adresse"),
                        request.getString("tel"),
                        request.getString("specialite"),
                        request.getInt("departement_id")
                    )
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return medecins_List;
    }

    public static Medecin getMedicByID(int id) {
        Medecin medecin = null;

        try {
            ResultSet request = Database.query("SELECT * FROM medecin WHERE id = " + id + ";");

            if (request.next()) {
                medecin = new Medecin(
                    request.getInt("id"),
                    request.getString("nom"),
                    request.getString("prenom"),
                    request.getString("adresse"),
                    request.getString("tel"),
                    request.getString("specialite"),
                    request.getInt("departement_id")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return medecin;
    }

    public static void deleteMedecinByID(int id) {
        try {
            Database.execute("DELETE FROM medecin WHERE id = " + id + ";");
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateMedecinByID(int id, String[] table) {
        try {
            Database.execute(
        "UPDATE medecin " +
                "SET nom = '" + table[1] + "', " +
                "prenom = '" + table[2] + "', " +
                "adresse = '" + table[3] + "', " +
                "tel = '" + table[4] + "', " +
                "specialite = '" + table[5] + "', " +
                "departement_id = " + table[6] + " " +
                "WHERE id = " + id + ";"
            );
            //Database.execute("UPDATE medecin SET nom = " + unMedecin.getNom() + ", prenom = " + unMedecin.getPrenom() WHERE id = " + unMedecin.getId() + ";");
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
}