package fr.skaayz.gsb_medecin_mac.models;

public class Utilisateur {
    // Variables
    private int id;
    private static String username = "";
    private static String password = "";

    // Constructor
    public Utilisateur(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    // Functions
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isConnected() {
        if(getUsername().trim().isEmpty() || getPassword().trim().isEmpty()) {
            return false;
        } else {
            return true;
        }
    }
}
