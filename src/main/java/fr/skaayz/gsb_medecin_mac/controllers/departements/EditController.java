package fr.skaayz.gsb_medecin_mac.controllers.departements;

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
    private static Departement departementActuel = null;

    // Regular Functions
    public static void setDepartementActuel(Departement nouveauDepartement) {
        departementActuel = nouveauDepartement;
    }

    public static Departement getDepartementActuel() {
        return departementActuel;
    }

    // FXML Variables
    @FXML
    private Button depart_close_button;

    @FXML
    private TextField depart_textfield_id;

    @FXML
    private TextField depart_textfield_libelle; // Nom

    @FXML
    private ComboBox<String> depart_choice_country;

    // FXML Functions
    @FXML
    private void closeButtonClicked() {
        Stage stage = (Stage) depart_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void deleteButtonClicked() {
        Alert alert = new Alert(Alert.AlertType.NONE, "Êtes-vous sûr de supprimer le département " + getDepartementActuel().getLibelle(), ButtonType.YES, ButtonType.NO);
        alert.showAndWait();

        if (alert.getResult() == ButtonType.YES) {
            DepartementAccess.deleteDepartmentByID(getDepartementActuel().getId());
            closeButtonClicked();
        }
    }

    @FXML
    private void validateButtonClicked() {
        if(!Objects.equals(depart_textfield_libelle.getText(), getDepartementActuel().getLibelle()) || !Objects.equals(depart_choice_country.getValue(), PaysAccess.getLibelleByID(getDepartementActuel().getPays_id()))) {
            if(depart_textfield_libelle.getText().trim().isEmpty()) {
                // Show popup
                Alert alert = new Alert(Alert.AlertType.NONE, "Tous les champs doivent être remplis.", ButtonType.OK);
                alert.showAndWait();

                return;
            }

            if( (depart_textfield_libelle.getText()).matches(".[a-zA-Z\s]{2,45}") ) {
                // Show popup
                Alert alert = new Alert(Alert.AlertType.NONE, "Le libellé d'un département doit comporter entre 2 et 45 caractères et ne peut contenir des valeurs numériques.", ButtonType.OK);
                alert.showAndWait();

                return;
            }

            if(DepartementAccess.getDepartByLibelle(depart_textfield_libelle.getText()) != null) {
                // Show popup
                Alert alert = new Alert(Alert.AlertType.NONE, "Ce département existe déjà.", ButtonType.OK);
                alert.showAndWait();

                return;
            }

            // Create infos table
            String[] new_informations = new String[3];

            // Add infos
            new_informations[0] = depart_textfield_id.getText();
            new_informations[1] = depart_textfield_libelle.getText();
            new_informations[2] = String.valueOf(depart_choice_country.getValue());

            // Send & update
            DepartementAccess.updateDepartmentByID(getDepartementActuel().getId(), new_informations);

            // Show popup
            Alert alert = new Alert(Alert.AlertType.NONE, "Les valeurs du département " + getDepartementActuel().getLibelle() + " ont bien étés modifiées.", ButtonType.OK);
            alert.showAndWait();
        }

        // Close stage & update tableview
        closeButtonClicked();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Variables
        ObservableList<Pays> pays_List = PaysAccess.getAll();

        // Setup
        for (Pays pays : pays_List) {
            depart_choice_country.getItems().add(pays.getLibelle());
        }

        depart_textfield_id.setText(Integer.toString(getDepartementActuel().getId()));
        depart_textfield_libelle.setText(getDepartementActuel().getLibelle());
        depart_choice_country.setValue(PaysAccess.getLibelleByID(getDepartementActuel().getPays_id()));
    }
}
