package fr.skaayz.gsb_medecin_mac.controllers;
import fr.skaayz.gsb_medecin_mac.models.Medecin;
import fr.skaayz.gsb_medecin_mac.models.MedecinAccess;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.util.ResourceBundle;

public class MedecinController implements Initializable {
    @FXML
    public TableView<Medecin> medicTableView;

    @FXML
    public TableColumn<Medecin, Integer> id, department;

    @FXML
    public TableColumn<Medecin, String> lastname, firstname, phone, address, speciality;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        id.setCellValueFactory(new PropertyValueFactory<>("id"));
        lastname.setCellValueFactory(new PropertyValueFactory<>("nom"));
        firstname.setCellValueFactory(new PropertyValueFactory<>("prenom"));
        //address.setCellValueFactory(new PropertyValueFactory<>("adresse"));
        //phone.setCellValueFactory(new PropertyValueFactory<>("tel"));
        speciality.setCellValueFactory(new PropertyValueFactory<>("specialite"));
        department.setCellValueFactory(new PropertyValueFactory<>("departement_id"));

        medicTableView.refresh();
        medicTableView.getItems().addAll(MedecinAccess.getAll());
        medicTableView.setPlaceholder(new Label("Médecins non chargés."));

        //System.out.println(MedicAccess.getAll());
    }
}
