

USE ecommerce_bronze;


TRUNCATE TABLE crm_clients_raw;
LOAD DATA INFILE '/var/lib/mysql-files/crm_source/crm_clients.csv'
INTO TABLE crm_clients_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(crm_client_id, nom, email, telephone, ville, segment, date_inscription);


TRUNCATE TABLE crm_produits_raw;
LOAD DATA INFILE '/var/lib/mysql-files/crm_source/crm_produits.csv'
INTO TABLE crm_produits_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(crm_product_id, nom_produit, categorie, prix_catalogue);


TRUNCATE TABLE crm_details_commandes_raw;
LOAD DATA INFILE '/var/lib/mysql-files/crm_source/crm_details_commandes.csv'
INTO TABLE crm_details_commandes_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(crm_order_id, crm_client_id, crm_product_id, date_commande, quantite);


TRUNCATE TABLE erp_clients_raw;
LOAD DATA INFILE '/var/lib/mysql-files/erp_source/erp_clients.csv'
INTO TABLE erp_clients_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(erp_client_id, nom, ice, ville, pays, date_creation);


TRUNCATE TABLE erp_produits_raw;
LOAD DATA INFILE '/var/lib/mysql-files/erp_source/erp_produits.csv'
INTO TABLE erp_produits_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(erp_product_id, designation, categorie_stock, prix_achat, prix_vente, stock);


TRUNCATE TABLE erp_details_commandes_raw;
LOAD DATA INFILE '/var/lib/mysql-files/erp_source/erp_details_commandes.csv'
INTO TABLE erp_details_commandes_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(erp_order_id, erp_client_id, erp_product_id, date_facture, quantite, prix_unitaire, statut);