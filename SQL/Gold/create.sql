
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS ecommerce_gold;
USE ecommerce_gold;

DROP TABLE IF EXISTS dim_produits;
CREATE TABLE dim_produits (
    product_id    VARCHAR(50) unique,
    prix_achat       FLOAT,
    prix_vente       FLOAT,
    stock             INT,
    nom_produit       VARCHAR(150),
    categorie         VARCHAR(100),
    source_system        VARCHAR(3)
);

DROP TABLE IF EXISTS dim_client;
CREATE TABLE dim_client (
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
DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date (
    date_key        INT PRIMARY KEY,     -- YYYYMMDD
    full_date       DATE NOT NULL,
    day             TINYINT,
    month           TINYINT,
    year            SMALLINT,
    quarter         TINYINT,
    day_name        VARCHAR(10),
    month_name      VARCHAR(10),
    week_of_year    TINYINT,
    is_weekend      BOOLEAN
);

DROP TABLE IF EXISTS fact_orders;
CREATE TABLE fact_orders(
    time_key int,
    customer_key VARCHAR(10),
    product_key VARCHAR(10),
    order_number VARCHAR(50),
    quantite int,
    revenue FLOAT,
    cost float,
    profit float,
    FOREIGN KEY (time_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key) REFERENCES dim_client(customer_id),
    FOREIGN KEY (product_key) REFERENCES dim_produits(product_id)

);


SET FOREIGN_KEY_CHECKS = 1;