package fr.skaayz.gsb_medecin_mac.models;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DepartementAccess extends Database {
    public static ObservableList<Departement> getAll() {
        ObservableList<Departement> departement_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query("SELECT * FROM departement;");

            while(request.next()) {
                departement_List.addAll(
                        new Departement(
                            request.getInt("id"),
                            request.getString("libelle"),
                            request.getInt("pays_id")
                        )
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return departement_List;
    }
}
