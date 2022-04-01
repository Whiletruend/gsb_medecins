package fr.skaayz.gsb_medecin_mac.models;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SpecialiteAccess extends Database {
    public static ObservableList<Specialite> getAll() {
        ObservableList<Specialite> specialite_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query("SELECT * FROM specialite_complementaire;");

            while(request.next()) {
                specialite_List.addAll(
                        new Specialite(
                            request.getInt("id"),
                            request.getString("libelle")
                        )
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return specialite_List;
    }

    public static Specialite getSpecialiteByID(int id) {
        Specialite specialite = null;

        try {
            ResultSet request = Database.query("SELECT * FROM specialite_complementaire WHERE id = " + id + ";");

            if (request.next()) {
                specialite = new Specialite(
                    request.getInt("id"),
                    request.getString("libelle")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return specialite;
    }

    public static Specialite getSpecialityByLibelle(String libelle) {
        Specialite specialite = null;

        try {
            ResultSet request = Database.query("SELECT * FROM specialite_complementaire WHERE libelle = '" + libelle + "';");

            if (request.next()) {
                specialite = new Specialite(
                        request.getInt("id"),
                        request.getString("libelle")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return specialite;
    }

    public static String getLibelleByID(int id) {
        Specialite specialite = null;

        try {
            ResultSet request = Database.query("SELECT * FROM specialite_complementaire WHERE id = " + id + ";");

            if(request.next()) {
                specialite = new Specialite(
                        request.getInt("id"),
                        request.getString("libelle")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        assert specialite != null;
        return specialite.getLibelle();
    }
}
