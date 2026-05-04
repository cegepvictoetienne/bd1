DROP DATABASE IF EXISTS club_video;
CREATE DATABASE IF NOT EXISTS club_video;
USE club_video;

CREATE TABLE realisateurs (
    realisateur_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    nationalite VARCHAR(255),
    date_de_naissance DATE
);

CREATE TABLE distributeurs (
    distributeur_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    adresse VARCHAR(255),
    telephone VARCHAR(20)
);

CREATE TABLE films (
    film_id INT PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(255),
    realisateur_id INT,
    distributeur_id INT,
    annee_sortie INT,
    genre VARCHAR(255),
    FOREIGN KEY (realisateur_id) REFERENCES realisateurs (realisateur_id),
    FOREIGN KEY (distributeur_id) REFERENCES distributeurs (distributeur_id)
);

CREATE TABLE membres (
    membre_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    date_adhesion DATE,
    courriel VARCHAR(255)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    film_id INT,
    membre_id INT,
    date_location DATE,
    date_retour DATE,
    date_retour_prevue DATE,
    FOREIGN KEY (film_id) REFERENCES films (film_id),
    FOREIGN KEY (membre_id) REFERENCES membres (membre_id)
);

-- ---- Réalisateurs ----
INSERT INTO realisateurs (nom, prenom, nationalite, date_de_naissance) VALUES
    ('Spielberg',   'Steven',        'Américain',   '1946-12-18'),
    ('Kubrick',     'Stanley',       'Américain',   '1928-07-26'),
    ('Scorsese',    'Martin',        'Américain',   '1942-11-17'),
    ('Almodovar',   'Pedro',         'Espagnol',    '1949-09-25'),
    ('Lynch',       'David',         'Américain',   '1946-01-20'),
    ('Tarantino',   'Quentin',       'Américain',   '1963-03-27'),
    ('Bergman',     'Ingmar',        'Suédois',     '1918-07-14'),
    ('Kurosawa',    'Akira',         'Japonais',    '1910-03-23'),
    ('Hitchcock',   'Alfred',        'Britannique', '1899-08-13'),
    ('Inarritu',    'Alejandro',     'Mexicain',    '1963-08-15'),
    ('Del Toro',    'Guillermo',     'Mexicain',    '1964-10-09'),
    ('Villeneuve',  'Denis',         'Canadienne',  '1967-10-03'),
    ('Nolan',       'Christopher',   'Britannique', '1970-07-30'),
    ('Coppola',     'Francis Ford',  'Américain',   '1939-04-07'),
    ('Tremblay',    'Louise',        'Canadienne',  '1975-03-15');

-- ---- Distributeurs ----

INSERT INTO distributeurs (nom, adresse, telephone) VALUES
    ('Warner Bros.',       '123 Rue Hollywood, Los Angeles', '310-555-0001'),
    ('Universal Pictures', '456 Blvd Cinema, Los Angeles',  '310-555-0002'),
    ('Sony Pictures',      '789 Ave Film, Los Angeles',      '310-555-0003'),
    ('Paramount Pictures', '321 Rue Studio, Hollywood',      '310-555-0004'),
    ('Disney',             '654 Blvd Animation, Burbank',    '818-555-0001'),
    ('Netflix',            '987 Ave Streaming, Los Gatos',   '408-555-0001');

-- ---- Films ----

INSERT INTO films (titre, realisateur_id, distributeur_id, annee_sortie, genre) VALUES
    ('La Liste de Schindler',          1,  2, 1993, 'Drame'),
    ('Jurassic Park',                  1,  2, 1993, 'Action'),
    ('2001 : L''Odyssée de l''espace', 2,  1, 1968, 'Science-fiction'),
    ('Shining',                        2,  1, 1980, 'Horreur'),
    ('Taxi Driver',                    3,  4, 1976, 'Thriller'),
    ('Les Affranchis',                 3,  1, 1990, 'Drame'),
    ('Tout sur ma mère',               4,  3, 1999, 'Drame'),
    ('Mulholland Drive',               5,  2, 2001, 'Thriller'),
    ('Pulp Fiction',                   6,  4, 1994, 'Thriller'),
    ('Reservoir Dogs',                 6,  4, 1992, 'Thriller'),
    ('Le Septième Sceau',              7,  3, 1957, 'Drame'),
    ('Rashomon',                       8,  3, 1950, 'Drame'),
    ('Vertigo',                        9,  2, 1958, 'Thriller'),
    ('Psychose',                       9,  2, 1960, 'Horreur'),
    ('Birdman',                       10,  2, 2014, 'Comédie'),
    ('Le Labyrinthe de Pan',          11,  2, 2006, 'Fantastique'),
    ('Incendies',                     12,  4, 2010, 'Drame'),
    ('Arrival',                       12,  4, 2016, 'Science-fiction'),
    ('Interstellar',                  13,  1, 2014, 'Science-fiction'),
    ('Le Parrain',                    14,  4, 1972, 'Drame'),
    ('Indiana Jones',                  1,  4, 1981, 'Action'),
    ('E.T.',                           1,  2, 1982, 'Science-fiction'),
    ('Apocalypse Now',                14,  4, 1979, 'Drame'),
    ('Batman Begins',                 13,  1, 2005, 'Action'),
    ('The Dark Knight',               13,  1, 2008, 'Action');

