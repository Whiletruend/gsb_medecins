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
}