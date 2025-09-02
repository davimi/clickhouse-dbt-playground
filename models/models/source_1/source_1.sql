select
    JSONExtractString(column_2, 'column_1') as column_1
from {{ source("sources", "source_1") }}