INSERT INTO films (film_id, titre, realisateur_id, distributeur_id, annee_sortie, genre) VALUES
    (3309, 'Dune', 12, 1, 2021, 'Science-fiction');

-- ---- Membres ----

INSERT INTO membres (nom, prenom, adresse, date_adhesion, courriel) VALUES
    ('Tremblay',  'Jean',      '12 Rue des Pins, Montréal',         '2015-03-10', 'jean.tremblay@courriel.ca'),
    ('Bouchard',  'Marie',     '34 Ave des Érables, Laval',          '2016-07-22', 'marie.bouchard@courriel.ca'),
    ('Martin',    'Mathieu',   '56 Blvd Saint-Laurent, Montréal',   '2017-01-05', 'mathieu.martin@courriel.ca'),
    ('Leblanc',   'Sophie',    '78 Rue Principale, Longueuil',       '2015-11-30', 'sophie.leblanc@courriel.ca'),
    ('Roy',       'Pierre',    '90 Ave du Parc, Montréal',           '2018-04-18', 'pierre.roy@courriel.ca'),
    ('Gagnon',    'Julie',     '23 Rue de la Montagne, Sherbrooke',  '2016-09-14', 'julie.gagnon@courriel.ca'),
    ('Beaulieu',  'François',  '45 Rue Laval, Québec',               '2019-02-28', 'francois.beaulieu@courriel.ca'),
    ('Côté',      'Alexandre', '67 Blvd Laurier, Gatineau',          '2017-06-07', 'alexandre.cote@courriel.ca'),
    ('Fortin',    'Nathalie',  '89 Rue du Commerce, Trois-Rivières', '2020-01-15', 'nathalie.fortin@courriel.ca'),
    ('Pelletier', 'Marc',      '11 Ave Victoria, Montréal',          '2018-08-22', 'marc.pelletier@courriel.ca'),
    ('Ouellet',   'Isabelle',  '33 Rue Saint-Jean, Québec',          '2016-03-19', 'isabelle.ouellet@courriel.ca'),
    ('Simard',    'Louis',     '55 Blvd Industriel, Lévis',          '2021-05-11', 'louis.simard@courriel.ca'),
    ('Bergeron',  'Marianne',  '77 Rue des Lilas, Laval',            '2019-10-03', 'marianne.bergeron@courriel.ca'),
    ('Lavoie',    'Catherine', '99 Ave des Roses, Montréal',         '2020-12-20', 'catherine.lavoie@courriel.ca'),
    ('Morin',     'Maxime',    '21 Rue du Lac, Saguenay',            '2022-03-08', 'maxime.morin@courriel.ca');

INSERT INTO membres (membre_id, nom, prenom, adresse, date_adhesion, courriel) VALUES
    (78,  'Gagnon', 'Pierre', '45 Rue des Érables, Montréal', '2018-06-15', 'pgagnon@ancien.ca'),
    (221, 'Dumont', 'Claire', '78 Ave du Parc, Québec',        '2019-11-22', 'claire.dumont@courriel.ca');

-- ---- Locations ----

INSERT INTO locations (film_id, membre_id, date_location, date_retour, date_retour_prevue) VALUES
    (1,  1,  '2024-01-10', '2024-01-17', '2024-01-13'),  --  7 jours
    (3,  1,  '2024-02-05', '2024-02-15', '2024-02-08'),  -- 10 jours
    (5,  1,  '2024-03-12', '2024-03-14', '2024-03-15'),  --  2 jours
    (9,  1,  '2024-04-20', '2024-04-30', '2024-04-23'),  -- 10 jours
    (2,  2,  '2024-01-15', '2024-01-25', '2024-01-18'),  -- 10 jours
    (4,  2,  '2024-02-20', '2024-02-24', '2024-02-23'),  --  4 jours
    (6,  2,  '2024-03-08', '2024-03-18', '2024-03-11'),  -- 10 jours
    (7,  3,  '2024-01-22', '2024-01-26', '2024-01-25'),  --  4 jours
    (8,  3,  '2024-02-14', '2024-02-20', '2024-02-17'),  --  6 jours
    (10, 3,  '2024-03-01', '2024-03-12', '2024-03-04'),  -- 11 jours
    (11, 4,  '2024-01-30', '2024-02-02', '2024-02-02'),  --  3 jours
    (13, 5,  '2024-02-10', '2024-02-22', '2024-02-13'),  -- 12 jours
    (15, 6,  '2024-03-15', '2024-03-21', '2024-03-18'),  --  6 jours
    (17, 8,  '2024-04-01', '2024-04-10', '2024-04-04'),  --  9 jours
    (19, 9,  '2024-04-15', '2024-04-17', '2024-04-18'),  --  2 jours
    (20, 10, '2024-05-01', '2024-05-03', '2024-05-04'),  --  2 jours
    (22, 11, '2024-05-10', '2024-05-20', '2024-05-13'),  -- 10 jours
    (24, 13, '2024-06-01', '2024-06-05', '2024-06-04'),  --  4 jours
    (25, 14, '2024-06-15', '2024-06-17', '2024-06-18'),  --  2 jours
    (16, 15, '2024-07-01', '2024-07-08', '2024-07-04');  --  7 jours

INSERT INTO locations (location_id, film_id, membre_id, date_location, date_retour, date_retour_prevue) VALUES
    (87654, 3309, 221, '2025-03-07', NULL, '2025-03-10');
