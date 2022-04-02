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
            String username = encryptToSHA512(connect_username.getText(), "sb?7^.i7}X3*aKE*2^7D^#fEqW>58s|y9b3#Q2F5+Y25+8AE2b5Ty:5N85>fE(hR~8>eR@j836WEzh#;:S2/bZmXG89i.6|pu@5:2-T/)8~:>XCsnB9c-Tn9x.TpgR96b-5]7G-H)8KdD3i84Y6sSBT~u5~FLq]jJ4,=<;4cR77dBmN6;s^W4Zse5|mBN;5B8e55UkTupf}3&Htf?QM5Pd7E5p@S(k3ST7c~ffTc34~yE5uQ935T47w-j:LDKX>]E728Nrv84,)$4v2T93k7F]w9HLzfra|WW=,Z8J4|F6=iE}zyh[LKqn4}@rD26u#4)2dENv;9KEFW>Us9E*XjC4+2[/ZA$}q7usKu|b7t?E#(jh_zL3Dr4xXY)s&D5HRVAq2jZ89jEgj3B6]PH+Xs?7}3HwX@!:8>Vf?}S)3:86)DkdbS<7e7ZWd8w@p5-Y7ctV5?8g(yYr9;a:[3*gV>{uT34{6%8f_55wU~+ic_8p2q3g=6L~88=u?8aCar%=AY");
            String password = encryptToSHA512(connect_password.getText(), "Lk22LrsTu9h?:{2dG%cCWK?.@6@+JC35Q_|r:5AM434;,=b6UDY3T,3<nyHedUJPN$P)>Em>qL2.HxZ2c692!3|h6^&TYT|VU62M.zz2GR7heW?3QEs+h<{LXL<b$#[3R44-muQA842)t.We2.37~jp<>iN28R4j%4Tw7R#7LN8j+5ic5z_P83864?ez52i(bvS/@T5!5%83!9jbwWs88:JjS3}vb~@j7tuz7xj=bL9aBLZp42?S5*@:j^9(3|Ch3p~qetWx8m=ubc~3^#A@]eXrS2Lt4ZB,)%v!C7a>>N/254(P?wKKD5%gF*=+5[(pN8e9|SSDR@@M4|E52X8(zG3Vpd6,/53~7crd3Ft*;~!95q5J24J:J2TT3s9ixNR+#Nu7~)4=hb=fxbk{uWnT4eMN9z%9596xWaP@Ww7wP5GtJLvMJnxj83#6YE8NDSPJF*]_9fZ3cHY<8_/:5,Yb9Ez8x3vU{tBz[:#8weDT75v|6v4Yin^a976s7EYg;:_j");

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
