package fr.skaayz.gsb_medecin_mac.controllers;

import fr.skaayz.gsb_medecin_mac.MainController;
import fr.skaayz.gsb_medecin_mac.models.Utilisateur;
import fr.skaayz.gsb_medecin_mac.models.UtilisateurAccess;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UtilisateurController {
    @FXML
    private TextField connect_username;

    @FXML
    private PasswordField connect_password;

    @FXML
    private javafx.scene.control.Button main_close_button;

    @FXML
    private Label connect_Infos;

    // FXML Functions
    @FXML
    private void connectButtonClicked(ActionEvent event) throws IOException {
        if(connect_username.getText().trim().isEmpty() || connect_password.getText().trim().isEmpty()) {
            connect_Infos.setLayoutX(45);
            connect_Infos.setText("Tous les champs doivent être complétés");
        } else {
            String username = connect_username.getText();
            String password = encryptToSHA512(connect_password.getText(), "gsb_medecins");

            Utilisateur user = UtilisateurAccess.getUtilisateur(username, password);

            if(user == null) {
                connect_Infos.setLayoutX(29);
                connect_Infos.setText("Nom d'utilisateur ou mot de passe incorrect");
            } else {
                MainController.changePage("views/app-view.fxml", event);
                MainController.setIsOnSoftware(true);
            }
        }
    }

    @FXML
    private void connectBackButtonClicked(ActionEvent event) throws IOException {
        MainController.changePage("views/main-view.fxml", event);
    }

    @FXML
    private void closeButtonClicked(){
        Stage stage = (Stage) main_close_button.getScene().getWindow();
        stage.close();
    }

    // Regular Functions
    public String encryptToSHA512(String passwordToHash, String salt){
        String generatedPassword = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(salt.getBytes(StandardCharsets.UTF_8));
            byte[] bytes = md.digest(passwordToHash.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte aByte : bytes) {
                sb.append(Integer.toString((aByte & 0xff) + 0x100, 16).substring(1));
            }
            generatedPassword = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return generatedPassword;
    }
}
