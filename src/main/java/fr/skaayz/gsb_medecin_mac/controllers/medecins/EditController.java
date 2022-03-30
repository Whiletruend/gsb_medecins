package fr.skaayz.gsb_medecin_mac.controllers.medecins;

import fr.skaayz.gsb_medecin_mac.models.Medecin;
import fr.skaayz.gsb_medecin_mac.models.MedecinAccess;
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
    private TextField medic_textfield_speciality;

    @FXML
    private TextField medic_textfield_department;

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

        // Update tableview
        //MedecinController.getInstance().setupTableView(MedecinAccess.getAll());
    }

    @FXML
    private void validateButtonClicked() {
        if( (!Objects.equals(medic_textfield_firstname.getText(), getMedecinActuel().getNom())) || (!Objects.equals(medic_textfield_lastname.getText(), getMedecinActuel().getPrenom())) || (!Objects.equals(medic_textfield_address.getText(), getMedecinActuel().getAdresse())) || (!Objects.equals(medic_textfield_phone.getText(), getMedecinActuel().getTel())) || (!Objects.equals(medic_textfield_speciality.getText(), getMedecinActuel().getSpecialite())) || (!Objects.equals(medic_textfield_department.getText(), Integer.toString(getMedecinActuel().getDepartement_id())))) {
            // Create infos table
            String[] new_informations = new String[7];

            // Add infos
            new_informations[0] = medic_textfield_id.getText();
            new_informations[1] = medic_textfield_firstname.getText();
            new_informations[2] = medic_textfield_lastname.getText();
            new_informations[3] = medic_textfield_address.getText();
            new_informations[4] = medic_textfield_phone.getText();
            new_informations[5] = medic_textfield_speciality.getText();
            new_informations[6] = medic_textfield_department.getText();

            // Send & update
            MedecinAccess.updateMedicByID(getMedecinActuel().getId(), new_informations);

            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Les valeurs du médecin " + getMedecinActuel().getNom() + " " + getMedecinActuel().getPrenom() + " ont bien étés modifiées.", ButtonType.OK);
            alert.showAndWait();

            // Reload TableView
           // MedecinController.reload(MedecinAccess.getAll());
        }

        // Close stage & update tableview
        closeButtonClicked();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        medic_textfield_id.setText(Integer.toString(getMedecinActuel().getId()));
        medic_textfield_firstname.setText(getMedecinActuel().getNom());
        medic_textfield_lastname.setText(getMedecinActuel().getPrenom());
        medic_textfield_address.setText(getMedecinActuel().getAdresse());
        medic_textfield_phone.setText(getMedecinActuel().getTel());
        medic_textfield_speciality.setText(getMedecinActuel().getSpecialite());
        medic_textfield_department.setText(Integer.toString(getMedecinActuel().getDepartement_id()));
    }
}
