with top_paying_company as (
    select
        job_id,
        job_title_short,
        salary_year_avg,
        name as company_name
    from job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
    where
        job_title_short = 'Data Analyst' and
        salary_year_avg is not null and
        job_location = 'Anywhere'
)

select
    top_paying_company.*,
    skills
from top_paying_company
    inner join skills_job_dim on (top_paying_company.job_id) = (skills_job_dim.job_id)
    inner join skills_dim on (skills_job_dim.skill_id) = (skills_dim.skill_id)
where
    salary_year_avg is not null
order by
    salary_year_avg desc;