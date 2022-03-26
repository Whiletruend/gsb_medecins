package fr.skaayz.gsb_medecin_mac.models;

import java.sql.*;

public class Database {
    // Variables
    private static Connection conn_db = null;

    private static final String host_db = "127.0.0.1";
    private static final String name_db = "gsb_medecins";
    private static final String user_db = "root";
    private static final String pass_db = "";

    private static final String link_db = "jdbc:mysql://" + host_db + "/" + name_db;

    // Functions
    private static Connection getConnection() {
        try {
            conn_db = DriverManager.getConnection(link_db, user_db, pass_db);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return conn_db;
    }

    protected static ResultSet query(String request) throws SQLException {
        Connection connect_db = getConnection();
        ResultSet queryOutput;

        Statement statement = connect_db.createStatement();
        queryOutput = statement.executeQuery(request);

        return queryOutput;
    }
}
