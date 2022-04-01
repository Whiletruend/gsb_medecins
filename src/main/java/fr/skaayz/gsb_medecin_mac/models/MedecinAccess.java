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
                        request.getInt("specialite_id"),
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

            if(request.next()) {
                medecin = new Medecin(
                    request.getInt("id"),
                    request.getString("nom"),
                    request.getString("prenom"),
                    request.getString("adresse"),
                    request.getString("tel"),
                    request.getInt("specialite_id"),
                    request.getInt("departement_id")
                );
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return medecin;
    }

    public static ObservableList<Medecin> getByLike(String search) {
        ObservableList<Medecin> medecins_List = FXCollections.observableArrayList();

        try {
            ResultSet request = Database.query(
        "SELECT * FROM medecin AS M " +
                "JOIN specialite_complementaire sc on M.specialite_id = sc.id " +
                "WHERE M.nom LIKE '%" + search + "%' OR M.prenom LIKE '%" + search + "%' OR sc.libelle LIKE '%" + search + "%';"
            );

            while(request.next()) {
                medecins_List.addAll(
                        new Medecin(
                            request.getInt("id"),
                            request.getString("nom"),
                            request.getString("prenom"),
                            request.getString("adresse"),
                            request.getString("tel"),
                            request.getInt("specialite_id"),
                            request.getInt("departement_id")
                        )
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return medecins_List;
    }

    public static void deleteMedicByID(int id) {
        try {
            Database.execute("DELETE FROM medecin WHERE id = " + id + ";");
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateMedicByID(int id, String[] table) {
        Specialite medic_speciality = SpecialiteAccess.getSpecialityByLibelle(table[5]);
        Departement medic_department = DepartementAccess.getDepartementByLibelle(table[6]);

        try {
            Database.execute(
        "UPDATE medecin " +
                "SET nom = '" + table[1] + "', " +
                "prenom = '" + table[2] + "', " +
                "adresse = '" + table[3] + "', " +
                "tel = '" + table[4] + "', " +
                "specialite_id = '" + medic_speciality.getId() + "', " +
                "departement_id = " + medic_department.getId() + " " +
                "WHERE id = " + id + ";"
            );
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public static void createMedic(String[] table) {
        try {
            Database.execute(
        "INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id) VALUES(" +
                "'" + table[0] + "'," +
                "'" + table[1] + "'," +
                "'" + table[2] + "'," +
                "'" + table[3] + "'," +
                "'" + table[4] + "'," +
                "'" + table[5] + "');"
            );
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
}