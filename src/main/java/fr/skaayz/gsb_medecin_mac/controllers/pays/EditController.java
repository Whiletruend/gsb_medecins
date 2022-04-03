package fr.skaayz.gsb_medecin_mac.controllers.pays;

import fr.skaayz.gsb_medecin_mac.MainController;
import fr.skaayz.gsb_medecin_mac.models.Pays;
import fr.skaayz.gsb_medecin_mac.models.PaysAccess;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.net.URL;
import java.util.Objects;
import java.util.ResourceBundle;

public class EditController implements Initializable {
    // Variables
    private static Pays paysActuel = null;

    // Regular Functions
    public static void setPaysActuel(Pays nouveauPays) {
        paysActuel = nouveauPays;
    }

    public static Pays getPaysActuel() {
        return paysActuel;
    }

    // FXML Functions
    @FXML
    private TextField country_textfield_id;

    @FXML
    private TextField country_textfield_libelle;

    @FXML
    private Button country_close_button;

    // FXML Functions
    @FXML
    private void closeButtonClicked() {
        Stage stage = (Stage) country_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void deleteButtonClicked() {
        Alert alert = new Alert(Alert.AlertType.NONE, "Êtes-vous sûr de supprimer le pays " + getPaysActuel().getLibelle(), ButtonType.YES, ButtonType.NO);
        alert.showAndWait();

        if (alert.getResult() == ButtonType.YES) {
            PaysAccess.deleteCountryByID(getPaysActuel().getId());
            closeButtonClicked();
        }
    }

    @FXML
    private void validateButtonClicked() {
        if(Objects.equals(country_textfield_libelle.getText(), getPaysActuel().getLibelle())) { closeButtonClicked(); return; }
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
        String[] new_informations = new String[2];

        // Add infos
        new_informations[0] = country_textfield_id.getText();
        new_informations[1] = country_textfield_libelle.getText();

        // Send & update
        PaysAccess.updateCountryByID(getPaysActuel().getId(), new_informations);

        // Show popup
        Alert alert = new Alert(Alert.AlertType.NONE, "Les valeurs du pays " + getPaysActuel().getLibelle() + " ont bien étés modifiées.", ButtonType.OK);
        alert.showAndWait();

        // Close
        closeButtonClicked();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        country_textfield_id.setText(String.valueOf(getPaysActuel().getId()));
        country_textfield_libelle.setText(getPaysActuel().getLibelle());
    }
}
