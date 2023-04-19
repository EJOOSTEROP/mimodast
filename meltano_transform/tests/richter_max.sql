SELECT *
FROM {{ ref('rpt_usgs_events')}}
WHERE magnitude > 10