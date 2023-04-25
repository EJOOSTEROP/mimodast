WITH
SSO AS 
(SELECT 
        _sdc_batched_at::TIMESTAMP _sdc_batched_at,
        _sdc_extracted_at::TIMESTAMP _sdc_extracted_at,
        gasdaystart::DATE gasdaystart,
        split_part(url, '/', 2) as country,
        split_part(url, '/', 3) as company_eic,
        key_hash,
        code as sso_eic,
        name as sso_name,
        status,
        TRY_CAST(t.full AS DOUBLE) as sso_fill_ratio,
        TRY_CAST(gasinstorage AS DOUBLE) as gasinstorage,
        TRY_CAST(workinggasvolume AS DOUBLE) as workinggasvolume,
        TRY_CAST(injection as DOUBLE) as injection,
        TRY_CAST(withdrawal AS DOUBLE) as withdrawal,
        url,
        split_part(url, '/', 1) as EIC_likely,
        split_part(url, '/', 2) as country_likely,
        split_part(url, '/', 3) as company_likely
FROM 
    {{ source('gie_stage', 'stg_gie_storage') }} t
),

COMPANY AS
(SELECT
        gasdaystart::DATE gasdaystart,
	code as company_eic,
	name as company_name,
	TRY_CAST(gasinstorage AS DOUBLE)  as comp_gasinstorage,
	TRY_CAST(workinggasvolume AS DOUBLE) as comp_workinggasvolume
FROM
	{{ source('gie_stage', 'stg_gie_company') }}
)

select 
        _sdc_batched_at,
        _sdc_extracted_at,
        key_hash,
        sso.gasdaystart,
        country,
        SSO.company_eic,
        company_name,
        sso_eic,
        sso_name,
        status,
        sso_fill_ratio,
        gasinstorage,
        comp_gasinstorage,
        workinggasvolume,
        comp_workinggasvolume,
        injection,
        withdrawal,
        year(sso.gasdaystart) as reporting_year,
        make_date(2000, month(sso.gasdaystart), day(sso.gasdaystart)) as reporting_day
from SSO left join COMPANY 
on sso.gasdaystart = COMPANY.gasdaystart 
and 
sso.company_eic = company.company_eic
