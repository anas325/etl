select distinct *
from {{ ref('produits_clean') }}
