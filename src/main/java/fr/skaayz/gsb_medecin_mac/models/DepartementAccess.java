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

    public static Departement getDepartementByID(int id) {
        Departement departement = null;

        try {
            ResultSet request = Database.query("SELECT * FROM departement WHERE id = " + id + ";");

            if (request.next()) {
                departement = new Departement(
                        request.getInt("id"),
                        request.getString("libelle"),
                        request.getInt("pays_id")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return departement;
    }

    public static Departement getDepartementByLibelle(String libelle) {
        Departement departement = null;

        try {
            ResultSet request = Database.query("SELECT * FROM departement WHERE libelle = '" + libelle + "';");

            if (request.next()) {
                departement = new Departement(
                        request.getInt("id"),
                        request.getString("libelle"),
                        request.getInt("pays_id")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return departement;
    }

    public static String getLibelleByID(int id) {
        Departement departement = null;

        try {
            ResultSet request = Database.query("SELECT * FROM departement WHERE id = " + id + ";");

            if(request.next()) {
                departement = new Departement(
                        request.getInt("id"),
                        request.getString("libelle"),
                        request.getInt("pays_id")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        assert departement != null;
        return departement.getLibelle();
    }

    public static void updateDepartmentByID(int id, String[] table) {
        Pays depart_country = PaysAccess.getCountryByLibelle(table[2]);

        try {
            Database.execute(
        "UPDATE departement " +
                "SET libelle = '" + table[1] + "', " +
                "pays_id = '" + depart_country.getId() + "' " +
                "WHERE id = " + id + ";"
            );
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteDepartmentByID(int id) {
        try {
            Database.execute("DELETE FROM departement WHERE id = " + id + ";");
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static ObservableList<Departement> getByLike(String search) {
        ObservableList<Departement> departements_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query(
                    "SELECT * FROM departement " +
                            "WHERE libelle LIKE '%" + search + "%';"
            );

            while(request.next()) {
                departements_List.addAll(
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

        return departements_List;
    }

    public static void createDepart(String[] table) {
        try {
            Database.execute(
                    "INSERT INTO departement(libelle, pays_id) VALUES(" +
                            "'" + table[0] + "'," +
                            "'" + table[1] + "');"
            );
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
