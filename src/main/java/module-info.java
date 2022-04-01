module fr.skaayz.project {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;

    opens fr.skaayz.gsb_medecin_mac to javafx.fxml;
    exports fr.skaayz.gsb_medecin_mac;

    opens fr.skaayz.gsb_medecin_mac.models to javafx.fxml;
    exports fr.skaayz.gsb_medecin_mac.models;

    opens fr.skaayz.gsb_medecin_mac.controllers to javafx.fxml;
    exports fr.skaayz.gsb_medecin_mac.controllers;

    exports fr.skaayz.gsb_medecin_mac.controllers.medecins;
    opens fr.skaayz.gsb_medecin_mac.controllers.medecins to javafx.fxml;

    exports fr.skaayz.gsb_medecin_mac.controllers.pays;
    opens fr.skaayz.gsb_medecin_mac.controllers.pays to javafx.fxml;

    exports fr.skaayz.gsb_medecin_mac.controllers.departements;
    opens fr.skaayz.gsb_medecin_mac.controllers.departements to javafx.fxml;
}