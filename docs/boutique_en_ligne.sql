DROP DATABASE IF EXISTS boutique_en_ligne;
CREATE DATABASE IF NOT EXISTS boutique_en_ligne;
USE boutique_en_ligne;

CREATE TABLE categories (
    categorie_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255)
);

CREATE TABLE produits (
    produit_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    prix DECIMAL(10, 2) NOT NULL,
    stock INT,
    categorie_id INT,
    FOREIGN KEY (categorie_id) REFERENCES categories (categorie_id)
);

CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    courriel VARCHAR(255),
    date_inscription DATE,
    ville VARCHAR(255)
);

CREATE TABLE commandes (
    commande_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    date_commande DATE,
    statut VARCHAR(50),
    FOREIGN KEY (client_id) REFERENCES clients (client_id)
);

CREATE TABLE lignes_commandes (
    ligne_id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT,
    produit_id INT,
    quantite INT,
    prix_unitaire DECIMAL(10, 2),
    FOREIGN KEY (commande_id) REFERENCES commandes (commande_id),
    FOREIGN KEY (produit_id) REFERENCES produits (produit_id)
);

-- ---- Catégories ----
INSERT INTO categories (nom) VALUES
    ('Électronique'),
    ('Vêtements'),
    ('Livres'),
    ('Alimentation'),
    ('Sport'),
    ('Maison');

-- ---- Produits ----
INSERT INTO produits (nom, description, prix, stock, categorie_id) VALUES
    ('Laptop Pro 15',         'Ordinateur portable haute performance',   1299.99, 15,  1),
    ('Souris sans fil',       'Souris ergonomique 2.4 GHz',                29.99, 49,  1),
    ('Clavier mécanique',     'Clavier rétroéclairé switches bleus',       89.99, 30,  1),
    ('T-shirt coton',         'T-shirt 100 % coton, coupe régulière',      19.99, 100, 2),
    ('Jeans slim',            'Jeans coupe ajustée, denim stretch',        59.99, 73,  2),
    ('Veste imperméable',     'Veste de randonnée légère et imperméable', 149.99, 39,  2),
    ('Roman policier',        'Thriller psychologique, 320 pages',         14.99, 60,  3),
    ('Guide de cuisine',      'Recettes du monde entier, 250 recettes',    24.99, 45,  3),
    ('Encyclopédie',          'Encyclopédie générale en 3 volumes',        79.99,  0,  3),
    ('Café premium',          'Café arabica torréfié, 500 g',              12.99, 196, 4),
    ('Chocolat artisanal',    'Tablette 70 % cacao, 100 g',                 8.99, 149, 4),
    ('Thé vert',              'Thé sencha biologique, 100 sachets',         9.99, 179, 4),
    ('Ballon de soccer',      'Ballon taille 5, certifié FIFA',            34.99, 77,  5),
    ('Raquette de tennis',    'Raquette légère 270 g, cadre carbone',      89.99, 34,  5),
    ('Vélo de montagne',      'VTT 27 vitesses, fourche suspendue',       499.99,  9,  5),
    ('Lampe de bureau',       'Lampe LED à intensité réglable',            44.99, 53,  6),
    ('Coussin décoratif',     'Coussin velours 45 × 45 cm',               22.99, 90,  6),
    ('Ensemble de vaisselle', 'Service 6 personnes, porcelaine blanche',   69.99, 24,  6),
    ('Casque audio',          'Casque sans fil à réduction de bruit',     199.99, 16,  1),
    ('Montre connectée',      'Montre sport GPS, autonomie 7 jours',      299.99,  8,  1);

-- ---- Clients ----

INSERT INTO clients (nom, prenom, courriel, date_inscription, ville) VALUES
    ('Tremblay',  'Marie',     'marie.tremblay@courriel.ca',    '2020-01-15', 'Montréal'),
    ('Bouchard',  'Jean',      'jean.bouchard@courriel.ca',     '2020-03-22', 'Québec'),
    ('Martin',    'Sophie',    'sophie.martin@courriel.ca',     '2019-11-10', 'Laval'),
    ('Roy',       'Pierre',    'pierre.roy@courriel.ca',        '2021-05-07', 'Longueuil'),
    ('Gagnon',    'Julie',     'julie.gagnon@courriel.ca',      '2020-08-19', 'Montréal'),
    ('Leblanc',   'Marc',      'marc.leblanc@courriel.ca',      '2022-02-14', 'Sherbrooke'),
    ('Côté',      'Nathalie',  'nathalie.cote@courriel.ca',     '2021-09-30', 'Gatineau'),
    ('Fortin',    'Alexandre', 'alexandre.fortin@courriel.ca',  '2020-07-11', 'Montréal'),
    ('Pelletier', 'Isabelle',  'isabelle.pelletier@courriel.ca','2019-04-25', 'Québec'),
    ('Ouellet',   'François',  'francois.ouellet@courriel.ca',  '2023-01-08', 'Laval');

-- ---- Commandes ----

INSERT INTO commandes (client_id, date_commande, statut) VALUES
    (1, '2024-01-15', 'livré'),         -- commande_id 1
    (2, '2024-02-10', 'livré'),         -- commande_id 2
    (3, '2024-02-25', 'en traitement'), -- commande_id 3
    (4, '2024-03-05', 'livré'),         -- commande_id 4
    (5, '2024-03-15', 'livré'),         -- commande_id 5
    (6, '2024-04-01', 'annulé'),        -- commande_id 6
    (7, '2024-04-20', 'en traitement'), -- commande_id 7
    (8, '2024-05-10', 'livré'),         -- commande_id 8
    (9, '2024-05-25', 'livré'),         -- commande_id 9
    (10,'2024-06-01', 'en traitement'); -- commande_id 10

-- ---- Lignes de commandes ----

INSERT INTO lignes_commandes (commande_id, produit_id, quantite, prix_unitaire) VALUES
    (1,  14,  1,  89.99),
    (1,  10,  2,  12.99),
    (1,  11,  1,   8.99),
    (1,  12,  1,   9.99),
    (2,  20,  2, 299.99),
    (2,   2,  1,  29.99),
    (3,   1,  1, 1299.99),
    (3,  19,  1, 199.99),
    (4,  20,  1, 299.99),
    (4,   5,  2,  59.99),
    (5,   6,  1,  49.99),
    (6,  15,  1, 499.99),
    (7,  19,  2, 199.99),
    (8,  19,  1, 199.99),
    (8,  16,  2,  44.99),
    (9,  20,  1, 299.99),
    (9,  18,  1,  69.99),
    (10, 13,  3,  34.99);
