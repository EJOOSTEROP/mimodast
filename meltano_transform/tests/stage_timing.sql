SELECT *
FROM {{ ref('rpt_gie_storage')}}
WHERE _sdc_batched_at < _sdc_extracted_at