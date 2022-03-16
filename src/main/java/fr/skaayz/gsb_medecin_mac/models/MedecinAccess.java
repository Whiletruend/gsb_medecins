package fr.skaayz.gsb_medecin_mac.models;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MedecinAccess extends Database {
    public static ObservableList<Medecin> getAll() {
        ObservableList<Medecin> medecin_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query("SELECT * FROM medecin;");

            while(request.next()) {
                medecin_List.addAll(
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

        return medecin_List;
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
                        request.getInt("departement")
                );
            }
        } catch(SQLException e) {
            System.out.println(e);
        }

        return medecin;
    }
}


/*
        Database db = new Database();
        try {
            ResultSet rs = db.query("SELECT * FROM medecin;");
            while(rs.next()) {
                System.out.println(rs.getString("nom"));
            }
        } catch (SQLException e) {
            System.out.println("Erreur SQL");
        }
         */