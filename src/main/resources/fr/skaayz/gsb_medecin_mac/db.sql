/* CREATE TABLE IF NOT EXISTSS (pays, departement, medecin, utilisateur, specialite_complementaire) */
CREATE TABLE IF NOT EXISTS pays(
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS departement(
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NULL,
    pays_id INT NOT NULL,
    CONSTRAINT departement_fk
        FOREIGN KEY (pays_id) REFERENCES pays (id)
);

CREATE TABLE IF NOT EXISTS specialite_complementaire(
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL,
    CONSTRAINT specialite_complementaire_libelle_uindex
        UNIQUE (libelle)
);

CREATE TABLE IF NOT EXISTS medecin(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NULL,
    prenom VARCHAR(50) NULL,
    adresse VARCHAR(150) NULL,
    tel VARCHAR(30) NULL,
    specialite_id  INT NOT NULL,
    departement_id INT NOT NULL,
    CONSTRAINT departement__fk
        FOREIGN KEY (departement_id) REFERENCES departement (id)
            ON DELETE CASCADE,
    CONSTRAINT specialite__fk
        FOREIGN KEY (specialite_id) REFERENCES specialite_complementaire (id)
);

CREATE TABLE IF NOT EXISTS utilisateur(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_utilisateur VARCHAR(255) NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL
);

/* FUNCTIONS & TRIGGERS FOR 'medecin' TABLE */
CREATE
    FUNCTION `INITCAP`(input VARCHAR(255))
    RETURNS VARCHAR(255)
BEGIN
    DECLARE len INT;
    DECLARE i INT;

    SET len   = CHAR_LENGTH(input);
    SET input = LOWER(input);
    SET i = 0;

    WHILE (i < len) DO
            IF (MID(input,i,1) = ' ' OR MID(input, i, 1) = '-' OR i = 0) THEN
                IF (i < len) THEN
                    SET input = CONCAT(
                            LEFT(input, i),
                            UPPER(MID(input, i + 1, 1)),
                            RIGHT(input, len - i - 1)
                        );
                END IF;
            END IF;
            SET i = i + 1;
        END WHILE;

    RETURN input;
END;

CREATE TRIGGER upperAndCapitalize_INSERT BEFORE INSERT ON medecin FOR EACH ROW
SET NEW.nom = UPPER(NEW.nom), NEW.prenom = capitalize(NEW.prenom);

CREATE TRIGGER upperAndCapitalize_UPDATE BEFORE UPDATE ON medecin FOR EACH ROW
    SET NEW.nom = UPPER(NEW.nom), NEW.prenom = capitalize(NEW.prenom);

/* INSERT EVERY COUNTRIES */
INSERT INTO pays (id, libelle) VALUES (1, 'France');
INSERT INTO pays (id, libelle) VALUES (2, 'Angleterre');
INSERT INTO pays (id, libelle) VALUES (3, 'Italie');
INSERT INTO pays (id, libelle) VALUES (4, 'Espagne');
INSERT INTO pays (id, libelle) VALUES (5, 'Portugal');
INSERT INTO pays (id, libelle) VALUES (6, 'Belgique');
INSERT INTO pays (id, libelle) VALUES (7, 'Australie');

/* INSERT EVERY DEPARTMENTS */
INSERT INTO departement (id, libelle, pays_id) VALUES (1, 'Yvelines', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (2, 'Alsace', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (3, 'Lorraine', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (4, 'Vaucluse', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (5, 'Ardèche', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (6, 'Ardennes', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (7, 'Aveyron', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (8, 'Pas-de-Calais', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (9, 'Var', 1);
INSERT INTO departement (id, libelle, pays_id) VALUES (10, 'Paris', 1);

/* INSERT EVERY SPECIALITY */
INSERT INTO specialite_complementaire (id, libelle) VALUES (4, 'ACUPONCTURE');
INSERT INTO specialite_complementaire (id, libelle) VALUES (5, 'ALLERGOLOGIE');
INSERT INTO specialite_complementaire (id, libelle) VALUES (7, 'ANGEIOLOGIE');
INSERT INTO specialite_complementaire (id, libelle) VALUES (9, 'AUCUNE SPÉCIALITÉ');
INSERT INTO specialite_complementaire (id, libelle) VALUES (6, 'GERONTOLOGIE');
INSERT INTO specialite_complementaire (id, libelle) VALUES (1, 'HOMEOPATHIE');
INSERT INTO specialite_complementaire (id, libelle) VALUES (2, 'MEDECINE APPLIQUEE AUX SPORTS');
INSERT INTO specialite_complementaire (id, libelle) VALUES (8, 'OSTEOPATHIE');
INSERT INTO specialite_complementaire (id, libelle) VALUES (3, 'URGENTISTE');

/* INSERT ADMIN USER (username = admin ; password = aaaa) */
INSERT INTO utilisateur (id, nom_utilisateur, mot_de_passe) VALUES (1, 'a48c985784c99de0febf6f327c1ae08ae05c2cfae8550b463c0089001fb61728def6295253d1b4a06411c242a6c8adbe0e396bf9cc65d24ea83ab490c3cf217d', 'd640a809dd1a77ceafbb50160941d250f8844c5c3517b51dcca7aca08c273c430f166433da954177c92f8f0557a65cdc59256d6b39e782ead57eb64fd2818319');

/* INSERT EVERY MEDICS */
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Prosper', '25 rue Anatole France BRIANCON 05100', '0485244174', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ferdinand', 'Anne-Lucie', '39 rue des gatinnes BILLIAT 01200', '0433812572', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pastor', 'Camille', '58 rue du stade MESSINCOURT 08110', '0365489929', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Certifat', 'Alice', '12 rue des Pigeons JOIGNY-SUR-MEUSE 08700', '0319692016', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Vénus', '55 rue du 14 juillet ORCIERES 05170', '0421670911', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Anne-Lucie', '49 rue des Ormes ATTILLY 02490', '0313817061', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nasri', 'Marie', '78 rue de Poligny YONCQ 08210', '0388716930', 1, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Andrew', '29 rue des Pigeons SAVINES-LE-LAC 05160', '0477740994', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jamgotchian', 'Julien', '45 rue de du général Scott THIN-LE-MOUTIER 08460', '0321760709',
        2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cherioux', 'Aurèle', '16 rue Alphonse Daudet ORCIERES 05170', '0485568083', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hansbern', 'Johnny', '74 rue de Paris SAVINES-LE-LAC 05160', '0417789322', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Andrée', '29 rue Edouard Hériot SAINT-SAUVEUR 05200', '0439352503', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zerbib', 'Gilles', '33 rue Commandant Hériot MONTIGNY-SUR-MEUSE 08170', '0334037052', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Varditi', 'Vénus', '14 rue de la poste BANCIGNY 02140', '0313832194', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Labatiste', 'Cristophe', '81 rue Bonaparte AUBENTON 02500', '0366612144', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gaudin', 'Jules', '85 rue Hector Berlioz BRIANCON 05100', '0459073011', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Julienne', '17 rue Lampion AUGIREIN 09800', '0524077425', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lirevien', 'John', '92 rue du général de Gaulle SORBIERS 05150', '0484328394', 1, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pistache', 'Cristophe', '1 rue des Accacias BELLOC 09600', '0564847694', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Catherine', '8 rue des Accacias MONCEAU-SUR-OISE 02120', '0352679072', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vipère', 'Julien', '51 rue Bonaparte CAMON 09500', '0552863581', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Nohan', '69 rue Mallarmé AX-LES-THERMES 09110', '0596648531', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chemkaoui', 'Julienne', '72 rue Pasteur SAVOURNON 05700', '0490527954', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'Irénée', '28 rue Anatole France BELLEY 01300', '0486481045', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'François', '78 rue des Epines AZY-SUR-MARNE 02400', '0318212781', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Roland', 'Charles-Edouard', '86 rue Louis Aragon BILLIAT 01200', '0446961025', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestoriat', 'Jérémy', '89 rue de la pointe SAINT-FIRMIN 05800', '0438318333', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Varicelle', 'Johnny', '19 rue de la Tour JOIGNY-SUR-MEUSE 08700', '0341883832', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zidanne', 'Hector', '29 rue de la pointe BOURG-EN-BRESSE 01000', '0431450970', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hatiche', 'Mohammed', '30 rue Pasteur BEZAC 09100', '0591677334', 2, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sursarshill', 'Annie', '82 rue Mallarmé SIGOYER 05130', '0487018886', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cherioux', 'Caline', '27 rue de Marigny BRIANCON 05100', '0444253472', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Jordan', '53 rue Alphonse Daudet SAINT-LAURENT-SUR-SAONE 01750', '0463813731', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Falmino', 'Anne-Lucie', '94 rue de la pointe BOULIGNEUX 01330', '0462262613', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Reissa', '63 rue Alphonse Daudet AX-LES-THERMES 09110', '0563092583', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Anne-Jeanne', '26 rue des Armées AVANCON 05230', '0442237548', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Merlieux', 'Fatima', '24 rue Albert Camus PELVOUX 05340', '0411439067', 3, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zomar', 'Alice', '33 rue de la Tour BOURG-EN-BRESSE 01000', '0479660588', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Faure', 'Béatrice', '25 rue des Lilas LAUNOIS-SUR-VENCE 08430', '0389426738', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Balittin', 'Armelle', '48 rue de Paris REOTIER 05600', '0467247607', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Alprousky', 'Anselme', '19 rue des pyramides ARANDAS 01230', '0434638475', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Faure', 'John', '23 rue Alphonse Daudet SORBIERS 05150', '0473380415', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Firmin', '59 rue de la Pergolat FLEVILLE 08250', '0337420570', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yanshen', 'Anne', '59 rue de du général Scott MONTCY-NOTRE-DAME 08090', '0310431717', 4, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bouglieux', 'Gilles', '65 rue des oiseaux ARROUT 09800', '0578097401', 2, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquet', 'Anne-Jeanne', '29 rue Petit BEDEILLE 09230', '0523206238', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vipère', 'Anne-Lucie', '14 rue Petit BEZAC 09100', '0512011679', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Carole', '86 rue du capitaine Fraquasse BETTANT 01500', '0490382365', 1, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Amiel', '22 rue Lampion BELLEY 01300', '0463584743', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Natale', 'Martial', '75 rue du capitaine Crochet ATTILLY 02490', '0361985743', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epriniche', 'Anne-Laure', '60 rue Pernod BETTANT 01500', '0437621473', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oumar', 'Prosper', '46 rue de la Tour REOTIER 05600', '0450401007', 4, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Brouzais', 'Fatima', '95 rue de Poligny BOURG-EN-BRESSE 01000', '0481057435', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Guimauve', 'Jérome', '39 rue Commandant Hériot BANCIGNY 02140', '0315759754', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Guimauve', 'Ines', '90 rue Pernod ROCHEBRUNE 05190', '0444572962', 5, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipion', 'Jérémie', '45 rue des Chantereines FLOING 08200', '0333621591', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chevalier', 'Anne-Marie', '48 rue du 14 juillet BRIANCON 05100', '0478777229', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Heroudy', 'Armelle', '88 rue des Argonautes DOMMARTIN 01380', '0482500579', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Nazaoui', 'Anselme', '18 rue de du général Scott BOURG-EN-BRESSE 01000', '0428387190', 6, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Aude', '98 rue Hector Berlioz BOULIGNEUX 01330', '0460116931', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Razaoui', 'Camille', '43 rue de la poste ASTON 09310', '0554877193', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Bernard', '69 rue Debussy AX-LES-THERMES 09110', '0592618819', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chakraoui', 'Johnny', '27 rue Victor Hugo MONTCEAUX 01090', '0410938634', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopes', 'Aude', '40 rue Mallarmé SAINT-FIRMIN 05800', '0434328795', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmieux', 'Anne-Lucie', '80 rue Victor Hugo LAVAL-MORENCY 08150', '0354570788', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'Alice', '48 rue des perles blanches QUATRE-CHAMPS 08400', '0351022549', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Astoria', 'Bénédicte', '44 rue des Pigeons SAINT-LAURENT-SUR-SAONE 01750', '0453817641', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Ferdinand', 'Précilia', '65 rue St Denis ASTON 09310', '0574385413', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charlequin', 'Andrée', '86 rue des Pigeons AX-LES-THERMES 09110', '0512919575', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Merlieux', 'Bertrand', '87 rue du 14 juillet BARZY-SUR-MARNE 02850', '0389988201', 5, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Hamouti', 'Jérome', '40 rue Bonaparte MAYOT 02800', '0380247692', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pionneer', 'Victor', '91 rue Malraux MEZIERES-SUR-OISE 02240', '0396223586', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pistache', 'Victor', '86 rue du capitaine Fraquasse SAVINES-LE-LAC 05160', '0424098074', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmieux', 'Bertrand', '44 rue du capitaine Fraquasse MONTIGNY-SUR-MEUSE 08170', '0365814281', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jarrinovski', 'Adrien', '47 rue Commandant Hériot AUDRESSEIN 09800', '0561293920', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chermis', 'Irénée', '42 rue des Epines SAINT-LAURENT-SUR-SAONE 01750', '0432573377', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pizoulais', 'Amélie', '95 rue Anatole France HERBEUVAL 08370', '0395342234', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gullit', 'Jordan', '18 rue Blainville AVANCON 05230', '0410805260', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zomar', 'Anne-Laure', '49 rue des Princes OYONNAX 01100', '0495914341', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Natale', 'Ingrid', '90 rue des Lilas BELLOC 09600', '0550136460', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prouteau', 'Yoan', '2 rue Beaudelaire FALAISE 08400', '0349609708', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zebitoun', 'Jules', '61 rue Petit SORBIERS 05150', '0453597713', 7, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gaudillot', 'Jérome', '12 rue Agniel ABBECOURT 02300', '0336592352', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pionneer', 'Bernard', '46 rue des Néfliers ARROUT 09800', '0593876907', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Anne-Jeanne', '94 rue de la Tour AUBENTON 02500', '0315358087', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'John', '13 rue de la recette MONT-LAURENT 08130', '0324815927', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Thardieux', 'Aurélien', '34 rue Alphonse Daudet MONTCY-NOTRE-DAME 08090', '0388838695', 5, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'Anne-Marie', '50 rue Commandant Mouchotte BARENTON-SUR-SERRE 02270', '0380767789', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Nazaoui', 'Marie', '36 rue de la rose BOULIGNEUX 01330', '0459841705', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Amoudi', 'Bertrand', '80 rue Beaudelaire FLOING 08200', '0370254981', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mingalle', 'Austine', '37 rue Agniel BILLIAT 01200', '0498702952', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'Aline', '85 rue des Cavaux AUBENTON 02500', '0320874526', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zebitoun', 'Béatrice', '98 rue Perdue AUDRESSEIN 09800', '0550107365', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charles', 'Fernand', '21 rue Blainville ABBECOURT 02300', '0379546875', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Brouzais', 'Anne-Lucie', '47 rue des Anses bleues BARENTON-SUR-SERRE 02270', '0357798474', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bridel', 'Julienne', '89 rue du stade VAUX-CHAMPAGNE 08130', '0321409034', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sursarshill', 'Alain', '21 rue des pyramides MONTCY-NOTRE-DAME 08090', '0355126171', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radesky', 'André', '70 rue de la rose THIN-LE-MOUTIER 08460', '0383574338', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Anne-Lucie', '28 rue du Mont AX-LES-THERMES 09110', '0525425981', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Roland', 'Jérémie', '83 rue de la pointe MONTCY-NOTRE-DAME 08090', '0344175754', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zola', 'Alizée', '23 rue des Néfliers BARZY-SUR-MARNE 02850', '0318063658', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lafricain', 'Béatrice', '75 rue de la poste SIGOYER 05130', '0499728475', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Jimmy', '57 rue du 14 juillet BEDEILLE 09230', '0579403405', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Labuze', 'Martin', '77 rue Edouard Hériot PELVOUX 05340', '0465821962', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charminet', 'Astine', '77 rue des Chantereines SIGOYER 05130', '0443207794', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Francis', 'Julien', '75 rue des Epines EVIGNY 08090', '0353124513', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lièvremont', 'Anne-Lucie', '64 rue des Pigeons BEAUMONT-EN-BEINE 02300', '0357357391', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Martinet', 'Fernand', '21 rue Commandant Hériot ARROUT 09800', '0533982064', 5, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pletziglass', 'Aurélien', '13 rue Debussy AUGIREIN 09800', '0550671849', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Raminski', 'Hector', '54 rue des Chantereines BEAUMONT-EN-BEINE 02300', '0397960460',
        2, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Bénédicte', '7 rue de Paris BOURG-EN-BRESSE 01000', '0483574560', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kopa', 'Aristote', '35 rue des Argonautes FEPIN 08170', '0321622783', 4, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Anémone', '66 rue Blainville ARROUT 09800', '0561274309', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'Hamed', '96 rue de la Tour SAINT-CREPIN 05600', '0466381035', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rastuffe', 'Précilia', '45 rue des Chantereines MONTIGNY-SUR-MEUSE 08170', '0319515228', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epriniche', 'Ines', '54 rue de la Tour AUGIREIN 09800', '0522353355', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Newmann', 'Alizée', '32 rue des gatinnes SAINT-SAUVEUR 05200', '0479723538', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Reissa', '36 rue Malraux FLEVILLE 08250', '0389034128', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Protonne', 'Anne-Sophie', '27 rue Anatole France LAUNOIS-SUR-VENCE 08430', '0319617909', 7, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rastuffe', 'Hamed', '44 rue de la Pergolat AGUILCOURT 02190', '0391017673', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Politzer', 'Alain', '97 rue des Anges SAINT-LAURENT-SUR-SAONE 01750', '0420673509', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Margotton', 'Rodolphe', '5 rue de la pointe AUGIREIN 09800', '0568080361', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kravatte', 'Andrée', '26 rue des Argonautes BELLEY 01300', '0417979762', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kobel', 'Hamed', '52 rue des Argonautes BILLIAT 01200', '0434883323', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vispendieu', 'Mohammed', '33 rue Bonaparte VAUX-CHAMPAGNE 08130', '0388412366', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Patricia', '86 rue de la poste ASTON 09310', '0544573807', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopez', 'Aurélien', '51 rue Debussy SAINT-FIRMIN 05800', '0429493464', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Firmin', '69 rue de Paris MEZIERES-SUR-OISE 02240', '0327148898', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Robert', '18 rue des Pigeons MAYOT 02800', '0350756815', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Patrick', '35 rue des Cyprés MEZIERES-SUR-OISE 02240', '0375111486', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charlequin', 'Catherine', '67 rue des Pigeons NEUVILLE-LES-DAMES 01400', '0445004508', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestor', 'Aude', '68 rue des Epines BAGERT 09230', '0511378600', 5, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fressinet', 'François', '38 rue Agniel PELVOUX 05340', '0466704922', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmis', 'Habib', '96 rue de Marigny SAINTE-MARIE 05150', '0472203933', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Annie', '98 rue des Argonautes FRESSANCOURT 02800', '0324461914', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Julienne', '59 rue des gatinnes BARZY-SUR-MARNE 02850', '0311581103', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kopa', 'Alain', '48 rue des Epines VAUX-CHAMPAGNE 08130', '0353929274', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Merlieux', 'Aristote', '42 rue Edouard Hériot BAGERT 09230', '0597457423', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pionneer', 'Catherine', '53 rue des hirondelles SAINT-FIRMIN 05800', '0473864972', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestor', 'Fatima', '7 rue Alphonse Daudet ASTON 09310', '0573029393', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Fernand', '64 rue des Artistes AX-LES-THERMES 09110', '0580503787', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Anne-Lucie', '17 rue Pernod DOMMARTIN 01380', '0454076144', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Milliet', 'Anne-Ange', '39 rue des Anges SAVINES-LE-LAC 05160', '0460795137', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Alice', '32 rue des pyramides BEAUMONT-EN-BEINE 02300', '0315894255', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Armelle', '44 rue Perdue ABBECOURT 02300', '0346616676', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Mestre', 'Anne-Ange', '67 rue de la pointe SAINT-LAURENT-SUR-SAONE 01750', '0479957609', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'André', '9 rue Mallarmé AUBENTON 02500', '0342830645', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zerbib', 'Aurèle', '54 rue du stade NEUVILLE-LES-DAMES 01400', '0470983399', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sabatier', 'Jimmy', '8 rue Albert Camus MONTCY-NOTRE-DAME 08090', '0339328684', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mariveaux', 'Anaelle', '53 rue St Denis BELLOC 09600', '0575252091', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hallouche', 'Armelle', '79 rue Beaudelaire BAGERT 09230', '0574702561', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sadot', 'Catherine', '81 rue des Cyprés SIGOYER 05130', '0431018220', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Politzer', 'Julien', '33 rue des Cyprés BAGERT 09230', '0590592425', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charlequin', 'Adelphe', '7 rue de la poste OYONNAX 01100', '0463473029', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Restiffe', 'Hypolite', '62 rue Malraux BOURG-EN-BRESSE 01000', '0459994942', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zebitoun', 'Martin', '4 rue des perles blanches FLOING 08200', '0377624408', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bridel', 'Aristote', '13 rue des Argonautes ABBECOURT 02300', '0334073561', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hansbern', 'Roby', '16 rue Hector Berlioz MACHAULT 08310', '0327990795', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ricardo', 'Austine', '86 rue Pernod SAINT-ANDRE-DE-ROSANS 05150', '0475430562', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charles', 'François', '75 rue Anatole France AX-LES-THERMES 09110', '0527300069', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pionneer', 'Aurèle', '77 rue des perles blanches BANCIGNY 02140', '0336207616', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rachock', 'Carole', '62 rue de la pointe BRIANCON 05100', '0494704120', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mistigry', 'Charles-Edouard', '96 rue des Pigeons MONTCY-NOTRE-DAME 08090', '0351941479', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chesnikov', 'Hamed', '88 rue des Armées BELLEY 01300', '0425303459', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mariveaux', 'Amélie', '8 rue de la gare AX-LES-THERMES 09110', '0543024681', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Yoan', '67 rue des Anges SAINT-SAUVEUR 05200', '0444643838', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Victor', '31 rue des Anges BUZAN 09800', '0531789114', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanzle', 'Julien', '30 rue des Argonautes ATTILLY 02490', '0381097843', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frazier', 'Astine', '63 rue du stade AX-LES-THERMES 09110', '0589774185', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kérouanne', 'Johnny', '63 rue du 14 juillet AX-LES-THERMES 09110', '0559787089', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chastidien', 'Anaelle', '72 rue de Paris CHALLES 01450', '0436897781', 2, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Alprousky', 'Habib', '42 rue des Ormes BILLIAT 01200', '0461405456', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zebitoun', 'Johnny', '62 rue du général de Gaulle BOURG-EN-BRESSE 01000', '0479899509', 8, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Anne-Jeanne', '9 rue Pasteur SAINT-FIRMIN 05800', '0412854347', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquette', 'Françoise', '36 rue des Ormes SAINT-CREPIN 05600', '0470969763', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ben Harfa', 'Annie', '6 rue des Armées ASTON 09310', '0561398750', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Alizée', '60 rue Edouard Hériot ASTON 09310', '0529196402', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Farahoui', 'Victor', '68 rue de la Pergolat BEDEILLE 09230', '0510798563', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Amiel', '48 rue Alphonse Daudet FLOING 08200', '0367188526', 2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Alprousky', 'Serge', '13 rue des Epines BETTANT 01500', '0415842763', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Heroudy', 'Anne-Lucie', '91 rue Lampion HOUDILCOURT 08190', '0360919149', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scott', 'Firmin', '79 rue Commandant Mouchotte SAVINES-LE-LAC 05160', '0454186158', 8, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jalouve', 'Jules', '41 rue Louis Aragon SAINT-LAURENT-SUR-SAONE 01750', '0470580820', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yanshen', 'Irénée', '25 rue Lampion BLYES 01150', '0462212615', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Camus', 'Anne-Marie', '21 rue de la Pergolat AX-LES-THERMES 09110', '0552002239', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pastor', 'Ines', '81 rue du 14 juillet BELLOC 09600', '0579065527', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chastidien', 'Aurèle', '82 rue des Anges MEZIERES-SUR-OISE 02240', '0372146119', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yanshen', 'Ingrid', '2 rue de la rose BARZY-SUR-MARNE 02850', '0374513763', 2,
        02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'Prosper', '34 rue Louis Aragon ARROUT 09800', '0570233041', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ronsart', 'Hamed', '54 rue Louis Aragon MACHAULT 08310', '0361841793', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('GrosPierre', 'Yoan', '69 rue des Accacias BEAUMONT-EN-BEINE 02300', '0364444471', 7, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Serge', '57 rue du capitaine Crochet MONTCY-NOTRE-DAME 08090', '0348000197',
        2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lirevien', 'Patrice', '64 rue Albert Camus SAINT-LAURENT-SUR-SAONE 01750', '0427960246', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Egrouzais', 'Aristote', '5 rue des Cyprés AZY-SUR-MARNE 02400', '0352734097', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frazier', 'Astine', '40 rue Louis Aragon MONTCY-NOTRE-DAME 08090', '0335541135', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Ferdinand', 'Anémone', '85 rue Hector Berlioz BEZAC 09100', '0538796488', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Anselme', '79 rue des Cavaux CHABESTAN 05400', '0478991381', 2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Hamouti', 'Gilles', '88 rue Alphonse Daudet BELLOC 09600', '0591522693', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mistigry', 'Austine', '72 rue des Ormes MESSINCOURT 08110', '0368355399', 6, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Aurèle', '53 rue Hector Berlioz FALAISE 08400', '0325150351', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('GrosJean', 'Nohan', '58 rue du 14 juillet AUBENTON 02500', '0380869429', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Roland', 'Jimmy', '41 rue du Mont FRESSANCOURT 02800', '0333010728', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rétin', 'Gilles', '26 rue du capitaine Fraquasse YONCQ 08210', '0355888480', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Jules', '95 rue des gatinnes EVIGNY 08090', '0321047751', 3, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Adrien', '37 rue de la rose BARENTON-SUR-SERRE 02270', '0333061059', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'Astine', '29 rue Louis Aragon FLEVILLE 08250', '0337878739', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Camus', 'Ingrid', '95 rue Mallarmé AX-LES-THERMES 09110', '0538253531', 5, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gueret', 'Julie', '70 rue du Mont BILLIAT 01200', '0434858369', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Jules', '87 rue des hirondelles FLOING 08200', '0366452640', 2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'sabine', '70 rue des Ormes LAVAL-MORENCY 08150', '0313786191', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'Anne-Sophie', '72 rue de Paris AMBRIEF 02200', '0396888350', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermontin', 'Julienne', '95 rue de du général Scott SAINT-FIRMIN 05800', '0499781511', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lièvremont', 'Prosper', '40 rue du stade CHEZY-SUR-MARNE 02570', '0370552277', 2,
        02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sursarshill', 'François', '21 rue des oiseaux AUBENTON 02500', '0347608567', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Lazio', 'Béatrice', '91 rue de Paris BARENTON-SUR-SERRE 02270', '0332630528', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Egrouzais', 'Alice', '14 rue de la Tour PELVOUX 05340', '0497349269', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Roulède', 'Hypolite', '4 rue Petit AX-LES-THERMES 09110', '0592259965', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bridel', 'Dominique', '17 rue Victor Hugo NEUVILLE-LES-DAMES 01400', '0436894892', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Précilia', '46 rue Perdue MONT-LAURENT 08130', '0357123782', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Patrice', '37 rue des perles blanches AUGIREIN 09800', '0514467307', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ronsart', 'Catherine', '18 rue de la Pergolat CHABESTAN 05400', '0433787136', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chemkaou', 'Anne-Jeanne', '61 rue Malraux SAVINES-LE-LAC 05160', '0425403948', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Francis', 'Martial', '39 rue des Pigeons FRESSANCOURT 02800', '0376405689', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Ines', '36 rue du général de Gaulle AX-LES-THERMES 09110', '0571237673', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Fatima', '27 rue des Ormes BARENTON-SUR-SERRE 02270', '0369886219', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zerbib', 'Cristophe', '35 rue Commandant Mouchotte CHEZY-SUR-MARNE 02570', '0399128847', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harshill', 'Charles-Edouard', '69 rue de Paris BRIANCON 05100', '0486522042', 4, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Alice', '64 rue de Paris SORBIERS 05150', '0498218342', 7, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kobel', 'Johnny', '4 rue des Lilas BELLOC 09600', '0583708661', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gullit', 'Marie', '27 rue du stade NEUVILLE-LES-DAMES 01400', '0440602180', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Format', 'Patrice', '25 rue des Néfliers AGUILCOURT 02190', '0313705112', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Roby', '74 rue de Marigny JUNIVILLE 08310', '0370618394', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Krevette', 'François', '40 rue Commandant Mouchotte BOURG-EN-BRESSE 01000', '0466232870', 7, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chastidien', 'Anne-Lucie', '28 rue de la poste MONCEAU-SUR-OISE 02120', '0337880516', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prouteau', 'Marie', '65 rue des Accacias MEZIERES-SUR-OISE 02240', '0347429128', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radosky', 'Irénée', '66 rue Victor Hugo ASTON 09310', '0545396012', 1, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassolette', 'Aurèle', '78 rue du 14 juillet NEUVILLE-LES-DAMES 01400', '0436441368', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Armouche', 'Jimmy', '31 rue des Cavaux BOURG-EN-BRESSE 01000', '0489010528', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nasri', 'Jordan', '56 rue du Mont BRIANCON 05100', '0497686569', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanzle', 'Andrew', '5 rue des Pigeons ATTILLY 02490', '0317928011', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Capliez', 'Andrée', '9 rue de Paris CAMON 09500', '0575615612', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Béronze ', 'Aurélien', '34 rue des perles blanches HERBEUVAL 08370', '0354324365', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Caline', '90 rue des Pigeons BETTANT 01500', '0441422871', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Bertrand', '88 rue Mallarmé CAMON 09500', '0519717031', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Magellan', 'Anne-Lucie', '31 rue St Denis AVANCON 05230', '0476620839', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Ferdinand', 'Anne-Marie', '32 rue Petit BOULIGNEUX 01330', '0429892782', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sibaton', 'Anne', '96 rue des pyramides SAINT-FIRMIN 05800', '0430056957', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frédrick', 'Jordan', '71 rue Lampion ROCHEBRUNE 05190', '0422193913', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Falahoui', 'Hector', '39 rue des Chantereines SAINT-CREPIN 05600', '0427945468', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mistigry', 'Patrice', '35 rue de la gare DOMMARTIN 01380', '0412349269', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotbel', 'Austine', '1 rue Perdue BANCIGNY 02140', '0362784487', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sidot', 'Nohan', '87 rue de la poste ORCIERES 05170', '0492790588', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framzaoui', 'Adrien', '6 rue St Denis NEUVILLE-LES-DAMES 01400', '0463805846', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Aurélien', '24 rue Anatole France FALAISE 08400', '0394184441', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanzert', 'Anne-Sophie', '78 rue Mallarmé BELLOC 09600', '0565131061', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harviche', 'Précilia', '17 rue de Paris BARZY-SUR-MARNE 02850', '0373800189', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Farmin', 'Béatrice', '65 rue des Cyprés ASTON 09310', '0556222808', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oulianov', 'Alain', '12 rue des oiseaux BEAUMONT-EN-BEINE 02300', '0336437836', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Jérémy', '13 rue Louis Aragon ARROUT 09800', '0579019785', 6, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Alice', '42 rue des hirondelles SAINT-LAURENT-SUR-SAONE 01750', '0418404333', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Faouzi', 'Serge', '54 rue Debussy AUDRESSEIN 09800', '0589986579', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rodriguez', 'Bertrand', '16 rue de la Tour MONTIGNY-SUR-MEUSE 08170', '0362958231', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radronck', 'Alizée', '85 rue Alphonse Daudet SAINT-SAUVEUR 05200', '0469350553', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sibroton', 'Irénée', '54 rue de Marigny PELVOUX 05340', '0413512651', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Bertrand', '66 rue du capitaine Crochet BILLIAT 01200', '0430273395', 5, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Reissa', '92 rue des Epines BOURG-EN-BRESSE 01000', '0462567494', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('GrosPierre', 'Anne-Lucie', '58 rue des Anges FRESSANCOURT 02800', '0397948858', 6, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chermis', 'Alain', '13 rue Albert Camus BAGERT 09230', '0561056383', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jankelevitch', 'Rodolphe', '4 rue Bonaparte NEUVILLE-LES-DAMES 01400', '0499930510', 5, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hallouche', 'Dominique', '31 rue Pernod MESSINCOURT 08110', '0354437353', 1, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jalouve', 'Amélie', '73 rue des Epines AGUILCOURT 02190', '0393504917', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Aude', '43 rue des Pigeons FALAISE 08400', '0395808887', 2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Julie', '76 rue des Armées CAMON 09500', '0558376134', 5, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Loulianov', 'Jérémie', '71 rue de Poligny SAVINES-LE-LAC 05160', '0490614401', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Falahoui', 'Annie', '95 rue des hirondelles AGUILCOURT 02190', '0334620315', 5, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rachock', 'Hypolite', '96 rue Commandant Mouchotte BOULIGNEUX 01330', '0445325841', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Aline', '9 rue des Epines OYONNAX 01100', '0463729220', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fournil', 'Martin', '93 rue de la Tour BELLEY 01300', '0459132484', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Thardieux', 'Hamed', '8 rue Louis Aragon FRESSANCOURT 02800', '0311170881', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Perronet', 'François', '90 rue de la poste AX-LES-THERMES 09110', '0553374090', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bridel', 'Aurèle', '92 rue St Denis SORBIERS 05150', '0481537923', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Bernard', '71 rue Mallarmé MESSINCOURT 08110', '0366706848', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Julien', '58 rue de Paris CEYZERIAT 01250', '0411229599', 2, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Nazaoui', 'Gilles', '66 rue de du général Scott ARROUT 09800', '0590561289',
        2, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglomert', 'Astine', '18 rue des gatinnes SAINT-LAURENT-SUR-SAONE 01750', '0426146482', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mistigry', 'Patrice', '12 rue Victor Hugo EVIGNY 08090', '0311209603', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanzert', 'Ingrid', '74 rue des hirondelles AX-LES-THERMES 09110', '0542828199', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radocky', 'Aurélien', '38 rue Debussy BILLIAT 01200', '0439490126', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Yoan', '40 rue de la recette MONCEAU-SUR-OISE 02120', '0333274282', 8, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scott', 'Adelphe', '93 rue Alphonse Daudet OYONNAX 01100', '0457686776', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Adrien', '82 rue Agniel JUNIVILLE 08310', '0352053332', 5, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Farahoui', 'Caline', '82 rue St Denis ASTON 09310', '0593546818', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ben Harfa', 'Rodolphe', '68 rue des Argonautes MONCEAU-SUR-OISE 02120', '0381648585', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Roland', 'Patricia', '6 rue de la gare BILLIAT 01200', '0474405770', 6, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kan', 'Robert', '40 rue des pyramides SAINT-FIRMIN 05800', '0482621556', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charlequin', 'Fatima', '7 rue du renard BUZAN 09800', '0560148975', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cerpico', 'Carole', '77 rue Anatole France MESSINCOURT 08110', '0361849887', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hourin', 'Jordan', '20 rue de la recette SAINT-ANDRE-DE-ROSANS 05150', '0432143599', 7, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ligne', 'Patrice', '10 rue du capitaine Crochet CHALLES 01450', '0479473742', 5, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durieux', 'Astine', '98 rue du renard BLYES 01150', '0447475896', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chermis', 'Anselme', '78 rue de la poste OYONNAX 01100', '0465535519', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Aurèle', '63 rue de la gare CHABESTAN 05400', '0434955199', 2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Serbouny', 'Jérome', '27 rue des Chantereines BARZY-SUR-MARNE 02850', '0328609452', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Victor', '70 rue de la Pergolat ABBECOURT 02300', '0397808656', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Anne-Laure', '58 rue du général de Gaulle FALAISE 08400', '0381506423', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Hector', '41 rue Malraux SIGOYER 05130', '0447077417', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harviche', 'Anne-Jeanne', '12 rue Louis Aragon THIN-LE-MOUTIER 08460', '0351239489', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Raminsky', 'Anne-Lucie', '16 rue Blainville SAVINES-LE-LAC 05160', '0474386707', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sursarshill', 'Jérémy', '53 rue de la pointe AUGIREIN 09800', '0517209857', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Anne', '70 rue de la rose ABBECOURT 02300', '0315174364', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kan', 'Armelle', '27 rue Blainville SIGOYER 05130', '0487157453', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cherioux', 'Camille', '90 rue Mallarmé PELVOUX 05340', '0462682764', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jankelevitch', 'Anaelle', '73 rue des Cavaux FEPIN 08170', '0347605928', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Carole', '82 rue Blainville BILLIAT 01200', '0489580183', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bredequin', 'Rosalie', '66 rue des Princes SORBIERS 05150', '0447973887', 2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mariveaux', 'Fatima', '38 rue Hector Berlioz SORBIERS 05150', '0489828043', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fugasse', 'Anne-Jeanne', '60 rue Victor Hugo NEUVILLE-LES-DAMES 01400', '0466135862', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Hypolite', '26 rue Alphonse Daudet BETTANT 01500', '0496740768', 2,
        01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chemkaoui', 'Sophie', '37 rue Alphonse Daudet AX-LES-THERMES 09110', '0550507761', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Anne-Laure', '96 rue du capitaine Fraquasse AUBENTON 02500', '0332042330', 3, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassin', 'Caline', '84 rue des Néfliers SAINT-ANDRE-DE-ROSANS 05150', '0441770926', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pololsky', 'Amiel', '11 rue Commandant Hériot ARROUT 09800', '0530054025', 6, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gueret', 'Adelphe', '1 rue des Princes SIGOYER 05130', '0446366196', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Alain', '76 rue Commandant Mouchotte AX-LES-THERMES 09110', '0510808813', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rosty', 'Gilles', '64 rue Commandant Hériot ARANDAS 01230', '0466707367', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Fernand', '66 rue du 14 juillet OYONNAX 01100', '0446432036', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vipère', 'Andrée', '76 rue des Cavaux SORBIERS 05150', '0433833354', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fournil', 'Robert', '67 rue du capitaine Crochet FRESSANCOURT 02800', '0396745829', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Merlieux', 'Charles', '81 rue Mallarmé BEAUMONT-EN-BEINE 02300', '0318112146', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Jérémie', '49 rue de la Pergolat REOTIER 05600', '0452299934', 4, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prouteau', 'sabine', '73 rue Agniel FEPIN 08170', '0340871558', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquette', 'Patrice', '26 rue du renard OYONNAX 01100', '0499920026', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Jules', '21 rue Pasteur SORBIERS 05150', '0497153129', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'Alizée', '69 rue de la Pergolat BELLEY 01300', '0485963418', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yansen', 'Armelle', '16 rue des Anses bleues VAUX-CHAMPAGNE 08130', '0334124353', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charminet', 'Hector', '73 rue du général de Gaulle AUDRESSEIN 09800', '0593896893', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hourin', 'Aristote', '78 rue des Argonautes AUGIREIN 09800', '0560183642', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Khan', 'Anne-Jeanne', '20 rue Commandant Hériot BEAUMONT-EN-BEINE 02300', '0335062492', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Anne-Jeanne', '38 rue Louis Aragon SAINTE-MARIE 05150', '0413931222', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jankelevitch', 'Jordan', '96 rue Bonaparte SAINTE-MARIE 05150', '0419574602', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Brouzais', 'Cristophe', '65 rue de la recette HERBEUVAL 08370', '0353219537', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yanshen', 'Bénédicte', '2 rue des Armées FALAISE 08400', '0392106994', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Margot', 'sabine', '66 rue des Epines HOUDILCOURT 08190', '0396081849', 1, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frazier', 'Serge', '6 rue du stade NEUVILLE-LES-DAMES 01400', '0441736702', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rachock', 'Adelphe', '26 rue des Pigeons FEPIN 08170', '0383040737', 4, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framzaoui', 'Julienne', '89 rue Pasteur ASTON 09310', '0558895500', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquette', 'Austine', '96 rue St Denis BRIANCON 05100', '0442356662', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rétin', 'Anne-Marie', '88 rue du capitaine Fraquasse FLOING 08200', '0337248343', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Raminski', 'Austine', '86 rue des Lilas BAGERT 09230', '0564227642', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chesnikov', 'Aristote', '13 rue des Néfliers ARROUT 09800', '0578693214', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Reissa', '56 rue du Mont THIN-LE-MOUTIER 08460', '0379320791', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lirevien', 'sabine', '96 rue du général de Gaulle BELLOC 09600', '0517690862', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vispendieu', 'Marie', '62 rue Hector Berlioz SAVOURNON 05700', '0443661423', 4, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ronsart', 'Irénée', '68 rue de la pointe BARENTON-SUR-SERRE 02270', '0313123217', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Arditi', 'Adrien', '2 rue des hirondelles HAUTEVILLE 02120', '0385350100', 2,
        02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Farmin', 'Caline', '13 rue du Mont SAINT-FIRMIN 05800', '0439120333', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zomar', 'Camille', '38 rue des Chantereines MAYOT 02800', '0390403626', 6, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotland', 'Ingrid', '73 rue des gatinnes SAINT-ANDRE-DE-ROSANS 05150', '0455695337', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zola', 'Jordan', '47 rue de Paris ROCHEBRUNE 05190', '0488575731', 3, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Favriellé', 'Andrew', '40 rue Anatole France LAUNOIS-SUR-VENCE 08430', '0395797173', 8, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Aline', '27 rue des Anges SAINT-FIRMIN 05800', '0454426212', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Aurèle', '87 rue de Poligny SAINT-ANDRE-DE-ROSANS 05150', '0437604768', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Carole', '17 rue Debussy AVANCON 05230', '0435416748', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Adelphe', '74 rue des Néfliers AUBENTON 02500', '0369486130', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'Irénée', '85 rue du capitaine Crochet JOIGNY-SUR-MEUSE 08700', '0397935550', 8, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopez', 'Aurélien', '92 rue des oiseaux SAVOURNON 05700', '0452076802', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotland', 'John', '74 rue des oiseaux BILLIAT 01200', '0463193696', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Format', 'Jules', '84 rue du stade OYONNAX 01100', '0430814652', 6, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hourin', 'Robert', '46 rue des Accacias OYONNAX 01100', '0456783280', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hatiche', 'Carole', '18 rue de la Tour NEUVILLE-LES-DAMES 01400', '0411713298', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Faure', 'Firmin', '73 rue du Mont ARROUT 09800', '0532011995', 2, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Amélie', '79 rue Lampion SAINT-LAURENT-SUR-SAONE 01750', '0499820900', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'Patrice', '14 rue des Lilas CHEZY-SUR-MARNE 02570', '0310790961', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scott', 'Martial', '32 rue de la poste JOIGNY-SUR-MEUSE 08700', '0351863890', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Astoria', 'John', '81 rue Edouard Hériot MAYOT 02800', '0361434057', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Roulède', 'Prosper', '99 rue des Pigeons SIGOYER 05130', '0420048322', 3, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Camille', '88 rue des oiseaux JUNIVILLE 08310', '0370063871', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Adrien', '21 rue de la rose AX-LES-THERMES 09110', '0513336137', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gaudillot', 'Victor', '86 rue des Armées DOMMARTIN 01380', '0447458241', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'Bertrand', '91 rue de la rose FEPIN 08170', '0398107919', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gueret', 'Serge', '58 rue Pernod MONCEAU-SUR-OISE 02120', '0322992429', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Julienne', '93 rue des Néfliers MONCEAU-SUR-OISE 02120', '0348940958', 3, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radosky', 'Caline', '8 rue des Anges FEPIN 08170', '0364882312', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Françoise', '76 rue de Marigny CAMON 09500', '0522112610', 8, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Françoise', '3 rue des Anges AUBENTON 02500', '0397776971', 2, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Serge', '92 rue de Paris THIN-LE-MOUTIER 08460', '0365834913', 4, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Prosper', '24 rue de du général Scott BRIANCON 05100', '0493163850', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fourmiret', 'Dominique', '4 rue Hector Berlioz AX-LES-THERMES 09110', '0585018637', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hatiche', 'Adrien', '30 rue Agniel SAINT-FIRMIN 05800', '0483927775', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Adelphe', '4 rue des Pigeons BARZY-SUR-MARNE 02850', '0391947902', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gullit', 'sabine', '9 rue du Mont BRIANCON 05100', '0423613710', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vipère', 'Anne-Lucie', '81 rue des Lilas ABBECOURT 02300', '0357752522', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epriniche', 'Aurèle', '78 rue du renard SAINT-LAURENT-SUR-SAONE 01750', '0499152521', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Julienne', '16 rue de la gare BELLOC 09600', '0567014080', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Aurélien', '41 rue des Anses bleues ASTON 09310', '0528108863', 8, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shouchen', 'François', '52 rue des Epines ATTILLY 02490', '0395338199', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Bénédicte', '88 rue du renard ORCIERES 05170', '0452809250', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epriniche', 'Vénus', '84 rue des Armées MONTIGNY-SUR-MEUSE 08170', '0332562475', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Camille', '20 rue Anatole France MACHAULT 08310', '0394066862', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Carole', '90 rue Bonaparte OYONNAX 01100', '0446953066', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chemkaoui', 'Cristophe', '22 rue Perdue AX-LES-THERMES 09110', '0533152140', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sérénice', 'Anne-Laure', '73 rue Agniel BOURG-EN-BRESSE 01000', '0434367086', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Merlieux', 'Martial', '61 rue des Cavaux SAINT-LAURENT-SUR-SAONE 01750', '0460367150', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Certifat', 'Aurélien', '44 rue des Epines OYONNAX 01100', '0439758191', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Azria', 'Aude', '98 rue des Accacias SIGOYER 05130', '0497650512', 8, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'sabine', '61 rue de la Pergolat AUDRESSEIN 09800', '0566668732', 4, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rachock', 'Jules', '45 rue du capitaine Crochet EVIGNY 08090', '0351073860', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shouchen', 'Rodolphe', '89 rue des oiseaux BOURG-EN-BRESSE 01000', '0436599230', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Béronze ', 'Habib', '97 rue Pernod AZY-SUR-MARNE 02400', '0380003737', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Merlieux', 'Bernard', '81 rue des Epines SAINT-CREPIN 05600', '0477707175', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Habib', '83 rue Malraux ABBECOURT 02300', '0310290366', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zebitoun', 'Mohammed', '70 rue du 14 juillet MONT-LAURENT 08130', '0398765209', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassan', 'François', '71 rue du 14 juillet SAINT-SAUVEUR 05200', '0418376454', 4, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bouglieux', 'Rodolphe', '99 rue Alphonse Daudet YONCQ 08210', '0367093394', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglomert', 'Catherine', '4 rue des Armées AUBENTON 02500', '0368054817', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Format', 'Bernard', '64 rue Commandant Hériot TRAVECY 02800', '0315061114', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chemkaou', 'Armelle', '79 rue des Epines EVIGNY 08090', '0334511766', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Arvis', 'Julie', '13 rue de la pointe ASTON 09310', '0518564010', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmieux', 'Dominique', '62 rue Malraux AUGIREIN 09800', '0585303807', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Amoudi', 'Charles', '71 rue Anatole France CAMON 09500', '0569559189', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotbel', 'Cristophe', '85 rue des Argonautes AZY-SUR-MARNE 02400', '0316188975', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charles', 'Dominique', '21 rue des Artistes BELLEY 01300', '0428818011', 8, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harshill', 'Précilia', '82 rue Victor Hugo LAVAL-MORENCY 08150', '0391802125', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermat', 'André', '87 rue Anatole France YONCQ 08210', '0311956610', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chastidien', 'Fernand', '37 rue du général de Gaulle AUGIREIN 09800', '0517286774', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'Hamed', '72 rue des hirondelles AGUILCOURT 02190', '0334618532', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Berzinne', 'Hector', '20 rue du capitaine Fraquasse BELLEY 01300', '0447089672', 7, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Patricia', '9 rue des gatinnes CHALLES 01450', '0489226737', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yoggi', 'Aline', '12 rue des Anges BRIANCON 05100', '0498699637', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassolette', 'Austine', '37 rue des Armées SIGOYER 05130', '0485539010', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Hypolite', '33 rue de Paris TRAVECY 02800', '0319460470', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotland', 'Fernand', '80 rue du Mont BAGERT 09230', '0570483785', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Festina', 'Anne-Sophie', '18 rue de la recette FLOING 08200', '0335293346', 5, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Bénédicte', '71 rue des pyramides MONT-LAURENT 08130', '0364431472', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'John', '35 rue Mallarmé ATTILLY 02490', '0384830087', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Patrick', '97 rue du général de Gaulle AUBENTON 02500', '0378805449', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Béronzelle ', 'Alice', '3 rue des Lilas ABBECOURT 02300', '0338216554', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Khan', 'Jérome', '67 rue Perdue BEDEILLE 09230', '0527487962', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Liorehen', 'Anne-Jeanne', '91 rue Albert Camus SAINT-CREPIN 05600', '0464885309', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Azoulais', 'Robert', '73 rue Pasteur BOURG-EN-BRESSE 01000', '0451252312', 2,
        01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Marie', '51 rue Victor Hugo JOIGNY-SUR-MEUSE 08700', '0328058400', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Bénédicte', '37 rue Mallarmé SAINT-CREPIN 05600', '0472480246', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazile', 'Hypolite', '97 rue Malraux SAINTE-MARIE 05150', '0471019122', 3, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Razaoui', 'Anne-Marie', '21 rue Blainville MESSINCOURT 08110', '0315472355', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zola', 'Fatima', '32 rue des Armées MEZIERES-SUR-OISE 02240', '0335733742', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harshill', 'sabine', '52 rue des Pigeons PELVOUX 05340', '0424219942', 6, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquette', 'Vénus', '96 rue des Chantereines FRESSANCOURT 02800', '0359036944', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hatiche', 'Victor', '96 rue de Paris BETTANT 01500', '0478464491', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pletziglass', 'Aurèle', '34 rue des oiseaux NEUVILLE-LES-DAMES 01400', '0437142230', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Béronzelle ', 'Reissa', '89 rue des Pigeons PELVOUX 05340', '0414138297', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ben Harfa', 'Camille', '5 rue des Anges BUZAN 09800', '0550828415', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Alprousky', 'Marie', '58 rue Victor Hugo BOULIGNEUX 01330', '0432323455', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ferdinand', 'Camille', '89 rue Beaudelaire AUBENTON 02500', '0341803965', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Roulède', 'Fatima', '59 rue Bonaparte EVIGNY 08090', '0326409640', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sérénice', 'Anne-Jeanne', '10 rue du capitaine Fraquasse MESSINCOURT 08110', '0315685825', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'Alice', '94 rue des Cyprés SAINT-FIRMIN 05800', '0492845898', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Casson', 'Aline', '83 rue des Cavaux CHALLES 01450', '0477868457', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Françoise', '3 rue des gatinnes FRESSANCOURT 02800', '0310422807', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pistache', 'Béatrice', '86 rue des Accacias MONTIGNY-SUR-MEUSE 08170', '0351114264', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bridel', 'Anne-Ange', '17 rue des Accacias JOIGNY-SUR-MEUSE 08700', '0354449959', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassin', 'Alain', '61 rue de du général Scott QUATRE-CHAMPS 08400', '0395171820', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Alain', '10 rue Alphonse Daudet AGUILCOURT 02190', '0378125914', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Habrielle', 'Aude', '73 rue Mallarmé SORBIERS 05150', '0415973212', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Azoulais', 'Aurélien', '5 rue des pyramides SAVINES-LE-LAC 05160', '0417672103', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gaudillot', 'Amiel', '44 rue Victor Hugo SIGOYER 05130', '0470456938', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'Aude', '45 rue des Lilas FLOING 08200', '0347310971', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charminet', 'Catherine', '88 rue Alphonse Daudet ARROUT 09800', '0578689528', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fugasse', 'Alain', '57 rue Petit SAINT-LAURENT-SUR-SAONE 01750', '0448765649', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zitoune', 'Fatima', '47 rue Lampion OYONNAX 01100', '0460692244', 8, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Certifat', 'Anaelle', '12 rue Albert Camus AX-LES-THERMES 09110', '0569661155', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hallouche', 'Julie', '3 rue de la pointe SAINT-CREPIN 05600', '0435145304', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Alizée', '91 rue Blainville OYONNAX 01100', '0424443942', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chesnikov', 'Anselme', '58 rue Victor Hugo LAVAL-MORENCY 08150', '0387649400', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Rodolphe', '57 rue des Epines AZY-SUR-MARNE 02400', '0397983251', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harviche', 'Aristote', '2 rue de Poligny FALAISE 08400', '0379304135', 7, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Anne-Marie', '73 rue du capitaine Crochet CHALLES 01450', '0459580046', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Rosalie', '88 rue Hector Berlioz SAINT-LAURENT-SUR-SAONE 01750', '0460756612', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charminet', 'Julienne', '54 rue du 14 juillet BEAUMONT-EN-BEINE 02300', '0357974621', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Bernard', '28 rue des perles blanches MONT-LAURENT 08130', '0350608229', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yanshen', 'Ingrid', '14 rue de Paris MONTCEAUX 01090', '0490462674', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sadot', 'Alice', '84 rue Albert Camus BLYES 01150', '0486949300', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chastidien', 'Reissa', '71 rue des Cavaux FLOING 08200', '0371858489', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vispendieu', 'Anselme', '67 rue Bonaparte MESSINCOURT 08110', '0353311714', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Roland', 'Aristote', '67 rue du renard BUZAN 09800', '0550911167', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazile', 'Jules', '50 rue des Cyprés BARENTON-SUR-SERRE 02270', '0377237270', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Thardieux', 'François', '98 rue du stade MACHAULT 08310', '0371879519', 8, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Magellan', 'Patricia', '8 rue des Pigeons CHEZY-SUR-MARNE 02570', '0360797082', 8, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radesky', 'Reissa', '33 rue Beaudelaire BAGERT 09230', '0551753977', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquette', 'Rosalie', '3 rue des Cavaux AMBRIEF 02200', '0325834365', 6, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rodriguez', 'Irénée', '16 rue Bonaparte AVANCON 05230', '0429279003', 1, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Raminsky', 'Armelle', '24 rue des Néfliers QUATRE-CHAMPS 08400', '0371872007', 8, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ricardo', 'Serge', '30 rue Albert Camus ARROUT 09800', '0563717429', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kobel', 'Bénédicte', '29 rue Victor Hugo AUDRESSEIN 09800', '0525469712', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Razaoui', 'Marie', '15 rue de Paris AUBENTON 02500', '0396696281', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Armouche', 'Charles-Edouard', '12 rue St Denis MONTCEAUX 01090', '0492465629', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'Victor', '12 rue des Anses bleues SAVINES-LE-LAC 05160', '0417736200', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fylbouni', 'Johnny', '35 rue du stade ASTON 09310', '0575380150', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chakraoui', 'Cristophe', '86 rue Mallarmé ORCIERES 05170', '0488800978', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermontin', 'Julien', '38 rue Anatole France AUBENTON 02500', '0318610565', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'François', '32 rue du Mont REOTIER 05600', '0425989993', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sérénice', 'Anaelle', '74 rue de la gare FLEVILLE 08250', '0325218232', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kan', 'Anselme', '86 rue Victor Hugo MESSINCOURT 08110', '0381133645', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fort', 'Cristophe', '86 rue Pasteur NEUVILLE-LES-DAMES 01400', '0432667697', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chemkaou', 'sabine', '75 rue des Pigeons BEAUMONT-EN-BEINE 02300', '0376547227', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sibroton', 'Précilia', '66 rue Malraux BUZAN 09800', '0513300693', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Catherine', '27 rue de la Pergolat MONTCEAUX 01090', '0421383743', 5, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Ferdinand', 'Alice', '37 rue de Paris CHEZY-SUR-MARNE 02570', '0356410090', 7, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gullit', 'Habib', '71 rue Bonaparte AGUILCOURT 02190', '0350823331', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Alain', '77 rue des Accacias BRIANCON 05100', '0498867503', 6, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Patricia', '3 rue de la Tour BILLIAT 01200', '0428025797', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ricardo', 'Austine', '44 rue des Néfliers CHEZY-SUR-MARNE 02570', '0363569859', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'André', '30 rue Hector Berlioz SAINT-FIRMIN 05800', '0444332279',
        2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Casson', 'Johnny', '36 rue Blainville AUBENTON 02500', '0395155855', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Razaoui', 'Aurèle', '10 rue du général de Gaulle ARROUT 09800', '0554301843', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Krevette', 'Alizée', '35 rue des Pigeons MONT-LAURENT 08130', '0340963504', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Fatima', '16 rue Commandant Hériot BANCIGNY 02140', '0334753913', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Adrien', '2 rue Commandant Hériot MONCEAU-SUR-OISE 02120', '0352372278',
        2, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Amoudi', 'Andrew', '26 rue des pyramides BOULIGNEUX 01330', '0469707196', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Anémone', '9 rue des Epines BLYES 01150', '0440301616', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bonieck', 'Cristophe', '69 rue de la recette DOMMARTIN 01380', '0495802726', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Falmino', 'Jules', '24 rue Perdue THIN-LE-MOUTIER 08460', '0328900829', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Castro', 'Aurélien', '66 rue des Anges BOULIGNEUX 01330', '0417563891', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charles', 'François', '1 rue Blainville HAUTEVILLE 02120', '0317885243', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lirevien', 'Irénée', '64 rue des perles blanches QUATRE-CHAMPS 08400', '0316251329', 5, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestor', 'Camille', '20 rue du stade AZY-SUR-MARNE 02400', '0339478573', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Adelphe', '51 rue des gatinnes BRIANCON 05100', '0412521015', 2,
        05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmieux', 'Andrew', '14 rue Hector Berlioz BRIANCON 05100', '0448191946', 6, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rachock', 'Mohammed', '47 rue Pernod YONCQ 08210', '0371193497', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanzert', 'Aurèle', '68 rue des Chantereines BUZAN 09800', '0563311027', 8, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oberlieux', 'Patricia', '72 rue des pyramides ARROUT 09800', '0551116863', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('GrosPierre', 'Aude', '35 rue de Poligny CHABESTAN 05400', '0454617092', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Jérémy', '10 rue Malraux FALAISE 08400', '0355875878', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Politzer', 'Jérémy', '12 rue des Anges SAINT-LAURENT-SUR-SAONE 01750', '0476010116', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Faure', 'Alain', '86 rue de Marigny AUDRESSEIN 09800', '0584761714', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'Sophie', '54 rue des Epines SAINTE-MARIE 05150', '0447268257', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Habrielle', 'Anne-Ange', '44 rue Malraux DOMMARTIN 01380', '0420664795', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Anaelle', '65 rue des Accacias BILLIAT 01200', '0463159777', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Julien', '26 rue Pernod AUDRESSEIN 09800', '0564023565', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Casson', 'Jules', '5 rue Albert Camus BAGERT 09230', '0553330696', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jamgotchian', 'Aristote', '71 rue Petit OYONNAX 01100', '0459707313', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framzaoui', 'Fernand', '59 rue des Cavaux YONCQ 08210', '0370679861', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hansbern', 'Anselme', '89 rue de la rose THIN-LE-MOUTIER 08460', '0329785730', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ligne', 'Firmin', '36 rue Blainville MAYOT 02800', '0335413346', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Hypolite', '77 rue de Paris OYONNAX 01100', '0445547469', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Cristophe', '24 rue de la Pergolat THIN-LE-MOUTIER 08460', '0394637980', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Habib', '28 rue des Chantereines FEPIN 08170', '0370382521', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Amiel', '14 rue Petit AUBENTON 02500', '0324206273', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermontin', 'Béatrice', '34 rue de la rose AVANCON 05230', '0441382007', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Béatrice', '98 rue du capitaine Crochet AX-LES-THERMES 09110', '0583031525', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hatiche', 'Béatrice', '7 rue Hector Berlioz FRESSANCOURT 02800', '0368437171', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Magellan', 'Fernand', '91 rue Pernod DOMMARTIN 01380', '0417334765', 4, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Newmann', 'Anselme', '82 rue St Denis BOURG-EN-BRESSE 01000', '0467462959', 2,
        01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radronck', 'Jérémie', '80 rue Beaudelaire HOUDILCOURT 08190', '0391017675', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ben Harfa', 'Fatima', '88 rue du général de Gaulle DOMMARTIN 01380', '0436582548', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Marie', '65 rue Edouard Hériot ABBECOURT 02300', '0316457802', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chakraoui', 'Amiel', '75 rue des Accacias MAYOT 02800', '0348266841', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harshill', 'Anne-Lucie', '89 rue de la Pergolat SIGOYER 05130', '0423854231', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Patrice', '38 rue Pasteur AVANCON 05230', '0433495288', 2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassolette', 'Victor', '3 rue des Chantereines AMBRIEF 02200', '0313285058', 2,
        02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jaoulle', 'John', '99 rue du capitaine Fraquasse MAYOT 02800', '0325788039', 3, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Palminin', 'Anne', '59 rue des Pigeons CEYZERIAT 01250', '0414968284', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznavourian', 'Aurèle', '48 rue Anatole France SIGOYER 05130', '0498986897', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gueret', 'Firmin', '2 rue de la Tour AZY-SUR-MARNE 02400', '0334984702', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Mestre', 'Ingrid', '74 rue des Pigeons BELLOC 09600', '0575501098', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zelniky', 'Prosper', '53 rue de Paris BARENTON-SUR-SERRE 02270', '0390633950', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Hamouti', 'Anne-Lucie', '19 rue du renard FRESSANCOURT 02800', '0380522884', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ben Harfa', 'Aline', '76 rue Louis Aragon BOULIGNEUX 01330', '0458483440', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lirevien', 'Serge', '79 rue Petit BUZAN 09800', '0597720760', 7, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sadot', 'Carole', '87 rue de Paris YONCQ 08210', '0386136458', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglebert', 'Aristote', '89 rue du stade BOURG-EN-BRESSE 01000', '0495804047', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zelniky', 'Annie', '81 rue de Poligny ORCIERES 05170', '0484719957', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopes', 'Anne-Ange', '89 rue Debussy VAUX-CHAMPAGNE 08130', '0398454558', 4, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmieux', 'Vénus', '19 rue Bonaparte AUDRESSEIN 09800', '0576161788', 4, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Irénée', '16 rue de Paris OYONNAX 01100', '0438645340', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Jérémie', '61 rue Hector Berlioz CHABESTAN 05400', '0488168776', 8, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Aurèle', '64 rue des Epines NEUVILLE-LES-DAMES 01400', '0498004744', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Restiffe', 'Fatima', '21 rue des Chantereines LAVAL-MORENCY 08150', '0397521639', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Amoudi', 'André', '35 rue Lampion BOURG-EN-BRESSE 01000', '0473219689', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Loulianov', 'Marie', '17 rue des Accacias LAUNOIS-SUR-VENCE 08430', '0369193051', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zelniky', 'Astine', '94 rue Malraux HAUTEVILLE 02120', '0335672541', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Patricia', '75 rue du général de Gaulle FALAISE 08400', '0359521971', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ferdinand', 'Charles', '40 rue de la poste JOIGNY-SUR-MEUSE 08700', '0395476454', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglomert', 'Anne-Laure', '75 rue Victor Hugo MONTCY-NOTRE-DAME 08090', '0333999479', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yansen', 'Alizée', '51 rue Agniel YONCQ 08210', '0352293505', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Capliez', 'Françoise', '9 rue Malraux SAINT-ANDRE-DE-ROSANS 05150', '0433874591', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chemkaoui', 'Anne-Marie', '90 rue Mallarmé MAYOT 02800', '0363076320', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Certifat', 'Jimmy', '10 rue Hector Berlioz CHABESTAN 05400', '0479570050', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jankelevitch', 'Aurélien', '67 rue des Princes AMBRIEF 02200', '0326868610', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Béronzelle ', 'Anaelle', '86 rue du Mont MONTCEAUX 01090', '0432538873', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chakraoui', 'François', '23 rue de Paris BARZY-SUR-MARNE 02850', '0338114774', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazile', 'François', '33 rue Victor Hugo BELLOC 09600', '0587084727', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harviche', 'Catherine', '70 rue Malraux BRIANCON 05100', '0446591175', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ronsart', 'Amélie', '26 rue des Accacias MONT-LAURENT 08130', '0347054500', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquet', 'Charles', '77 rue des perles blanches BETTANT 01500', '0413532750', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Breton', 'Adelphe', '96 rue des Argonautes REOTIER 05600', '0488831908', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopes', 'Carole', '83 rue du renard AX-LES-THERMES 09110', '0540901782', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Labatiste', 'Rodolphe', '33 rue Commandant Mouchotte THIN-LE-MOUTIER 08460', '0324607170', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Nazaoui', 'Yoan', '42 rue Anatole France BEZAC 09100', '0597093071', 5, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopez', 'Firmin', '66 rue Commandant Hériot AX-LES-THERMES 09110', '0560293085', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Astoria', 'Caline', '54 rue de la pointe SAINT-SAUVEUR 05200', '0476324085', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Capliez', 'Amélie', '12 rue du capitaine Fraquasse BARZY-SUR-MARNE 02850', '0347886278', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Nohan', '87 rue du 14 juillet HERBEUVAL 08370', '0350146870', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Raminsky', 'Yoan', '8 rue de Paris MONCEAU-SUR-OISE 02120', '0358800447', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Victor', '26 rue Hector Berlioz ARANDAS 01230', '0426016480', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Faure', 'Bertrand', '94 rue des gatinnes MONTCEAUX 01090', '0480493919', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chesnikov', 'Précilia', '56 rue du capitaine Crochet AUDRESSEIN 09800', '0537599041', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lièvremont', 'Astine', '58 rue des perles blanches YONCQ 08210', '0380622197', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'Anne-Sophie', '52 rue des Artistes FALAISE 08400', '0352041231', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chevalier', 'Anselme', '85 rue des Pigeons AGUILCOURT 02190', '0387135673', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sursarshill', 'Julie', '97 rue des Lilas OYONNAX 01100', '0493949488', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pletziglass', 'Andrée', '76 rue Alphonse Daudet LAUNOIS-SUR-VENCE 08430', '0355911277', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ronsart', 'Rosalie', '28 rue des Argonautes SAINTE-MARIE 05150', '0470907768', 1, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Guimauve', 'Alizée', '78 rue de Marigny HERBEUVAL 08370', '0347904226', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sabatier', 'Adelphe', '72 rue Albert Camus SAINT-FIRMIN 05800', '0474088419', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chastidien', 'Rodolphe', '59 rue Pasteur ORCIERES 05170', '0464480776', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Azria', 'Martin', '14 rue Perdue AUBENTON 02500', '0377909038', 8, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Roland', 'Anne-Ange', '89 rue Pasteur SIGOYER 05130', '0461827483', 1, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Liorehen', 'Marie', '51 rue des Epines ABBECOURT 02300', '0326934571', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zidanne', 'Julienne', '3 rue des Artistes BLYES 01150', '0413911989', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Homar', 'Amélie', '45 rue des Cavaux ABBECOURT 02300', '0372174885', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rachock', 'Jules', '18 rue Agniel AUBENTON 02500', '0368418443', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'Aurèle', '64 rue de Poligny BRIANCON 05100', '0484091392', 8, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopes', 'Bertrand', '68 rue de la gare BOURG-EN-BRESSE 01000', '0416521067', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestoriat', 'Jimmy', '66 rue de Paris OYONNAX 01100', '0419790693', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Nohan', '55 rue Victor Hugo BANCIGNY 02140', '0350319392', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prouteau', 'Caline', '96 rue Perdue CAMON 09500', '0540178028', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pistache', 'André', '34 rue des Princes ROCHEBRUNE 05190', '0444668151', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Politzer', 'Hector', '75 rue des Anses bleues SAINT-LAURENT-SUR-SAONE 01750', '0478936977', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Précilia', '39 rue Petit SAINT-LAURENT-SUR-SAONE 01750', '0456796681', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kérouanne', 'Gilles', '11 rue des Pigeons NEUVILLE-LES-DAMES 01400', '0418340885', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Jordan', '53 rue des Anses bleues PELVOUX 05340', '0474792387', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Thardieux', 'Julien', '76 rue Pasteur PELVOUX 05340', '0439307843', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'François', '83 rue Petit BRIANCON 05100', '0481669712', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Farahoui', 'Firmin', '69 rue de la Tour AUGIREIN 09800', '0561526750', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prouteau', 'Bernard', '50 rue Malraux MONCEAU-SUR-OISE 02120', '0330404637', 2,
        02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Aline', '63 rue du général de Gaulle MONTCY-NOTRE-DAME 08090', '0330296222', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yoggi', 'Anne-Sophie', '28 rue du général de Gaulle BRIANCON 05100', '0466993498', 6, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durieux', 'Bernard', '47 rue du général de Gaulle CAMON 09500', '0534440216', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Format', 'Anne-Marie', '15 rue des Princes ASTON 09310', '0584747640', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bretonnot', 'Aristote', '27 rue des Cavaux FEPIN 08170', '0333376588', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('GrosJean', 'John', '41 rue Commandant Mouchotte HAUTEVILLE 02120', '0328740889', 3, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'Irénée', '42 rue Agniel OYONNAX 01100', '0447938676', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Farahoui', 'Martin', '67 rue Agniel NEUVILLE-LES-DAMES 01400', '0412803539', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sibroton', 'Rosalie', '15 rue Edouard Hériot ARROUT 09800', '0553692792', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Gilles', '64 rue du Mont HAUTEVILLE 02120', '0310558221', 6, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jaoulle', 'Aude', '25 rue des hirondelles BLYES 01150', '0415240773', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Reissa', '65 rue du général de Gaulle AZY-SUR-MARNE 02400', '0374955418', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oulianov', 'Andrée', '30 rue du 14 juillet AVANCON 05230', '0463468177', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipion', 'Julien', '47 rue Agniel JOIGNY-SUR-MEUSE 08700', '0334063627', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestor', 'Reissa', '62 rue de la Tour ROCHEBRUNE 05190', '0480473643', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fourmiret', 'Sophie', '91 rue Petit AUBENTON 02500', '0348745022', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Patricia', '95 rue Pasteur HERBEUVAL 08370', '0354297793', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oulianov', 'Reissa', '25 rue Perdue AX-LES-THERMES 09110', '0540152929', 8, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopes', 'Armelle', '57 rue des Pigeons SAINT-FIRMIN 05800', '0479849596', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mingalle', 'Irénée', '83 rue des pyramides FLEVILLE 08250', '0312351408', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kobel', 'Anne-Laure', '58 rue des Argonautes ATTILLY 02490', '0344455589', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Patrick', '28 rue des Cyprés OYONNAX 01100', '0456081235', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hallouche', 'Ines', '65 rue Mallarmé TRAVECY 02800', '0344024000', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scott', 'Julie', '30 rue de du général Scott SAINT-FIRMIN 05800', '0440937400', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'Aurélien', '92 rue des Cyprés BEZAC 09100', '0521006225', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framaouzy', 'Martial', '41 rue du général de Gaulle AUGIREIN 09800', '0569674646', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazile', 'Amiel', '6 rue Malraux HAUTEVILLE 02120', '0336447283', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Thardieux', 'Jérémy', '62 rue Lampion BEZAC 09100', '0526185264', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fylbouni', 'Cristophe', '88 rue du général de Gaulle BOULIGNEUX 01330', '0435544779', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fort', 'Ingrid', '6 rue du 14 juillet DOMMARTIN 01380', '0442048091', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Jimmy', '50 rue Anatole France MACHAULT 08310', '0332316186', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Lazio', 'Aline', '68 rue des Artistes NEUVILLE-LES-DAMES 01400', '0431882334', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yoggi', 'Irénée', '34 rue des Chantereines BEAUMONT-EN-BEINE 02300', '0337016124', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jalouve', 'Gilles', '28 rue du Mont JOIGNY-SUR-MEUSE 08700', '0356982229', 8, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Martinet', 'Irénée', '33 rue des perles blanches HOUDILCOURT 08190', '0399670344', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kan', 'Habib', '9 rue des gatinnes BEZAC 09100', '0521113468', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chermis', 'Cristophe', '18 rue Edouard Hériot CHALLES 01450', '0428126087', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chastidien', 'Aline', '87 rue de la Tour ORCIERES 05170', '0474417618', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ricardo', 'Julien', '20 rue des Chantereines SAINT-SAUVEUR 05200', '0430434976', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Anselme', '14 rue des Anges REOTIER 05600', '0441999912', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bredequin', 'Anne-Lucie', '47 rue Bonaparte AUGIREIN 09800', '0533497900', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopez', 'Alizée', '96 rue Albert Camus BAGERT 09230', '0519203974', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Béatrice', '97 rue Lampion TRAVECY 02800', '0350641861', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hemdaoui', 'Serge', '61 rue Mallarmé SAVINES-LE-LAC 05160', '0489512105', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Rodolphe', '43 rue des Princes ASTON 09310', '0513212527', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Adelphe', '80 rue des Princes AVANCON 05230', '0446646697', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Austine', '47 rue Pasteur BEZAC 09100', '0530872724', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Yoan', '55 rue des Cavaux AGUILCOURT 02190', '0324607617', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermontin', 'Gilles', '46 rue du stade MONT-LAURENT 08130', '0387328329', 2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zola', 'Aude', '98 rue des Cyprés SAINT-CREPIN 05600', '0458369404', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'Cristophe', '82 rue Hector Berlioz ARANDAS 01230', '0425003261', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pionneer', 'Jérémy', '21 rue des Princes MONT-LAURENT 08130', '0322135363', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lièvremont', 'Mohammed', '53 rue Pasteur THIN-LE-MOUTIER 08460', '0389514499', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ferdinand', 'Précilia', '38 rue Louis Aragon SAVINES-LE-LAC 05160', '0441180757', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charles', 'Françoise', '63 rue des Anges AX-LES-THERMES 09110', '0553742065', 3, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Festina', 'sabine', '18 rue Lampion MONTCEAUX 01090', '0474843880', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jaoulle', 'Julien', '50 rue des Chantereines REOTIER 05600', '0433213809', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Julie', '29 rue de du général Scott SAINT-ANDRE-DE-ROSANS 05150', '0450980762', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'Roby', '14 rue Mallarmé LAVAL-MORENCY 08150', '0350310027', 7, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Jérémy', '42 rue du capitaine Fraquasse JUNIVILLE 08310', '0361117640', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Anne-Laure', '63 rue Commandant Mouchotte BOURG-EN-BRESSE 01000', '0442277236', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Armouche', 'Anaelle', '21 rue des Cavaux CHEZY-SUR-MARNE 02570', '0388675304', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rastidien', 'Hamed', '74 rue Victor Hugo ARROUT 09800', '0541004550', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipion', 'Béatrice', '54 rue Victor Hugo FRESSANCOURT 02800', '0312941986', 5, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ferdinand', 'Françoise', '98 rue de la Tour MESSINCOURT 08110', '0317883763', 6, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Thardieux', 'Aristote', '73 rue des Anges BARENTON-SUR-SERRE 02270', '0369353331', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanzert', 'Johnny', '41 rue Victor Hugo FALAISE 08400', '0393642374', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Arvis', 'André', '59 rue de la Pergolat BAGERT 09230', '0570809688', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fourmiret', 'Carole', '49 rue de du général Scott HOUDILCOURT 08190', '0318196859', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Milliet', 'Armelle', '70 rue Mallarmé LAVAL-MORENCY 08150', '0330805895', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kan', 'François', '51 rue des Lilas SAINT-FIRMIN 05800', '0410879788', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Dusel', 'Anémone', '66 rue Commandant Mouchotte BRIANCON 05100', '0421542405', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framzaoui', 'Reissa', '73 rue de la Pergolat BRIANCON 05100', '0444698187', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pionneer', 'John', '2 rue des Princes SAVINES-LE-LAC 05160', '0431249814', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Catherine', '53 rue de Poligny BARZY-SUR-MARNE 02850', '0373513553', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Jules', '30 rue Malraux EVIGNY 08090', '0317625916', 6, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yanshen', 'Martin', '35 rue des perles blanches OYONNAX 01100', '0484949416', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Newmann', 'Rodolphe', '22 rue du stade AX-LES-THERMES 09110', '0597525447', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Patrick', '18 rue Perdue NEUVILLE-LES-DAMES 01400', '0454304156', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Bertrand', '65 rue des Anses bleues BELLOC 09600', '0522232477', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Capliez', 'Bernard', '70 rue des pyramides AX-LES-THERMES 09110', '0548800884', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zelniky', 'Rosalie', '9 rue Mallarmé SAINT-CREPIN 05600', '0470298666', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Roulède', 'Jordan', '36 rue Mallarmé MONCEAU-SUR-OISE 02120', '0337902134', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fourmiret', 'Jérémie', '27 rue de Paris TRAVECY 02800', '0321240986', 7, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Catherine', '25 rue du stade THIN-LE-MOUTIER 08460', '0373019942', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Homar', 'Précilia', '58 rue des Chantereines SORBIERS 05150', '0456138900', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cerpico', 'Roby', '14 rue des Princes REOTIER 05600', '0418201233', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hollidays', 'Roby', '7 rue du 14 juillet SAINT-FIRMIN 05800', '0435737841', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fournil', 'Alice', '21 rue du 14 juillet AUDRESSEIN 09800', '0549577626', 5, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fournil', 'Sophie', '12 rue Blainville BOULIGNEUX 01330', '0485824681', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Armelle', '87 rue des pyramides BANCIGNY 02140', '0380163229', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radronck', 'Cristophe', '44 rue St Denis ROCHEBRUNE 05190', '0421833954', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznakovitch', 'Reissa', '27 rue de la gare AUDRESSEIN 09800', '0525862994', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Astoria', 'Amélie', '41 rue des pyramides VAUX-CHAMPAGNE 08130', '0343900888', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Roulède', 'Andrew', '31 rue de la poste FLOING 08200', '0311338451', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Béronze ', 'Marie', '35 rue des gatinnes PELVOUX 05340', '0427092084', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Hamouti', 'Alice', '35 rue du renard AX-LES-THERMES 09110', '0579017565', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Loulianov', 'Jules', '90 rue de Paris VAUX-CHAMPAGNE 08130', '0386647121', 2,
        08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Falmino', 'Rosalie', '3 rue de Marigny AX-LES-THERMES 09110', '0552021678', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zidanne', 'Astine', '7 rue de la Pergolat BAGERT 09230', '0521392547', 2, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bonieck', 'Prosper', '90 rue Bonaparte YONCQ 08210', '0392674994', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Fernand', '42 rue Edouard Hériot ARROUT 09800', '0515601750', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Anne-Laure', '70 rue du Mont AZY-SUR-MARNE 02400', '0347195732', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Julien', '13 rue des Lilas BANCIGNY 02140', '0339249742', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Hypolite', '45 rue des Néfliers ORCIERES 05170', '0435503130', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jamgotchian', 'Irénée', '57 rue Hector Berlioz FEPIN 08170', '0399685398', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Reissa', '24 rue Hector Berlioz ARROUT 09800', '0564256388', 6, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radocky', 'Jimmy', '25 rue Albert Camus SAINT-LAURENT-SUR-SAONE 01750', '0442319187', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Protonne', 'Jérémie', '96 rue Anatole France MONT-LAURENT 08130', '0379511159', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zitoune', 'Victor', '37 rue de Marigny SAINTE-MARIE 05150', '0497549880', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Guimauve', 'Bertrand', '20 rue Pasteur BEDEILLE 09230', '0522586224', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epriniche', 'Julien', '44 rue Bonaparte BANCIGNY 02140', '0390688254', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Khan', 'Habib', '5 rue du stade AMBRIEF 02200', '0327960352', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopez', 'André', '69 rue Debussy MONCEAU-SUR-OISE 02120', '0363762717', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Casson', 'Hypolite', '20 rue Victor Hugo THIN-LE-MOUTIER 08460', '0387692474', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oumar', 'André', '27 rue des Accacias LAUNOIS-SUR-VENCE 08430', '0314089620', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznakovitch', 'Mohammed', '48 rue du 14 juillet AX-LES-THERMES 09110', '0557230819', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Roulède', 'Patrick', '38 rue du renard BILLIAT 01200', '0438986289', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Précilia', '3 rue des Epines AUGIREIN 09800', '0555523105', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Merlieux', 'Hamed', '43 rue des Epines HERBEUVAL 08370', '0332471585', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fournil', 'Anne-Marie', '26 rue de Paris SORBIERS 05150', '0480449197', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Liorehen', 'Amélie', '33 rue de Marigny BRIANCON 05100', '0429531221', 2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Festina', 'Précilia', '17 rue des pyramides MESSINCOURT 08110', '0383254238', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jamgotchian', 'Précilia', '24 rue Debussy BOURG-EN-BRESSE 01000', '0431348186',
        2, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charminet', 'Béatrice', '21 rue des perles blanches MONTCY-NOTRE-DAME 08090', '0314453519', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'Caline', '46 rue Mallarmé MONTCEAUX 01090', '0420799374', 2, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charlequin', 'Bénédicte', '90 rue Agniel YONCQ 08210', '0373069363', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Alain', '17 rue St Denis AGUILCOURT 02190', '0333695801', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harviche', 'Précilia', '34 rue Anatole France BETTANT 01500', '0412141785', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Anne-Laure', '24 rue Commandant Mouchotte REOTIER 05600', '0420893209', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hallouche', 'Françoise', '80 rue Albert Camus AMBRIEF 02200', '0373756074', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kérouanne', 'Caline', '30 rue des perles blanches SAINT-LAURENT-SUR-SAONE 01750', '0439831324', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pololsky', 'Victor', '14 rue des Lilas CHEZY-SUR-MARNE 02570', '0313300681', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mingalle', 'Aristote', '79 rue des Anses bleues ARANDAS 01230', '0420332660', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frazier', 'Johnny', '34 rue du renard FALAISE 08400', '0370553291', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rodriguez', 'Jérome', '28 rue Hector Berlioz ORCIERES 05170', '0443297062', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bredequin', 'Françoise', '88 rue du Mont FRESSANCOURT 02800', '0313654986', 7, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Labatiste', 'Anaelle', '48 rue des Argonautes ARROUT 09800', '0518603040', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Resti', 'Jérémie', '67 rue des gatinnes ARANDAS 01230', '0410422676', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Julie', '4 rue Anatole France DOMMARTIN 01380', '0496807830', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Guimauve', 'Jules', '62 rue de la Pergolat BOURG-EN-BRESSE 01000', '0487728945', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Amélie', '59 rue Louis Aragon CAMON 09500', '0591653123', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Johnny', '80 rue de du général Scott JOIGNY-SUR-MEUSE 08700', '0386814494', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Azria', 'Dominique', '35 rue des Epines MONTCEAUX 01090', '0463823233', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Azoulais', 'Amélie', '60 rue des gatinnes BILLIAT 01200', '0487102339', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mariveaux', 'Andrée', '20 rue de la Pergolat MONTCEAUX 01090', '0487833849', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Aristote', '74 rue des Néfliers SAINT-LAURENT-SUR-SAONE 01750', '0417675151', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmieux', 'Anémone', '78 rue Victor Hugo BRIANCON 05100', '0430859878', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Vispendieu', 'Amiel', '2 rue Perdue AUBENTON 02500', '0334550712', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Farahoui', 'Aline', '88 rue de Poligny FRESSANCOURT 02800', '0399301475', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Liorehen', 'Prosper', '18 rue des hirondelles BOURG-EN-BRESSE 01000', '0463936581', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'Marie', '47 rue Perdue BRIANCON 05100', '0464689414', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Hector', '91 rue des hirondelles AX-LES-THERMES 09110', '0583375798', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Jérémie', '19 rue Commandant Hériot CEYZERIAT 01250', '0426848534', 3, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Brouzais', 'Aristote', '96 rue du Mont ROCHEBRUNE 05190', '0486526998', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frazier', 'Hypolite', '92 rue Beaudelaire JOIGNY-SUR-MEUSE 08700', '0364925968',
        2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassolette', 'Jules', '56 rue du Mont BILLIAT 01200', '0459159687', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Anne-Lucie', '94 rue Agniel BILLIAT 01200', '0497364094', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Favriellé', 'Reissa', '37 rue de la pointe HAUTEVILLE 02120', '0398806683', 5, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Camus', 'Patricia', '5 rue St Denis ABBECOURT 02300', '0355040100', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mingalle', 'Anne-Lucie', '90 rue Lampion YONCQ 08210', '0399778947', 2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Khan', 'Jérémy', '75 rue des Cavaux SAINT-LAURENT-SUR-SAONE 01750', '0466069822', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charmis', 'Nohan', '9 rue des Epines SAVOURNON 05700', '0411774310', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassin', 'Hector', '87 rue Malraux LAUNOIS-SUR-VENCE 08430', '0359717547', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bonieck', 'Aline', '14 rue de la rose BARZY-SUR-MARNE 02850', '0356584101', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Sophie', '66 rue du 14 juillet AVANCON 05230', '0413861599', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pionneer', 'Dominique', '72 rue des Argonautes BRIANCON 05100', '0465512769', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Anne', '78 rue des hirondelles PELVOUX 05340', '0495946694', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Perronet', 'Ines', '15 rue des Anses bleues MESSINCOURT 08110', '0312418493', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Resti', 'Anémone', '21 rue Commandant Hériot BELLEY 01300', '0465513099', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bonieck', 'Sophie', '54 rue du 14 juillet AX-LES-THERMES 09110', '0548859466', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'Irénée', '48 rue des perles blanches BRIANCON 05100', '0424065321', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radosky', 'John', '34 rue du Mont BETTANT 01500', '0441330897', 1, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Aurélien', '61 rue Pasteur MAYOT 02800', '0356229245', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'sabine', '14 rue des Anges OYONNAX 01100', '0456485843', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oberlieux', 'Camille', '67 rue Alphonse Daudet BUZAN 09800', '0531797312', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fylbouni', 'Mohammed', '6 rue des Pigeons BARENTON-SUR-SERRE 02270', '0370234499',
        2, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Homar', 'Amiel', '23 rue Hector Berlioz BETTANT 01500', '0487520515', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Azria', 'Vénus', '90 rue des Lilas HAUTEVILLE 02120', '0394086731', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sidot', 'Hypolite', '80 rue de la gare ARANDAS 01230', '0440645072', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rastidien', 'Anémone', '22 rue des Cyprés BLYES 01150', '0470785500', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oulianov', 'Rodolphe', '24 rue des Anges BELLEY 01300', '0459668577', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanzert', 'Julie', '88 rue des Pigeons JUNIVILLE 08310', '0391920541', 2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zelniky', 'Alice', '6 rue des hirondelles SAINT-CREPIN 05600', '0478485015', 2,
        05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Guimauve', 'Carole', '78 rue des Pigeons SAINTE-MARIE 05150', '0433025835', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglebert', 'Anne-Ange', '19 rue de la pointe PELVOUX 05340', '0411070122', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Braquet', 'Ingrid', '35 rue Malraux QUATRE-CHAMPS 08400', '0370478563', 5, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Alain', '27 rue du stade SAINT-LAURENT-SUR-SAONE 01750', '0492470117', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Vénus', '29 rue de Paris AVANCON 05230', '0424123589', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Bernard', '53 rue de la poste BAGERT 09230', '0550830599', 8, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Charlequin', 'Serge', '52 rue de Paris SAINT-FIRMIN 05800', '0472679599', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermat', 'Anaelle', '92 rue Blainville SAINT-ANDRE-DE-ROSANS 05150', '0474041924', 6, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sibroton', 'Charles', '47 rue Beaudelaire AMBRIEF 02200', '0356493035', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Hamouti', 'Fatima', '73 rue des Anges FRESSANCOURT 02800', '0390943061', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sadot', 'André', '95 rue Edouard Hériot SAINT-FIRMIN 05800', '0483174531', 1, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frazier', 'André', '24 rue Louis Aragon REOTIER 05600', '0476877380', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'Ines', '71 rue Edouard Hériot ASTON 09310', '0543065471', 1, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Irénée', '72 rue du capitaine Crochet SAVOURNON 05700', '0415947068', 7, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Harshill', 'Armelle', '32 rue de Paris SAINT-LAURENT-SUR-SAONE 01750', '0480648434', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznakovitch', 'Serge', '96 rue des oiseaux YONCQ 08210', '0397358254', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frazier', 'Patrick', '66 rue Blainville FRESSANCOURT 02800', '0330907062', 8, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Habresh', 'Caline', '84 rue des Epines BRIANCON 05100', '0411957355', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermontin', 'Patrice', '93 rue Perdue DOMMARTIN 01380', '0430289650', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Martin', '96 rue des Pigeons ORCIERES 05170', '0492319447', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rastuffe', 'Rosalie', '34 rue des Ormes AX-LES-THERMES 09110', '0577827344', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglebert', 'Robert', '97 rue des perles blanches VAUX-CHAMPAGNE 08130', '0315818160', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Protonne', 'Patricia', '59 rue Pernod SORBIERS 05150', '0452990036', 6, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Raminski', 'Patrice', '30 rue de du général Scott SAINT-SAUVEUR 05200', '0412740574', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Falahoui', 'Alizée', '24 rue Commandant Hériot HERBEUVAL 08370', '0372811016', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zomar', 'Amiel', '30 rue des Epines ARROUT 09800', '0554912883', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jalouve', 'Anne-Laure', '72 rue des Accacias CEYZERIAT 01250', '0495757649', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Alain', '89 rue de la Pergolat NEUVILLE-LES-DAMES 01400', '0443139412', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chéchenko', 'Julien', '52 rue Malraux MAYOT 02800', '0313537125', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Dominique', '26 rue des Pigeons CHEZY-SUR-MARNE 02570', '0376713314', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Prosper', '34 rue des pyramides DOMMARTIN 01380', '0437007893', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Amélie', '84 rue de Marigny AMBRIEF 02200', '0362342189', 6, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Carole', '14 rue des Lilas SAVOURNON 05700', '0440474468', 5, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Homar', 'Adelphe', '32 rue de Marigny CHABESTAN 05400', '0479332407', 7, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamois', 'Anne-Lucie', '31 rue des pyramides MAYOT 02800', '0352060592', 3, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Egrouzais', 'Amélie', '90 rue des Néfliers HOUDILCOURT 08190', '0360017048', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ben Harfa', 'Adelphe', '35 rue des Argonautes BOULIGNEUX 01330', '0470938471', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rastidien', 'Rosalie', '14 rue Blainville FLEVILLE 08250', '0320670229', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Caline', '27 rue Pasteur AX-LES-THERMES 09110', '0512150549', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gaudillot', 'Astine', '94 rue Debussy MONTIGNY-SUR-MEUSE 08170', '0358772408', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Vivian', 'Victor', '23 rue St Denis TRAVECY 02800', '0330373632', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hallouche', 'Aristote', '55 rue Agniel BEDEILLE 09230', '0597171275', 2, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mistigry', 'Charles-Edouard', '78 rue de la recette MACHAULT 08310', '0325349638', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Frequin', 'Caline', '19 rue Pernod AX-LES-THERMES 09110', '0568016782', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopes', 'Aurèle', '9 rue de la gare MONTCY-NOTRE-DAME 08090', '0346893168', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'Serge', '99 rue de Paris MONTCY-NOTRE-DAME 08090', '0391243175', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Béronzelle ', 'Aline', '66 rue des Cyprés ROCHEBRUNE 05190', '0474044568', 1, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Gilles', '13 rue des Ormes BLYES 01150', '0424315941', 8, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kérouanne', 'Johnny', '99 rue des Epines LAUNOIS-SUR-VENCE 08430', '0313668088', 5, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'Jérome', '24 rue des Anses bleues FLOING 08200', '0351576826', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Egrouzais', 'Amiel', '16 rue des oiseaux OYONNAX 01100', '0480872838', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ronsard', 'Irénée', '24 rue Agniel BOURG-EN-BRESSE 01000', '0457782183', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hanscart', 'Andrew', '63 rue de du général Scott SAINTE-MARIE 05150', '0496424640', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fort', 'Fatima', '9 rue des Cyprés FRESSANCOURT 02800', '0399807861', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'Andrew', '53 rue de la Pergolat CHABESTAN 05400', '0448286750', 2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framier', 'Gilles', '47 rue du capitaine Fraquasse BANCIGNY 02140', '0397976949', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chéchenko', 'Marie', '89 rue Albert Camus MONTCY-NOTRE-DAME 08090', '0378321982', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fort', 'Anne-Jeanne', '81 rue des Cavaux SAINT-LAURENT-SUR-SAONE 01750', '0463951383', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Habresh', 'Armelle', '76 rue du Mont MONTCEAUX 01090', '0415598111', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gaudin', 'Anémone', '19 rue Albert Camus CAMON 09500', '0573404038', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durhum', 'Prosper', '67 rue de la gare FLOING 08200', '0324668686', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zebitoun', 'Anselme', '53 rue des hirondelles FLOING 08200', '0327408227', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Capliez', 'Roby', '13 rue du stade OYONNAX 01100', '0474204428', 2, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Vénus', '50 rue des Argonautes HERBEUVAL 08370', '0373456319', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Aline', '54 rue de la Tour ARROUT 09800', '0573442616', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Alain', '50 rue Anatole France TRAVECY 02800', '0323311091', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Krevette', 'Mohammed', '78 rue des Epines BLYES 01150', '0431013911', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fermontin', 'sabine', '80 rue de la Tour AX-LES-THERMES 09110', '0516185496', 4, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bouglieux', 'Adelphe', '43 rue de la pointe AZY-SUR-MARNE 02400', '0325660790', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scott', 'Annie', '96 rue du général de Gaulle AX-LES-THERMES 09110', '0599243446', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Lazio', 'John', '82 rue de la recette AGUILCOURT 02190', '0366228551', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Brouzais', 'Aurélien', '66 rue Louis Aragon BETTANT 01500', '0473878093', 2, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fressinet', 'Hypolite', '70 rue des Néfliers CHALLES 01450', '0476171240', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Sophie', '43 rue des Armées BRIANCON 05100', '0415807023', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shouchen', 'Anselme', '59 rue Petit FRESSANCOURT 02800', '0383782513', 6, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Ines', '43 rue du général de Gaulle AUGIREIN 09800', '0598718886', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Aurélien', '79 rue de la gare BELLEY 01300', '0479776039', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Roland', 'Andrew', '18 rue du Mont CHALLES 01450', '0433547437', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotland', 'Jérome', '89 rue des pyramides MONCEAU-SUR-OISE 02120', '0345551167', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Guimauve', 'Serge', '97 rue du capitaine Crochet FLOING 08200', '0316196835', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fortin', 'Patrice', '25 rue des gatinnes FLEVILLE 08250', '0334902877', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fylbouni', 'Bénédicte', '13 rue Agniel BEZAC 09100', '0566740268', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Jérome', '40 rue des perles blanches SAINT-ANDRE-DE-ROSANS 05150', '0446944245', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Doineau', 'Jérémie', '78 rue des Epines VAUX-CHAMPAGNE 08130', '0358416091', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nasri', 'Catherine', '34 rue Malraux MACHAULT 08310', '0384057669', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sérénice', 'Prosper', '76 rue des Epines FLOING 08200', '0393379729', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Hamouti', 'Patrick', '26 rue Agniel BOURG-EN-BRESSE 01000', '0479180299', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Rosty', 'Julie', '40 rue des Armées AMBRIEF 02200', '0361450183', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestoriat', 'Jordan', '27 rue de la rose BANCIGNY 02140', '0352416188', 1, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Julienne', '69 rue des gatinnes AX-LES-THERMES 09110', '0580069967', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pastor', 'Annie', '58 rue du capitaine Fraquasse CHABESTAN 05400', '0467360442', 1, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'Patrick', '19 rue Pernod SIGOYER 05130', '0457375943', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Brouzais', 'Andrew', '83 rue de Paris AMBRIEF 02200', '0395359341', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framaouzy', 'Adelphe', '27 rue Bonaparte CHEZY-SUR-MARNE 02570', '0355084339', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chrome', 'sabine', '65 rue des Pigeons HERBEUVAL 08370', '0360394232', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipion', 'Irénée', '69 rue de la recette MACHAULT 08310', '0383128193', 2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zitoune', 'Martial', '86 rue du général de Gaulle BARZY-SUR-MARNE 02850', '0317141855', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Loulianov', 'Roby', '9 rue du général de Gaulle SAINT-ANDRE-DE-ROSANS 05150', '0487582509', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Arditi', 'Aurèle', '87 rue des Armées BARZY-SUR-MARNE 02850', '0338003620', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Kopa', 'Sophie', '94 rue de Poligny ARROUT 09800', '0557640538', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epriniche', 'Aurèle', '63 rue des Epines ASTON 09310', '0522392505', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fylbouni', 'Bertrand', '46 rue des Néfliers AUBENTON 02500', '0347004937', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglebert', 'Catherine', '75 rue des Pigeons MEZIERES-SUR-OISE 02240', '0361266958', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Anne-Jeanne', '45 rue de la poste MONTCEAUX 01090', '0483591358', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Précilia', '97 rue de Marigny OYONNAX 01100', '0492249302', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durieux', 'Julien', '86 rue Pasteur AMBRIEF 02200', '0351207619', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sibaton', 'Yoan', '16 rue des Cyprés ROCHEBRUNE 05190', '0447561911', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Froudette', 'Martin', '12 rue de Marigny SAVOURNON 05700', '0427247399', 2, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yansen', 'Alizée', '88 rue Blainville ROCHEBRUNE 05190', '0426259531', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Aznakovitch', 'Anne-Jeanne', '25 rue des Cavaux SAINT-ANDRE-DE-ROSANS 05150', '0453552598', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Anémone', '52 rue des Argonautes BRIANCON 05100', '0490437250', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hourin', 'Rosalie', '1 rue Albert Camus BOURG-EN-BRESSE 01000', '0436516378', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotland', 'Julien', '16 rue Mallarmé JUNIVILLE 08310', '0387772024', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Béatrice', '56 rue de du général Scott BLYES 01150', '0497830362', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nahraoui', 'Irénée', '28 rue Hector Berlioz YONCQ 08210', '0391607943', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prouteau', 'Bernard', '67 rue des Pigeons AZY-SUR-MARNE 02400', '0363260638', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Format', 'Nohan', '56 rue de la poste BILLIAT 01200', '0489588610', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Klébert', 'Hector', '56 rue du Mont AUBENTON 02500', '0317965994', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chesnikov', 'Vénus', '42 rue Mallarmé SAINT-FIRMIN 05800', '0496188645', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framzaoui', 'Ingrid', '69 rue des gatinnes SAINT-LAURENT-SUR-SAONE 01750', '0474955755', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazoline', 'Béatrice', '83 rue Mallarmé LAVAL-MORENCY 08150', '0353669720', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Lazio', 'Aristote', '45 rue des Néfliers ORCIERES 05170', '0410443514', 8, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Faure', 'Firmin', '86 rue Alphonse Daudet SORBIERS 05150', '0474673714', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shouchen', 'Hypolite', '46 rue Blainville BELLEY 01300', '0432841577', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'Anne-Laure', '10 rue Debussy BRIANCON 05100', '0488339706', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Liorehen', 'Adrien', '16 rue des Lilas CHEZY-SUR-MARNE 02570', '0375598648', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zingaro', 'Martial', '48 rue des Cavaux BRIANCON 05100', '0497203279', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestor', 'Adrien', '67 rue Mallarmé NEUVILLE-LES-DAMES 01400', '0483807492', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('GrosJean', 'Andrée', '9 rue Blainville BILLIAT 01200', '0443247634', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Khan', 'Austine', '76 rue des Ormes BEDEILLE 09230', '0541576058', 6, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cassan', 'sabine', '37 rue du stade ARROUT 09800', '0574023557', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Gaudin', 'Bénédicte', '52 rue Mallarmé SAINT-FIRMIN 05800', '0498785723', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Prestoriat', 'Aline', '72 rue des Accacias AX-LES-THERMES 09110', '0548451154', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Cerpico', 'Charles-Edouard', '19 rue des Accacias HOUDILCOURT 08190', '0316020754',
        2, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Yoggi', 'Hector', '65 rue des Lilas BEDEILLE 09230', '0574559022', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bazile', 'Anémone', '5 rue du 14 juillet CHEZY-SUR-MARNE 02570', '0337232948', 7, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Astoria', 'Ingrid', '92 rue des Epines AX-LES-THERMES 09110', '0561364657', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Heroudy', 'Habib', '22 rue de la pointe MESSINCOURT 08110', '0313589708', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Caroussel', 'Jérémy', '59 rue des perles blanches YONCQ 08210', '0326242380', 2,
        08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Zerbib', 'Amiel', '96 rue Pasteur ARROUT 09800', '0587698522', 4, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lièvremont', 'Austine', '65 rue Mallarmé MONTCEAUX 01090', '0470285907', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chamonix', 'Anne-Jeanne', '32 rue Pernod TRAVECY 02800', '0333270659', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Durieux', 'François', '33 rue des Armées JOIGNY-SUR-MEUSE 08700', '0349739798', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Framzaoui', 'Astine', '14 rue de Paris HAUTEVILLE 02120', '0351375540', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Epoka', 'Catherine', '62 rue Petit AUBENTON 02500', '0396351922', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Shavert', 'Dominique', '16 rue Albert Camus MONTCEAUX 01090', '0460614067', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Raminski', 'Habib', '43 rue Agniel FEPIN 08170', '0334104949', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scotland', 'Bertrand', '19 rue des Armées BUZAN 09800', '0568125818', 1, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Hallouche', 'Anne-Lucie', '98 rue de la recette CHABESTAN 05400', '0456022326', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Billahian', 'Bernard', '20 rue des Pigeons ARROUT 09800', '0573067550', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Fort', 'Nohan', '43 rue des hirondelles BEDEILLE 09230', '0525181569', 3, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Anne-Sophie', '31 rue Blainville BARENTON-SUR-SERRE 02270', '0373526813', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Chevalier', 'Alice', '33 rue des Accacias ROCHEBRUNE 05190', '0449350884', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Anglebert', 'Aline', '84 rue du capitaine Crochet MONT-LAURENT 08130', '0325576123', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ségura', 'John', '3 rue de la Tour FRESSANCOURT 02800', '0331446881', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Homar', 'Anne', '96 rue des Anges AUBENTON 02500', '0378136627', 6, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bridel', 'Julienne', '69 rue des Argonautes MONT-LAURENT 08130', '0370869862', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Di Conota', 'Amiel', '64 rue Bonaparte PELVOUX 05340', '0488029182', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('El Arabi', 'sabine', '82 rue Petit MONTCEAUX 01090', '0462167372', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Casson', 'Aurélien', '43 rue de la pointe SAINTE-MARIE 05150', '0435284955', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Pololsky', 'François', '82 rue des gatinnes LAVAL-MORENCY 08150', '0342390211', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Ligne', 'Anne-Jeanne', '43 rue Hector Berlioz MONTCEAUX 01090', '0423643158', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sabatier', 'Gilles', '61 rue de la Pergolat FLEVILLE 08250', '0344269218', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Mestre', 'Anne-Lucie', '10 rue des Armées JUNIVILLE 08310', '0323215933', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Lopez', 'Rosalie', '61 rue Lampion MAYOT 02800', '0334037246', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Scipillon', 'Marie', '42 rue de la recette MONTCEAUX 01090', '0483490191', 4, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Radot', 'Alain', '49 rue des Chantereines SAINT-SAUVEUR 05200', '0444873979', 4, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Mérieux', 'Yoan', '26 rue Perdue BARENTON-SUR-SERRE 02270', '0383462706', 4, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Oberlieux', 'Anne-Lucie', '30 rue des Néfliers FRESSANCOURT 02800', '0375894393', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Serbouny', 'Nohan', '35 rue Pernod BELLOC 09600', '0584397641', 3, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Jarrinovski', 'John', '87 rue des Epines JUNIVILLE 08310', '0326912283', 5, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Capliez', 'Patricia', '11 rue des Armées CAMON 09500', '0564584038', 9, 09);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('CHeroudy', 'Adelphe', '1 rue des Anges AMBRIEF 02200', '0341912319', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Margot', 'Anaelle', '34 rue de la Tour BOURG-EN-BRESSE 01000', '0421198450', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Homar', 'Jérome', '1 rue du capitaine Crochet MAYOT 02800', '0322747123', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Ricardo', 'Hector', '96 rue des Princes AGUILCOURT 02190', '0344210000', 9, 02);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Sursarshill', 'Austine', '48 rue Beaudelaire MACHAULT 08310', '0327416806', 9, 08);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Bretonnot', 'Anne', '37 rue du capitaine Crochet SIGOYER 05130', '0440990856', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('De Mestre', 'Aude', '87 rue Louis Aragon SAINTE-MARIE 05150', '0458331361', 9, 05);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Nazaoui', 'Aurélien', '83 rue des hirondelles SAINT-LAURENT-SUR-SAONE 01750', '0419114151', 9, 01);
INSERT INTO medecin(nom, prenom, adresse, tel, specialite_id, departement_id)
VALUES ('Armouche', 'Sophie', '83 rue des Chantereines NEUVILLE-LES-DAMES 01400', '0412959203', 9, 01);
