

CREATE DATABASE IF NOT EXISTS ecommerce_bronze;
USE ecommerce_bronze;

-- ------------------------------------------------------------
-- CRM tables
-- ------------------------------------------------------------

DROP TABLE IF EXISTS crm_clients_raw;
CREATE TABLE crm_clients_raw (
    crm_client_id     VARCHAR(50),
    nom               VARCHAR(100),
    email             VARCHAR(100),
    telephone         VARCHAR(30),
    ville             VARCHAR(100),
    segment           VARCHAR(50),
    date_inscription  VARCHAR(50),
    ingestion_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS crm_produits_raw;
CREATE TABLE crm_produits_raw (
    crm_product_id    VARCHAR(50),
    nom_produit       VARCHAR(150),
    categorie         VARCHAR(100),
    prix_catalogue    VARCHAR(50),
    ingestion_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS crm_details_commandes_raw;
CREATE TABLE crm_details_commandes_raw (
    crm_order_id      VARCHAR(50),
    crm_client_id     VARCHAR(50),
    crm_product_id    VARCHAR(50),
    date_commande     VARCHAR(50),
    quantite          VARCHAR(50),
    ingestion_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- ERP tables
-- ------------------------------------------------------------

DROP TABLE IF EXISTS erp_clients_raw;
CREATE TABLE erp_clients_raw (
    erp_client_id     VARCHAR(50),
    nom               VARCHAR(100),
    ice               VARCHAR(50),
    ville             VARCHAR(100),
    pays              VARCHAR(100),
    date_creation     VARCHAR(50),
    ingestion_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS erp_produits_raw;
CREATE TABLE erp_produits_raw (
    erp_product_id    VARCHAR(50),
    designation       VARCHAR(150),
    categorie_stock   VARCHAR(100),
    prix_achat        VARCHAR(50),
    prix_vente        VARCHAR(50),
    stock             VARCHAR(50),
    ingestion_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS erp_details_commandes_raw;
CREATE TABLE erp_details_commandes_raw (
    erp_order_id      VARCHAR(50),
    erp_client_id     VARCHAR(50),
    erp_product_id    VARCHAR(50),
    date_facture      VARCHAR(50),
    quantite          VARCHAR(50),
    prix_unitaire     VARCHAR(50),
    statut            VARCHAR(50),
    ingestion_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);