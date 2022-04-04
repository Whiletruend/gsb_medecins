package fr.skaayz.gsb_medecin_mac;

import fr.skaayz.gsb_medecin_mac.models.Utilisateur;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;

import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.Parent;
import javafx.scene.Node;

import javafx.event.ActionEvent;
import javafx.stage.StageStyle;

import java.io.IOException;
import java.net.URL;
import java.util.Objects;
import java.util.ResourceBundle;

public class MainController implements Initializable {
    // Private Vars
    private static Stage stage;
    private static Boolean isOnSoftware = false;
    private static double xOffset = 0;
    private static double yOffset = 0;

    // Basic Functions
    public static void setIsOnSoftware(Boolean bool) {
        MainController.isOnSoftware = bool;
    }

    public static Boolean isOnSoftware() {
        return MainController.isOnSoftware;
    }

    public static Parent returnPage(String page) throws IOException {
        return FXMLLoader.load(Objects.requireNonNull(MainController.class.getResource("" + page + "")));
    }

    public static void setupFrame(Stage stage, Scene scene, Pane scene_window, boolean isStatic) {
        stage.initStyle(StageStyle.UNDECORATED);
        stage.initStyle(StageStyle.TRANSPARENT);
        scene.setFill(Color.TRANSPARENT);

        // Make draggable
        if(!isStatic) {
            scene_window.setOnMousePressed(event1 -> {
                xOffset = event1.getSceneX();
                yOffset = event1.getSceneY();
            });

            scene_window.setOnMouseDragged(event1 -> {
                stage.setX(event1.getScreenX() - xOffset);
                stage.setY(event1.getScreenY() - yOffset);
            });
        }

        stage.setResizable(false);
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
        setIsOnSoftware(Objects.equals(page, "views/app-view.fxml"));

        Parent root = returnPage(page);
        stage = (Stage)((Node)event.getSource()).getScene().getWindow();
        Scene scene = new Scene(root);

        scene.setFill(Color.TRANSPARENT);
        makeDraggable(root);

        stage.setScene(scene);
        stage.show();
    }

    private void loadFXML(String page) throws IOException {
        AnchorPane view = FXMLLoader.load(Objects.requireNonNull(getClass().getResource(page)));
        soft_RightBorderPane.setCenter(view);
    }

    public static boolean isNumeric(String string) {
        int intValue;

        if(string == null || string.equals("")) {
            return false;
        }

        try {
            intValue = Integer.parseInt(string);
            return true;
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return false;
    }

    // FXML Functions
    @FXML
    private javafx.scene.control.Button main_close_button;

    @FXML
    private javafx.scene.control.Button soft_close_button;

    @FXML
    private BorderPane soft_RightBorderPane;

    @FXML
    private Label soft_account_type;

    @FXML
    private Label soft_account_access;

    @FXML
    private void softHomeButtonClicked() throws IOException {
        loadFXML("views/tabs/home-view.fxml");
    }

    @FXML
    private void softCountriesButtonClicked() throws IOException {
        loadFXML("views/tabs/countries-view.fxml");
    }

    @FXML
    private void softDepartsButtonClicked() throws IOException {
        loadFXML("views/tabs/departs-view.fxml");
    }

    @FXML
    private void softMedicsButtonClicked() throws IOException {
        loadFXML("views/tabs/medics-view.fxml");
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

    @FXML
    private void softDisconnectButtonClicked(ActionEvent event) throws IOException {
        changePage("views/main-view.fxml", event);
        Utilisateur.disconnectUser();
    }

    // Init
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        if(isOnSoftware()) {
            try {
                loadFXML("views/tabs/home-view.fxml");
            } catch (IOException e) {
                e.printStackTrace();
            }

            if (Utilisateur.isConnected()) {
                soft_account_type.setText("Administrateur");
                soft_account_access.setText("Complet");
            }
        }
    }
}

