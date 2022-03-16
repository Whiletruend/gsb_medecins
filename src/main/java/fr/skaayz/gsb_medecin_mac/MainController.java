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
    private static Stage stage;
    private static double xOffset = 0;
    private static double yOffset = 0;

    // Basic Functions
    public static Parent returnPage(String page) throws IOException {
        return FXMLLoader.load(Objects.requireNonNull(MainController.class.getResource("" + page + "")));
    }

    public static void makeDraggable(Parent root) {
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

    public static void changePage(String page, ActionEvent event) throws IOException {
        Parent root = returnPage(page);
        stage = (Stage)((Node)event.getSource()).getScene().getWindow();
        Scene scene = new Scene(root);

        scene.setFill(Color.TRANSPARENT);
        makeDraggable(root);

        stage.setScene(scene);
        stage.show();
    }

    // FXML Functions
    @FXML
    private javafx.scene.control.Button main_close_button;

    @FXML
    private javafx.scene.control.Button soft_close_button;

    @FXML
    private BorderPane test_border_pane;

    @FXML
    private void mainCountriesButtonClicked() throws IOException {
        AnchorPane view = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("views/countries-view.fxml")));
        test_border_pane.setCenter(view);
    }

    @FXML
    private void mainDepartsButtonClicked() throws IOException {
        AnchorPane view = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("views/departs-view.fxml")));
        test_border_pane.setCenter(view);
    }

    @FXML
    private void mainMedicsButtonClicked() throws IOException {
        AnchorPane view = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("views/medics-view.fxml")));
        test_border_pane.setCenter(view);
    }

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
        changePage("views/main-view.fxml", event);
    }

    @FXML
    private void mainAdminButtonClicked(ActionEvent event) throws IOException {
        changePage("views/connect-view.fxml", event);
    }

    @FXML
    private void mainNotAdminButtonClicked(ActionEvent event) throws IOException {
        changePage("views/app-view.fxml", event);
    }
}

