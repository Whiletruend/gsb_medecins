package fr.skaayz.gsb_medecin_mac;

import fr.skaayz.gsb_medecin_mac.models.Medecin;
import fr.skaayz.gsb_medecin_mac.models.MedecinAccess;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;

import javafx.scene.Scene;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.Parent;

import javafx.stage.Stage;
import javafx.stage.StageStyle;

import javafx.event.EventHandler;

import java.io.IOException;

public class Main extends Application {
    private double xOffset = 0;
    private double yOffset = 0;

    @Override
    public void start(Stage stage) throws IOException {
        Parent root = FXMLLoader.load(getClass().getResource("views/not_admin_views/app-view.fxml"));
        Scene scene = new Scene(root, 1135, 683);

        stage.initStyle(StageStyle.UNDECORATED);
        stage.initStyle(StageStyle.TRANSPARENT);
        scene.setFill(Color.TRANSPARENT);

        // Drag Frame
        root.setOnMousePressed(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent event) {
                xOffset = event.getSceneX();
                yOffset = event.getSceneY();
            }
        });

        root.setOnMouseDragged(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent event) {
                stage.setX(event.getScreenX() - xOffset);
                stage.setY(event.getScreenY() - yOffset);
            }
        });

        stage.setResizable(false);
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        //Medic test = MedicAccess.getMedicByID(7);

        for(Medecin unMedecin : MedecinAccess.getAll()) {
            //System.out.println(unMedecin.getFirstname() + " " + unMedecin.getLastname());
        }

        //System.out.println(MedicAccess.getMedicByID(1006).getFirstname());

        /*
        Database db = new Database();
        try {
            ResultSet rs = db.query("SELECT * FROM medecin where id = 1;");
            System.out.println(rs.getString("nom"));

        } catch (SQLException e) {
            System.out.println("Erreur SQL");
        }

         */

        launch();
    }
}