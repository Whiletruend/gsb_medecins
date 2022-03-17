package fr.skaayz.gsb_medecin_mac.models;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PaysAccess extends Database {
    public static ObservableList<Pays> getAll() {
        ObservableList<Pays> pays_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query("SELECT * FROM pays;");

            while(request.next()) {
                pays_List.addAll(
                        new Pays(
                            request.getInt("id"),
                            request.getString("libelle")
                        )
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return pays_List;
    }
}
