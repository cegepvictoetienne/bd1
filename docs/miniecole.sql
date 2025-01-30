DROP DATABASE IF EXISTS miniecole;
CREATE DATABASE IF NOT EXISTS miniecole;
USE miniecole;

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
    programme CHAR(6)
);

INSERT INTO cours (sigle, duree, nom) VALUES      
        ('420-2B4-VI', DEFAULT (duree), 'Base de données 1'),     
        ('420-1D6-VI', 90, 'Programmation 1');
