{{ config(error_if = '>50') }}

SELECT *
FROM {{ ref('rpt_gie_storage')}}
WHERE gasinstorage - workinggasvolume > 5