package fr.skaayz.gsb_medecin_mac.controllers;

import fr.skaayz.gsb_medecin_mac.MainController;
import fr.skaayz.gsb_medecin_mac.controllers.pays.EditController;
import fr.skaayz.gsb_medecin_mac.models.Pays;
import fr.skaayz.gsb_medecin_mac.models.PaysAccess;
import fr.skaayz.gsb_medecin_mac.models.Utilisateur;
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

public class PaysController implements Initializable {
    // FXML Variables
    @FXML
    private TextField search_textbar;

    @FXML
    private Button add_button;

    @FXML
    public TableView<Pays> tableView;

    @FXML
    public TableColumn<Pays, Integer> id;

    @FXML
    public TableColumn<Pays, String> libelle;

    @FXML
    public TableColumn<Pays, String> action;

    // FXML Functions
    @FXML
    public void searchButtonClicked() {
        setupTableView(PaysAccess.getByLike(search_textbar.getText()));
    }

    @FXML
    public void addButtonClicked() {
        // Create new stage
        Stage stage = new Stage();
        Pane scene_window = null;
        FXMLLoader loader = new FXMLLoader(getClass().getClassLoader().getResource("fr/skaayz/gsb_medecin_mac/views/tabs/popups/adds/country-view.fxml"));

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

    // Regular Functions
    private void setupTableView(ObservableList<Pays> pays_list) {
        id.setCellValueFactory(new PropertyValueFactory<>("id"));
        libelle.setCellValueFactory(new PropertyValueFactory<>("libelle"));

        if(!Utilisateur.isConnected()) {
            action.setVisible(false);

            add_button.setVisible(false);
            search_textbar.setLayoutX(-1);
            search_textbar.setPrefWidth(710);
        }

        // Hide without err
        id.setVisible(false);

        // Create buttons for every rows
        Callback<TableColumn<Pays, String>, TableCell<Pays, String>> cellFactory = (param) -> new TableCell<>() {
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
                        Pays paysClicked = getTableView().getItems().get(getIndex());
                        EditController.setPaysActuel(paysClicked); // Set the actual medecin

                        // Create new stage
                        Stage stage = new Stage();
                        Pane scene_window = null;
                        FXMLLoader loader = new FXMLLoader(getClass().getClassLoader().getResource("fr/skaayz/gsb_medecin_mac/views/tabs/popups/infos/country-view.fxml"));

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

        reload(pays_list);
        tableView.setPlaceholder(new Label("Pays non trouvé(s)."));
    }

    private void reload(ObservableList<Pays> pays_list) {
        tableView.getItems().clear();
        tableView.refresh();
        tableView.getItems().addAll(pays_list);
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        setupTableView(PaysAccess.getAll());
    }
}