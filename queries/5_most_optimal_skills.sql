-- Combining insights from demand and salary data,
-- this query aimed to pinpoint skills that are both in high demand and have high salaries,
-- offering a strategic focus for skill development.

select
    skills_dim.skills,
    count(skills_dim.skills) as skills_demand,
    round(avg(salary_year_avg), 2) as skills_avg_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where
    job_title_short = 'Data Analyst' and
    salary_year_avg is not null
--     job_work_from_home = true
group by
    skills_dim.skills
having
    count(skills_dim.skills) > 10
order by
    skills_avg_salary desc,
    skills_demand desc
limit
    10;