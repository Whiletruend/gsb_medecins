package fr.skaayz.gsb_medecin_mac.controllers;

import fr.skaayz.gsb_medecin_mac.MainController;
import fr.skaayz.gsb_medecin_mac.controllers.medecins.EditController;
import fr.skaayz.gsb_medecin_mac.models.*;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Cursor;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class MedecinController implements Initializable {
    // Regular variables

    // FXML variables
    @FXML
    private TextField search_textbar;

    @FXML
    private Button add_button;

    @FXML
    public TableView<Medecin> tableView;

    @FXML
    public TableColumn<Medecin, Integer> id;

    @FXML
    public TableColumn<Medecin, String> nom, prenom, adresse, tel, departement, specialite;

    @FXML
    public TableColumn<Medecin, String> action;

    // FXML Functions
    @FXML
    private void searchButtonClicked() {
        setupTableView(MedecinAccess.getByLike(search_textbar.getText()));
    }

    @FXML
    private void addButtonClicked() {
        // Create new stage
        Stage stage = new Stage();
        Pane scene_window = null;
        FXMLLoader loader = new FXMLLoader(getClass().getClassLoader().getResource("fr/skaayz/gsb_medecin_mac/views/tabs/popups/adds/medic-view.fxml"));

        try {
            scene_window = loader.load();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Set Scene
        assert scene_window != null; // scene_window might be null, so assert
        Scene scene = new Scene(scene_window);
        stage.setScene(scene);

        MainController.setupFrame(stage, scene, scene_window, true);

        stage.show();
    }

    // Regular functions
    private void setupTableView(ObservableList<Medecin> medecins_list) {
        tableView.getItems().clear();
        tableView.refresh();

        id.setCellValueFactory(new PropertyValueFactory<>("id"));
        nom.setCellValueFactory(new PropertyValueFactory<>("nom"));
        prenom.setCellValueFactory(new PropertyValueFactory<>("prenom"));

        adresse.setCellValueFactory(new PropertyValueFactory<>("adresse"));
        tel.setCellValueFactory(new PropertyValueFactory<>("tel"));

        if (!Utilisateur.isConnected()) {
            adresse.setVisible(false);
            tel.setVisible(false);
            action.setVisible(false);

            add_button.setVisible(false);
            search_textbar.setLayoutX(-1);
            search_textbar.setPrefWidth(710);
        }

        specialite.setCellValueFactory(c-> new SimpleStringProperty(SpecialiteAccess.getLibelleByID(c.getValue().getSpecialite_id())));
        departement.setCellValueFactory(c-> new SimpleStringProperty(DepartementAccess.getLibelleByID(c.getValue().getDepartement_id())));

        // Remove tabs without errors
        id.setVisible(false);

        // Create buttons for every rows
        Callback<TableColumn<Medecin, String>, TableCell<Medecin, String>> cellFactory = (param) -> new TableCell<>() {
            @Override
            public void updateItem(String item, boolean empty) {
                super.updateItem(item, empty);

                if (empty) {
                    setGraphic(null);
                    setText(null);
                } else {
                    final Button soft_view_button = new Button("Voir");
                    soft_view_button.getStyleClass().add("button-blue");
                    soft_view_button.setCursor(Cursor.HAND);

                    soft_view_button.setOnAction(event -> {
                        Medecin medecinClicked = getTableView().getItems().get(getIndex());
                        EditController.setMedecinActuel(medecinClicked); // Set the actual medecin

                        // Create new stage
                        Stage stage = new Stage();
                        Pane scene_window = null;
                        FXMLLoader loader = new FXMLLoader(getClass().getClassLoader().getResource("fr/skaayz/gsb_medecin_mac/views/tabs/popups/infos/medic-view.fxml"));

                        try {
                            scene_window = loader.load();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                        // Set Scene
                        assert scene_window != null; // scene_window might be null, so assert
                        Scene scene = new Scene(scene_window);
                        stage.setScene(scene);

                        MainController.setupFrame(stage, scene, scene_window, true);

                        stage.show();
                    });

                    setGraphic(soft_view_button);
                    setText(null);
                }
            }
        };

        // Attribute buttons to the column
        action.setCellFactory(cellFactory);

        // Reload
        reload(medecins_list);
        tableView.setPlaceholder(new Label("Médecin(s) non trouvé(s)."));
    }

    private void reload(ObservableList<Medecin> medecins_list) {
        tableView.getItems().clear();
        tableView.refresh();
        tableView.getItems().addAll(medecins_list);
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        setupTableView(MedecinAccess.getAll());
    }
}