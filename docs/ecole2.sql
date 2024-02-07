DROP DATABASE IF EXISTS ecole;
CREATE DATABASE IF NOT EXISTS ecole;
USE ecole;

CREATE TABLE enseignants (
	code_employe NUMERIC(8) PRIMARY KEY,
    nom VARCHAR(255),
    num_assurance_sociale CHAR(9),
    anciennete TINYINT
);

CREATE TABLE cours (
	cours_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    sigle CHAR(10),
    duree TINYINT DEFAULT 60,
    nombre_semaine TINYINT DEFAULT 15,
    enseignant NUMERIC(8),
    FOREIGN KEY (enseignant) REFERENCES enseignants (code_employe)
);

CREATE TABLE programmes (
	code_programme CHAR(6) PRIMARY KEY,
    nom VARCHAR(255),
    prof_responsable NUMERIC(8),
    FOREIGN KEY (prof_responsable) REFERENCES enseignants (code_employe)
);


CREATE TABLE etudiants (
	code_etudiant NUMERIC (7) PRIMARY KEY,
    nom VARCHAR(255),
    annee_admission YEAR,
    code_programme CHAR(6),
    FOREIGN KEY (code_programme) REFERENCES programmes (code_programme)
);

CREATE TABLE sessions (
    session_code VARCHAR(4) PRIMARY KEY,
    session_saison VARCHAR(15),
    date_debut DATE,
    date_fin DATE
);

CREATE TABLE groupes (
	groupe_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cours_id INTEGER,
    session_code VARCHAR(4),
    numero_groupe TINYINT,
    FOREIGN KEY (cours_id) REFERENCES cours (cours_id),
    FOREIGN KEY (session_code) REFERENCES sessions (session_code)
);

CREATE TABLE inscriptions (
	code_etudiant NUMERIC (7),
    groupe_id INTEGER,
    FOREIGN KEY (code_etudiant) REFERENCES etudiants (code_etudiant),
    FOREIGN KEY (groupe_id) REFERENCES groupes (groupe_id),
    PRIMARY KEY (code_etudiant, groupe_id)
);

CREATE TABLE evaluations (
	evaluation_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    groupe_id INTEGER,
    nom_evaluation VARCHAR(255),
    note_max NUMERIC(5,2),
	FOREIGN KEY (groupe_id) REFERENCES groupes (groupe_id)
);

CREATE TABLE evaluations_etudiants (
	evaluation_id INTEGER,
    code_etudiant NUMERIC(7),
    date_remise DATE,
    nom_document VARCHAR(255),
    note NUMERIC(5,2),
    FOREIGN KEY (evaluation_id) REFERENCES evaluations (evaluation_id),
    FOREIGN KEY (code_etudiant) REFERENCES etudiants (code_etudiant),
    PRIMARY KEY (evaluation_id, code_etudiant)
);

CREATE TABLE periodes (
    periode_id INT PRIMARY KEY AUTO_INCREMENT,
    heure_debut TIME,
    heure_fin TIME);

INSERT INTO enseignants (code_employe, nom, num_assurance_sociale, anciennete) VALUES (9876,'Clark Kent', 150150150, 8), (8765,'Bruce Wayne', 260260260,14), (7654, 'Kara Danvers', 888777666,0), (6573, 'Richard Grayson', 222444666, 4);
INSERT INTO cours (nom, sigle, enseignant, duree) VALUES ('Base de données 1', '420-2B4-VI', 9876, 60), ('Développement Web 2', '420-2B5-VI', 8765, 75), ('Programmation 1', '420-1B2-VI', 7654, 90), ('Programmation 2', '420-2B3-VI', 7654, 90), ('Mathématique de l\'ordinateur', '320-1B4-VI', null, 45), ('Fonctionnement de l\'ordinateur', '420-3B1-VI', null, 60);
INSERT INTO programmes (code_programme, nom, prof_responsable) VALUES ('420.01', 'Informatique appliquée', 9876), ('420.02', 'Informatique de gestion', 7654);
INSERT INTO etudiants (code_etudiant, nom, annee_admission, code_programme) VALUES (1234567, 'Anthony Stark', 2018, '420.01'), (2345678, 'Steve Rogers', 2018, '420.01'), (3456789, 'Natasha Romanov', 2019, '420.02'), (4567890, 'Bruce Banner', 2019, '420.02'),
	(5678901, 'Clinton Barton', 2019, '420.02'), (6789012, 'Thor Odinson', 2019, '420.01'), (7890123, 'Stan Lee', 2019, '420.02');
 INSERT INTO sessions (session_code, session_saison, date_debut, date_fin) VALUES ('A20', 'Automne', '2020-08-16', '2020-12-19'), ('H21', 'Hiver', '2021-01-13', '2021-05-18'), ('A21', 'Automne', '2021-08-17', '2021-12-20'), ('A22', 'Automne', '2022-08-17', '2022-12-15');
