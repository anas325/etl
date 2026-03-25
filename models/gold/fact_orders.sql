select distinct
    dd.date_key                                                as time_key,
    o.client_id                                               as customer_key,
    o.product_id                                              as product_key,
    o.order_id                                                as order_number,
    o.quantite,
    o.quantite * p.prix_vente                                 as revenue,
    o.quantite * p.prix_achat                                 as cost,
    o.quantite * p.prix_vente - o.quantite * p.prix_achat     as profit
from {{ ref('detail_commande_clean') }} o
join {{ ref('dim_date') }}     dd on o.date_commande = dd.full_date
join {{ ref('dim_produits') }}  p on o.product_id    = p.product_id
