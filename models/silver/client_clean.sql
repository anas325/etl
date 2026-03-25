select
    crm_client_id        as customer_id,
    'CRM'                as source_system,
    trim(nom)            as nom,
    lower(trim(email))   as email,
    trim(telephone)      as telephone,
    trim(ville)          as ville,
    null                 as pays,
    upper(trim(segment)) as segment,
    str_to_date(date_inscription, '%Y-%m-%d') as date_creation
from {{ ref('crm_clients') }}
where crm_client_id is not null

union all

select
    erp_client_id  as customer_id,
    'ERP'          as source_system,
    trim(nom)      as nom,
    null           as email,
    null           as telephone,
    trim(ville)    as ville,
    trim(pays)     as pays,
    null           as segment,
    str_to_date(date_creation, '%Y-%m-%d') as date_creation
from {{ ref('erp_clients') }}
where erp_client_id is not null