INSERT INTO groupes (cours_id, session_code, numero_groupe) VALUES  (2, 'A20', 1), (3, 'A20', 1), (4, 'A22', 1), (5, 'A22', 1), (5, 'A20', 2), (1, 'H21', 1) ,(1, 'H21', 2), (2, 'A21', 1), (3, 'A21', 1), (4, 'A21', 1), (5, 'A21', 1), (5, 'A21', 2);
INSERT INTO inscriptions (code_etudiant, groupe_id) VALUES (1234567, 1), (1234567, 3), (1234567, 2), (1234567, 5), (2345678, 1), (2345678, 4), (2345678, 2),
	(3456789, 3), (3456789, 2), (3456789, 5), (4567890, 1), (4567890, 3), (4567890, 4), (5678901, 1), (5678901, 2), (5678901, 5), (6789012, 1), (6789012, 2),
    (7890123, 3), (7890123, 2), (7890123, 5);
 INSERT INTO evaluations (groupe_id, nom_evaluation, note_max) VALUES (2, 'TP', 30), (2, 'Examen 1', 30), (2, 'Examen 2', 40), (3, 'Essai', 25), (3, 'Présentation', 25), (3, 'Final', 50), (6, 'Document Aide', 25), (6, 'Cours', 25), (6, 'Examen final', 50);
 INSERT INTO evaluations_etudiants (evaluation_id, code_etudiant, note, date_remise, nom_document) VALUES 
   (1, 3456789, 18,'2020-09-03','tp1.docx'),
 (1, 1234567, 20,'2020-09-04','tp1.docx'),
 (2, 1234567, 25,'2020-10-05','examen1.docx'),
 (2, 3456789, 24,'2020-10-05','examen1.docx'),
 (3, 1234567, 27,'2020-12-01','examen2.docx'),
 (3, 3456789, 40,'2020-12-01','examen2.docx'),
 (4, 1234567, 20,'2022-09-01','essai.docx'),
 (4, 3456789, 18,'2022-09-01','essai.docx'),
 (5, 1234567, 21,'2022-11-14','presentation.pptx'),
 (5, 3456789, 12,'2022-11-14','presentation.pptx'),
 (6, 1234567, 41,'2022-12-03','final.zip'),
 (6, 3456789, 42,'2022-12-03','final.zip'),
 (7, 1234567, 20,'2021-02-01','aide.docx'),
 (7, 3456789, 18,'2021-02-02','document_aide.docx'),
 (8, 1234567, 21,'2021-04-12','presentation.pptx'),
 (8, 3456789, 12,'2021-04-12','presentation.pptx'),
 (9, 1234567, 41,'2021-05-03','examen_final.zip'),
 (9, 3456789, 42,'2021-05-04','examen_final.zip');

INSERT INTO periodes (heure_debut, heure_fin) VALUES
    ('08:15', '09:05'),
    ('09:15', '10:05'),
    ('10:15', '11:05'),
    ('11:15', '12:05'),
    ('12:15', '13:05'),
    ('13:15', '14:05'),
    ('14:15', '15:05'),
    ('15:15', '16:05'),
    ('16:15', '17:05');