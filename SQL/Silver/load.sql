
USE ecommerce_silver;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE ecommerce_silver.client_clean;

INSERT INTO ecommerce_silver.client_clean
    (customer_id, source_system, nom, email, telephone, ville, segment, date_creation)

-- CRM clients
SELECT
    crm_client_id,
    'CRM',
    TRIM(nom),
    LOWER(TRIM(email)),
    TRIM(telephone),
    TRIM(ville),                                       
    UPPER(TRIM(segment)),
    STR_TO_DATE(date_inscription, '%Y-%m-%d')
FROM ecommerce_bronze.crm_clients_raw
WHERE crm_client_id IS NOT NULL

UNION ALL

-- ERP clients
SELECT
    erp_client_id,
    'ERP',
    TRIM(nom),
    NULL,                                             -- ERP has no email column
    NULL,                                             -- ERP has no telephone column
    TRIM(ville),
    NULL,                                             -- ERP has no segment column
    STR_TO_DATE(date_creation, '%Y-%m-%d')
FROM ecommerce_bronze.erp_clients_raw
WHERE erp_client_id IS NOT NULL;



SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE ecommerce_silver.produits_clean;

INSERT INTO ecommerce_silver.produits_clean
    (product_id, nom_produit, categorie, prix_achat, prix_vente, stock, source_system)

SELECT
    crm_product_id,
    TRIM(nom_produit),
    TRIM(categorie),
    NULL,                               -- no prix_achat in CRM
    CAST(prix_catalogue AS DECIMAL(10,2)), 
    NULL,                               -- no stock in CRM
    'CRM'
FROM ecommerce_bronze.crm_produits_raw
WHERE crm_product_id IS NOT NULL

UNION ALL

SELECT
    erp_product_id,
    TRIM(designation),
    TRIM(categorie_stock),
    CAST(prix_achat AS DECIMAL(10,2)),
    CAST(prix_vente AS DECIMAL(10,2)),
    CAST(stock      AS UNSIGNED),
    'ERP'
FROM ecommerce_bronze.erp_produits_raw
WHERE erp_product_id IS NOT NULL;



TRUNCATE TABLE detail_commande_clean;
INSERT into detail_commande_clean
    ( order_id   ,
    client_id    ,
    product_id   ,
    date_commande,
    quantite     ,
    statut       ,             
    source_system)

    SELECT erp_order_id,
    erp_client_id,
    erp_product_id,
    date_facture,
    quantite,
    statut,
    'ERP'
    from ecommerce_bronze.erp_details_commandes_raw 

    UNION ALL 

    SELECT
    crm_order_id,
    crm_client_id,
    crm_product_id,
    date_commande,
    quantite,
    NULL,
    'CRM'
    from  ecommerce_bronze.crm_details_commandes_raw;


SET FOREIGN_KEY_CHECKS = 1;