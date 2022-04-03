package fr.skaayz.gsb_medecin_mac.controllers.medecins;

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
    private static Integer valueSpecialite = 0;
    private static Integer valueDepartement = 0;

    // FXML Variables
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
        if(medic_textfield_firstname.getText().trim().isEmpty() || medic_textfield_lastname.getText().trim().isEmpty() || medic_textfield_address.getText().trim().isEmpty() || medic_textfield_phone.getText().trim().isEmpty()) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Tous les champs doivent être remplis.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if(!medic_textfield_firstname.getText().matches("[a-zA-Z\\sàâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ-]{2,30}")) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Le nom d'un médecin doit comporter entre 2 et 30 caractères et ne peut contenir seulement des lettres.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if(!medic_textfield_lastname.getText().matches("[a-zA-Z\\sàâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ-]{2,30}")) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Le prénom d'un médecin doit comporter entre 2 et 30 caractères et ne peut contenir seulement des lettres.", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if(!MainController.isNumeric(medic_textfield_phone.getText())) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Le numéro de téléphone doit comporter des chiffres", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if(medic_choice_speciality.getValue() == null) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Veuillez choisir une spécialité pour le médecin", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        if(medic_choice_department.getValue() == null) {
            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Veuillez choisir un département pour le médecin", ButtonType.OK);
            alert.showAndWait();

            return;
        }

        // Create infos table
        String[] medic_informations = new String[6];

        // Add infos
        medic_informations[0] = medic_textfield_firstname.getText();
        medic_informations[1] = medic_textfield_lastname.getText();
        medic_informations[2] = medic_textfield_address.getText();
        medic_informations[3] = medic_textfield_phone.getText();
        medic_informations[4] = String.valueOf(valueSpecialite);
        medic_informations[5] = String.valueOf(valueDepartement);

        // Send & update
        MedecinAccess.createMedic(medic_informations);

        // Show popup
        Alert alert = new Alert(Alert.AlertType.NONE, "Le médecin " + medic_textfield_firstname.getText() + " " + medic_textfield_lastname.getText() + " a bien été créé.", ButtonType.OK);
        alert.showAndWait();

        // Close
        closeButtonClicked();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Variables
        ObservableList<Specialite> specialite_List = SpecialiteAccess.getAll();
        ObservableList<Departement> departement_List = DepartementAccess.getAll();

        // Setup
        medic_choice_speciality.getItems().addAll(specialite_List);
        medic_choice_department.getItems().addAll(departement_List);

        // Set converter Speciality
        medic_choice_speciality.setConverter(new StringConverter<>() {
            @Override
            public String toString(Specialite object) {
                return object.getLibelle();
            }

            @Override
            public Specialite fromString(String string) {
                return medic_choice_speciality.getItems().stream().filter(ap -> ap.getLibelle().equals(string)).findFirst().orElse(null);
            }
        });
        medic_choice_speciality.valueProperty().addListener((obs, oldval, newval) -> {
            if (newval != null) {
                valueSpecialite = newval.getId();
            }
        });

        // Set converter Departement
        medic_choice_department.setConverter(new StringConverter<>() {
            @Override
            public String toString(Departement object) {
                return object.getLibelle();
            }

            @Override
            public Departement fromString(String string) {
                return medic_choice_department.getItems().stream().filter(ap -> ap.getLibelle().equals(string)).findFirst().orElse(null);
            }
        });
        medic_choice_department.valueProperty().addListener((obs, oldval, newval) -> {
            if (newval != null) {
                valueDepartement = newval.getId();
            }
        });
    }
}
