select
    crm_product_id                         as product_id,
    trim(nom_produit)                      as nom_produit,
    trim(categorie)                        as categorie,
    null                                   as prix_achat,
    cast(prix_catalogue as decimal(10, 2)) as prix_vente,
    null                                   as stock,
    'CRM'                                  as source_system
from {{ ref('crm_produits') }}
where crm_product_id is not null

union all

select
    erp_product_id                      as product_id,
    trim(designation)                   as nom_produit,
    trim(categorie_stock)               as categorie,
    cast(prix_achat as decimal(10, 2))  as prix_achat,
    cast(prix_vente as decimal(10, 2))  as prix_vente,
    cast(stock as unsigned)             as stock,
    'ERP'                               as source_system
from {{ ref('erp_produits') }}
where erp_product_id is not null
