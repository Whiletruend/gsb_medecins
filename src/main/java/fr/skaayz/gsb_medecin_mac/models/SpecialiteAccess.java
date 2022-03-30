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
}
