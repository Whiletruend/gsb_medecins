package fr.skaayz.gsb_medecin_mac.controllers.departements;

import fr.skaayz.gsb_medecin_mac.MainController;
import fr.skaayz.gsb_medecin_mac.models.*;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.Stage;
import javafx.util.StringConverter;

import java.net.URL;
import java.util.ResourceBundle;

public class AddController implements Initializable {
    // Variables
    private static Integer valuePays = 0;

    // FXML Variables
    @FXML
    private TextField depart_textfield_libelle;

    @FXML
    private ComboBox<Pays> depart_choice_country;

    @FXML
    private Button depart_close_button;

    @FXML
    private void closeButtonClicked() {
        Stage stage = (Stage) depart_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void validateButtonClicked() {
        if(depart_textfield_libelle.getText().trim().isEmpty() || depart_choice_country.getValue() == null) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Tous les champs doivent être remplis.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if( (depart_textfield_libelle.getText()).matches(".*\\d.*") ) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Le libellé d'un département ne peut être numérique.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        // Create infos table
        String[] depart_informations = new String[2];

        // Add infos
        depart_informations[0] = depart_textfield_libelle.getText();
        depart_informations[1] = String.valueOf(valuePays);

        // Send & update
        DepartementAccess.createDepart(depart_informations);

        // Show popup
        Alert alert = new Alert(Alert.AlertType.NONE, "Le département " + depart_textfield_libelle.getText() + " a bien été créé.", ButtonType.OK);
        alert.showAndWait();

        // Close
        closeButtonClicked();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Variables
        ObservableList<Pays> pays_List = PaysAccess.getAll();

        // Setup
        depart_choice_country.getItems().addAll(pays_List);

        // Set converter Speciality
        depart_choice_country.setConverter(new StringConverter<>() {
            @Override
            public String toString(Pays object) {
                return object.getLibelle();
            }

            @Override
            public Pays fromString(String string) {
                return depart_choice_country.getItems().stream().filter(ap -> ap.getLibelle().equals(string)).findFirst().orElse(null);
            }
        });
        depart_choice_country.valueProperty().addListener((obs, oldval, newval) -> {
            if (newval != null) {
                valuePays = newval.getId();
            }
        });
    }
}
