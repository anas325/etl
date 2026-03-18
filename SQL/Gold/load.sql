SET FOREIGN_KEY_CHECKS = 0;

USE ecommerce_gold;


TRUNCATE dim_produits;
INSERT into dim_produits
SELECT distinct * from ecommerce_silver.produits_clean;



TRUNCATE dim_client;
INSERT into dim_client
SELECT distinct * from ecommerce_silver.client_clean;



TRUNCATE dim_date;
INSERT INTO dim_date
SELECT
    DATE_FORMAT(d, '%Y%m%d') + 0,
    d,
    DAY(d),
    MONTH(d),
    YEAR(d),
    QUARTER(d),
    DAYNAME(d),
    MONTHNAME(d),
    WEEK(d, 1),
    CASE WHEN DAYOFWEEK(d) IN (1,7) THEN TRUE ELSE FALSE END
FROM (
    SELECT DATE('2020-01-01') + INTERVAL n DAY AS d
    FROM (
        SELECT a.N + b.N*10 + c.N*100 + d.N*1000 AS n
        FROM (SELECT 0 N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
              UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
        CROSS JOIN (SELECT 0 N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
                    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
        CROSS JOIN (SELECT 0 N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
                    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
        CROSS JOIN (SELECT 0 N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
                    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) d
    ) numbers
    WHERE n <= DATEDIFF('2030-12-31','2020-01-01')
) dates;

INSERT into fact_orders
(time_key, customer_key, product_key, order_number, quantite, revenue, 
cost, profit
)

SELECT distinct
dd.date_key, client_id, ecom.product_id, order_id, quantite, quantite*p.prix_vente,
quantite*p.prix_achat,
quantite*p.prix_vente-quantite*p.prix_achat


from ecommerce_silver.detail_commande_clean ecom 
join dim_date dd
on ecom.date_commande = dd.full_date
join dim_produits p on ecom.product_id = p.product_id;

SET FOREIGN_KEY_CHECKS = 1;