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

    public static Pays getCountryByLibelle(String libelle) {
        Pays pays = null;

        try {
            ResultSet request = Database.query("SELECT * FROM pays WHERE libelle = '" + libelle + "';");

            if(request.next()) {
                pays = new Pays(
                    request.getInt("id"),
                    request.getString("libelle")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return pays;
    }

    public static void deleteCountryByID(int id) {
        try {
            Database.execute("DELETE FROM pays WHERE id = " + id + ";");
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateCountryByID(int id, String[] table) {
        try {
            Database.execute(
                    "UPDATE pays " +
                            "SET libelle = '" + table[1] + "' " +
                            "WHERE id = " + id + ";"
            );
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static void createCountry(String[] table) {
        try {
            Database.execute(
        "INSERT INTO pays(libelle) VALUES(" +
                "'" + table[0] + "');"
            );
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static ObservableList<Pays> getByLike(String search) {
        ObservableList<Pays> pays_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query(
            "SELECT * FROM pays " +
                    "WHERE libelle LIKE '%" + search + "%';"
            );

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

    public static String getLibelleByID(int id) {
        Pays pays = null;

        try {
            ResultSet request = Database.query("SELECT * FROM pays WHERE id = " + id + ";");

            if(request.next()) {
                pays = new Pays(
                        request.getInt("id"),
                        request.getString("libelle")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        assert pays != null;
        return pays.getLibelle();
    }
}
