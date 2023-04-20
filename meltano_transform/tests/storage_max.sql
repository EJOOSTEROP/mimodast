{{ config(
    error_if = '>50',
    warn_if = '>0'
    ) }}

SELECT *
FROM {{ ref('rpt_gie_storage')}}
WHERE gasinstorage - workinggasvolume > 1.75