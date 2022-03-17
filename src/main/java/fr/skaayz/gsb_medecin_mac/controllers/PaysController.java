package fr.skaayz.gsb_medecin_mac.controllers;

import fr.skaayz.gsb_medecin_mac.models.Pays;
import fr.skaayz.gsb_medecin_mac.models.PaysAccess;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.util.ResourceBundle;

public class PaysController implements Initializable {
    @FXML
    public TableView<Pays> tableView;

    @FXML
    public TableColumn<Pays, Integer> id;

    @FXML
    public TableColumn<Pays, String> libelle;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        id.setCellValueFactory(new PropertyValueFactory<>("id"));
        libelle.setCellValueFactory(new PropertyValueFactory<>("libelle"));

        tableView.refresh();
        tableView.getItems().addAll(PaysAccess.getAll());
        tableView.setPlaceholder(new Label("Pays non chargés."));
    }
}