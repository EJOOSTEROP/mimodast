SELECT *
FROM {{ ref('rpt_gie_storage')}}
WHERE gasinstorage > workinggasvolume