select
    erp_order_id                              as order_id,
    erp_client_id                             as client_id,
    erp_product_id                            as product_id,
    str_to_date(date_facture, '%Y-%m-%d')     as date_commande,
    cast(quantite as unsigned)                as quantite,
    statut,
    'ERP'                                     as source_system
from {{ ref('erp_details_commandes') }}

union all

select
    crm_order_id                              as order_id,
    crm_client_id                             as client_id,
    crm_product_id                            as product_id,
    str_to_date(date_commande, '%Y-%m-%d')    as date_commande,
    cast(quantite as unsigned)                as quantite,
    null                                      as statut,
    'CRM'                                     as source_system
from {{ ref('crm_details_commandes') }}
