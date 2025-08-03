with job_company as (
select
    job_postings_fact.job_id,
    company_dim.name as company_name,
    job_postings_fact.salary_year_avg
from
    job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id
where
    job_title_short = 'Data Analyst' and
--     job_work_from_home = true and
    salary_year_avg is not null
)

select
    skills,
    round(avg(salary_year_avg), 2) as salary
from
    job_company
inner join skills_job_dim on job_company.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
group by
    skills
order by
    salary desc;