select distinct *
from {{ ref('client_clean') }}
