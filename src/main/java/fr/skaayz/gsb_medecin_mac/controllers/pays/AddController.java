package fr.skaayz.gsb_medecin_mac.controllers.pays;

import fr.skaayz.gsb_medecin_mac.models.PaysAccess;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.net.URL;
import java.util.ResourceBundle;

public class AddController implements Initializable {
    // FXML Variables
    @FXML
    private TextField country_textfield_libelle;

    @FXML
    private Button country_close_button;

    @FXML
    private void closeButtonClicked() {
        Stage stage = (Stage) country_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void validateButtonClicked() {
        if(country_textfield_libelle.getText().trim().isEmpty()) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Tous les champs doivent être remplis.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if( (country_textfield_libelle.getText()).matches("[a-zA-Z\\s]{2,45}") ) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Le libellé d'un pays doit comporter entre 2 et 45 caractères et ne peut contenir des valeurs numériques.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if(PaysAccess.getCountryByLibelle(country_textfield_libelle.getText()) != null) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Ce pays existe déjà.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        // Create infos table
        String[] country_informations = new String[1];

        // Add infos
        country_informations[0] = country_textfield_libelle.getText();

        // Send & update
        PaysAccess.createCountry(country_informations);

        // Show popup
        Alert alert = new Alert(Alert.AlertType.NONE, "Le pays " + country_textfield_libelle.getText() + " a bien été créé.", ButtonType.OK);
        alert.showAndWait();

        // Close
        closeButtonClicked();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
    }
}
