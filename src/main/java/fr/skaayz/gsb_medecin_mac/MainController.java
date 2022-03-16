package fr.skaayz.gsb_medecin_mac;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;

import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.Parent;
import javafx.scene.Node;

import javafx.event.ActionEvent;

import java.io.IOException;
import java.util.Objects;

public class MainController {
    // Private Vars
    private Stage stage;
    private Scene scene;
    private double xOffset = 0;
    private double yOffset = 0;

    // Scene Controls
    @FXML
    private javafx.scene.control.Button main_close_button;

    @FXML
    private javafx.scene.control.Button soft_close_button;

    @FXML
    private javafx.scene.control.Button soft_back_button;

    @FXML
    private BorderPane test_border_pane;

    @FXML
    private void mainCountriesButtonClicked(ActionEvent event) throws IOException {
        AnchorPane view = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("views/countries-view.fxml")));
        test_border_pane.setCenter(view);
    }

    @FXML
    private void mainDepartsButtonClicked(ActionEvent event) throws IOException {
        AnchorPane view = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("views/departs-view.fxml")));
        test_border_pane.setCenter(view);
    }

    @FXML
    private void mainMedicsButtonClicked(ActionEvent event) throws IOException {
        AnchorPane view = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("views/medics-view.fxml")));
        test_border_pane.setCenter(view);
    }

    private Parent returnPage(String page) throws IOException {
        return FXMLLoader.load(Objects.requireNonNull(getClass().getResource("" + page + "")));
    }

    private void makeDraggable(Parent root) {
        // Drag Frame
        root.setOnMousePressed(event -> {
            xOffset = event.getSceneX();
            yOffset = event.getSceneY();
        });

        root.setOnMouseDragged(event -> {
            stage.setX(event.getScreenX() - xOffset);
            stage.setY(event.getScreenY() - yOffset);
        });
    }

    // FXML Functions
    @FXML
    private void closeButtonClicked(){
        Stage stage = (Stage) main_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void softCloseButtonClicked(){
        Stage stage = (Stage) soft_close_button.getScene().getWindow();
        stage.close();
    }

    @FXML
    private void softBackButtonClicked(ActionEvent event) throws IOException {
        Parent root = returnPage("views/main-view.fxml");
        stage = (Stage)((Node)event.getSource()).getScene().getWindow();
        scene = new Scene(root);

        scene.setFill(Color.TRANSPARENT);
        makeDraggable(root);

        stage.setScene(scene);
        stage.show();
    }

    @FXML
    private void mainAdminButtonClicked(ActionEvent event) throws IOException {
        Parent root = returnPage("views/connect-view.fxml");
        stage = (Stage)((Node)event.getSource()).getScene().getWindow();
        scene = new Scene(root);

        scene.setFill(Color.TRANSPARENT);
        makeDraggable(root);

        stage.setScene(scene);
        stage.show();
    }

    @FXML
    private void connectBackButtonClicked(ActionEvent event) throws IOException {
        Parent root = returnPage("views/main-view.fxml");
        stage = (Stage)((Node)event.getSource()).getScene().getWindow();
        scene = new Scene(root);

        scene.setFill(Color.TRANSPARENT);
        makeDraggable(root);

        stage.setScene(scene);
        stage.show();
    }

    @FXML
    private void mainNotAdminButtonClicked(ActionEvent event) throws IOException {
        Parent root = returnPage("views/not_admin_views/app-view.fxml");
        stage = (Stage)((Node)event.getSource()).getScene().getWindow();
        scene = new Scene(root);

        scene.setFill(Color.TRANSPARENT);
        makeDraggable(root);

        stage.setScene(scene);
        stage.show();
    }
}

