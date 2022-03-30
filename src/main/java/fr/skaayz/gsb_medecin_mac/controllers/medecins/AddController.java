package fr.skaayz.gsb_medecin_mac.controllers.medecins;

import fr.skaayz.gsb_medecin_mac.models.*;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.Stage;

import java.net.URL;
import java.util.ResourceBundle;

public class AddController implements Initializable {
    @FXML
    private TextField medic_textfield_firstname; // Nom

    @FXML
    private TextField medic_textfield_lastname; // Prénom

    @FXML
    private TextField medic_textfield_address;

    @FXML
    private TextField medic_textfield_phone;

    @FXML
    private ComboBox<Specialite> medic_choice_speciality;

    @FXML
    private ComboBox<Departement> medic_choice_department;

    @FXML
    private Button medic_close_button;

    @FXML
    private void closeButtonClicked() {
        Stage stage = (Stage) medic_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void validateButtonClicked() {
        // Create infos table
        String[] medic_informations = new String[6];

        // Add infos
        medic_informations[0] = medic_textfield_firstname.getText();
        medic_informations[1] = medic_textfield_lastname.getText();
        medic_informations[2] = medic_textfield_address.getText();
        medic_informations[3] = medic_textfield_phone.getText();
       // medic_informations[4] = medic_choice_speciality.getText();
       // medic_informations[5] = medic_choice_department.getText();

        // Send & update
        MedecinAccess.createMedic(medic_informations);

        // Show popup
        Alert alert = new Alert(Alert.AlertType.NONE, "Le médecin " + medic_textfield_firstname.getText() + " " + medic_textfield_lastname.getText() + " a bien été créé.", ButtonType.OK);
        alert.showAndWait();
    }

    private void setupComboBox() {

    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Variables
        ObservableList<Specialite> specialite_List = SpecialiteAccess.getAll();

        // Setup
        medic_choice_speciality.getItems().addAll(specialite_List);
    }
}
