
SET FOREIGN_KEY_CHECKS = 0;
CREATE DATABASE IF NOT EXISTS ecommerce_silver;
USE ecommerce_silver;

-- ------------------------------------------------------------
-- CRM tables
-- ------------------------------------------------------------

DROP TABLE IF EXISTS client_clean;
CREATE TABLE client_clean (
    customer_id       VARCHAR(10) unique,
    nom               VARCHAR(100),
    email             VARCHAR(100),
    telephone         VARCHAR(30),
    ville             VARCHAR(100),
    pays              VARCHAR(10),
    segment           VARCHAR(50),
    date_creation  DATE,
    source_system        VARCHAR(3)
);

DROP TABLE IF EXISTS produits_clean;
CREATE TABLE produits_clean (
    product_id    VARCHAR(50) unique,
    prix_achat       FLOAT,
    prix_vente       FLOAT,
    stock             INT,
    nom_produit       VARCHAR(150),
    categorie         VARCHAR(100),
    source_system        VARCHAR(3)
);

DROP TABLE IF EXISTS detail_commande_clean;
CREATE TABLE detail_commande_clean (
    order_id      VARCHAR(50),
    client_id     VARCHAR(50),
    product_id    VARCHAR(50),
    date_commande     DATE,
    quantite          INT,
    statut         VARCHAR(10),             
    source_system       VARCHAR(3),
    FOREIGN KEY (client_id) REFERENCES client_clean(customer_id),
    FOREIGN KEY (product_id) REFERENCES produits_clean(product_id)


);


SET FOREIGN_KEY_CHECKS = 1;