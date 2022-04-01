package fr.skaayz.gsb_medecin_mac.controllers;

import fr.skaayz.gsb_medecin_mac.MainController;
import fr.skaayz.gsb_medecin_mac.controllers.departements.EditController;
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

public class DepartementController implements Initializable {
    // FXML Variables
    @FXML
    private TextField search_textbar;

    @FXML
    private Button add_button;

    @FXML
    public TableView<Departement> tableView;

    @FXML
    public TableColumn<Departement, Integer> id;

    @FXML
    public TableColumn<Departement, String> libelle, pays;

    @FXML
    public TableColumn<Departement, String> action;

    // FXML Functions
    @FXML
    public void addButtonClicked() {
        // Create new stage
        Stage stage = new Stage();
        Pane scene_window = null;
        FXMLLoader loader = new FXMLLoader(getClass().getClassLoader().getResource("fr/skaayz/gsb_medecin_mac/views/tabs/popups/adds/depart-view.fxml"));

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

    @FXML
    public void searchButtonClicked() {
        setupTableView(DepartementAccess.getByLike(search_textbar.getText()));
    }

    // Regular Functions
    private void setupTableView(ObservableList<Departement> departements_List) {
        id.setCellValueFactory(new PropertyValueFactory<>("id"));
        libelle.setCellValueFactory(new PropertyValueFactory<>("libelle"));
        pays.setCellValueFactory(c-> new SimpleStringProperty(PaysAccess.getLibelleByID(c.getValue().getPays_id())));

        if(!Utilisateur.isConnected()) {
            action.setVisible(false);

            add_button.setVisible(false);
            search_textbar.setLayoutX(-1);
            search_textbar.setPrefWidth(710);
        }

        // Hide without err
        id.setVisible(false);

        // Create buttons for every rows
        Callback<TableColumn<Departement, String>, TableCell<Departement, String>> cellFactory = (param) -> new TableCell<>() {
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
                        Departement departementClicked = getTableView().getItems().get(getIndex());
                        EditController.setDepartementActuel(departementClicked); // Set the actual medecin

                        // Create new stage
                        Stage stage = new Stage();
                        Pane scene_window = null;
                        FXMLLoader loader = new FXMLLoader(getClass().getClassLoader().getResource("fr/skaayz/gsb_medecin_mac/views/tabs/popups/infos/depart-view.fxml"));

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

        reload(departements_List);
        tableView.setPlaceholder(new Label("Département(s) non trouvé(s)."));
    }

    private void reload(ObservableList<Departement> departements_List) {
        tableView.getItems().clear();
        tableView.refresh();
        tableView.getItems().addAll(departements_List);
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        setupTableView(DepartementAccess.getAll());
    }
}