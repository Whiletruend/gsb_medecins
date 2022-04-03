package fr.skaayz.gsb_medecin_mac.controllers.medecins;

import fr.skaayz.gsb_medecin_mac.MainController;
import fr.skaayz.gsb_medecin_mac.models.*;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.stage.Stage;

import java.net.URL;
import java.util.Objects;
import java.util.ResourceBundle;

public class EditController implements Initializable {
    // Variables
    private static Medecin medecinActuel = null;

    // Regular Functions
    public static void setMedecinActuel(Medecin nouveauMedecin) {
        medecinActuel = nouveauMedecin;
    }

    public static Medecin getMedecinActuel() {
        return medecinActuel;
    }

    // FXML Functions
    @FXML
    private TextField medic_textfield_id;

    @FXML
    private TextField medic_textfield_firstname; // Nom

    @FXML
    private TextField medic_textfield_lastname; // Prénom

    @FXML
    private TextField medic_textfield_address;

    @FXML
    private TextField medic_textfield_phone;

    @FXML
    private ComboBox<String> medic_choice_speciality;

    @FXML
    private ComboBox<String> medic_choice_department;

    @FXML
    private Button medic_close_button;

    @FXML
    private void closeButtonClicked() {
        Stage stage = (Stage) medic_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void deleteButtonClicked() {
        Alert alert = new Alert(Alert.AlertType.NONE, "Êtes-vous sûr de supprimer le médecin " + getMedecinActuel().getNom() + " " + getMedecinActuel().getPrenom(), ButtonType.YES, ButtonType.NO);
        alert.showAndWait();

        if (alert.getResult() == ButtonType.YES) {
            MedecinAccess.deleteMedicByID(getMedecinActuel().getId());
            closeButtonClicked();
        }
    }

    @FXML
    private void validateButtonClicked() {
        if( (!Objects.equals(medic_textfield_firstname.getText(), getMedecinActuel().getNom())) || (!Objects.equals(medic_textfield_lastname.getText(), getMedecinActuel().getPrenom())) || (!Objects.equals(medic_textfield_address.getText(), getMedecinActuel().getAdresse())) || (!Objects.equals(medic_textfield_phone.getText(), getMedecinActuel().getTel())) || (!Objects.equals(medic_choice_speciality.getValue(), getMedecinActuel().getSpecialite_id())) || (!Objects.equals(medic_choice_speciality.getValue(), Integer.toString(getMedecinActuel().getDepartement_id())))) {
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
                Alert alert = new Alert(Alert.AlertType.NONE, "Le numéro de téléphone doit comporter seulement des chiffres", ButtonType.OK);
                alert.showAndWait();

                return;
            }

            // Create infos table
            String[] new_informations = new String[7];

            // Add infos
            new_informations[0] = medic_textfield_id.getText();
            new_informations[1] = medic_textfield_firstname.getText();
            new_informations[2] = medic_textfield_lastname.getText();
            new_informations[3] = medic_textfield_address.getText();
            new_informations[4] = medic_textfield_phone.getText();
            new_informations[5] = String.valueOf(medic_choice_speciality.getValue());
            new_informations[6] = String.valueOf(medic_choice_department.getValue());

            // Send & update
            MedecinAccess.updateMedicByID(getMedecinActuel().getId(), new_informations);

            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Les valeurs du médecin " + getMedecinActuel().getNom() + " " + getMedecinActuel().getPrenom() + " ont bien étés modifiées.", ButtonType.OK);
            alert.showAndWait();
        }

        // Close stage & update tableview
        closeButtonClicked();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Variables
        ObservableList<Specialite> specialite_List = SpecialiteAccess.getAll();
        ObservableList<Departement> departement_List = DepartementAccess.getAll();

        // Setup
        for (Specialite spe : specialite_List) {
            medic_choice_speciality.getItems().add(spe.getLibelle());
        }

        for (Departement dpt : departement_List) {
            medic_choice_department.getItems().add(dpt.getLibelle());
        }

        medic_textfield_id.setText(Integer.toString(getMedecinActuel().getId()));
        medic_textfield_firstname.setText(getMedecinActuel().getNom());
        medic_textfield_lastname.setText(getMedecinActuel().getPrenom());
        medic_textfield_address.setText(getMedecinActuel().getAdresse());
        medic_textfield_phone.setText(getMedecinActuel().getTel());
        medic_choice_speciality.setValue(SpecialiteAccess.getLibelleByID(getMedecinActuel().getSpecialite_id()));
        medic_choice_department.setValue(DepartementAccess.getLibelleByID(getMedecinActuel().getDepartement_id()));
    }
}
