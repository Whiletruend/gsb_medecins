package fr.skaayz.gsb_medecin_mac.controllers;

import fr.skaayz.gsb_medecin_mac.models.Departement;
import fr.skaayz.gsb_medecin_mac.models.DepartementAccess;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.util.ResourceBundle;

public class DepartementController implements Initializable {
    @FXML
    public TableView<Departement> tableView;

    @FXML
    public TableColumn<Departement, Integer> id, pays_id;

    @FXML
    public TableColumn<Departement, String> libelle;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        id.setCellValueFactory(new PropertyValueFactory<>("id"));
        libelle.setCellValueFactory(new PropertyValueFactory<>("libelle"));
        pays_id.setCellValueFactory(new PropertyValueFactory<>("pays_id"));

        tableView.refresh();
        tableView.getItems().addAll(DepartementAccess.getAll());
        tableView.setPlaceholder(new Label("Départements non chargés."));
    }
}