SELECT _sdc_batched_at,
       _sdc_extracted_at,
       id,
       properties_place as place,
       epoch_ms(properties_time::BIGINT) as event_time,
       properties_mag as magnitude,
       properties_alert as alert,
       properties_url as event_url,
       properties_detail as detail_url,
       geometry_coordinates,
       geometry_type
FROM {{ source('usgs_stage', 'stg_usgs_earthquakes') }}
