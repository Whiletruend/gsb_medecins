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
    public TableView<Medecin> tableView;

    @FXML
    public TableColumn<Medecin, Integer> id, departement_id;

    @FXML
    //public TableColumn<Medecin, String> lastname, firstname, phone, address, speciality;
    public TableColumn<Medecin, String> nom, prenom, specialite;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        id.setCellValueFactory(new PropertyValueFactory<>("id"));
        nom.setCellValueFactory(new PropertyValueFactory<>("nom"));
        prenom.setCellValueFactory(new PropertyValueFactory<>("prenom"));
        //address.setCellValueFactory(new PropertyValueFactory<>("adresse"));
        //phone.setCellValueFactory(new PropertyValueFactory<>("tel"));
        specialite.setCellValueFactory(new PropertyValueFactory<>("specialite"));
        departement_id.setCellValueFactory(new PropertyValueFactory<>("departement_id"));

        tableView.refresh();
        tableView.getItems().addAll(MedecinAccess.getAll());
        tableView.setPlaceholder(new Label("Médecins non chargés."));
    }
}