SHOW data_directory;

CREATE TABLE DS (
    id SERIAL PRIMARY KEY,
    job_title VARCHAR(255),
    salary_estimate VARCHAR(50),
    job_description TEXT,
    rating FLOAT,
    company_name VARCHAR(255),
    locations VARCHAR(255),
    headquarters VARCHAR(255),
    size_of_company VARCHAR(255),
    founded INTEGER,
    type_of_ownership VARCHAR(255),
	industry VARCHAR(50),
	sector VARCHAR(50),
    revenue VARCHAR(255),
    competitors VARCHAR(255)
);

COPY DS
FROM '/Users/angtingwei/Uncleaned_DS_jobs.csv'
DELIMITER ','
CSV HEADER;

-- Add all calculated and text fields
ALTER TABLE DS
ADD COLUMN simple_job_title VARCHAR(25),
ADD COLUMN Seniority VARCHAR(10),
ADD COLUMN min_salary INTEGER,
ADD COLUMN max_salary INTEGER,
ADD COLUMN avg_salary INTEGER,
ADD COLUMN job_state CHAR(2),
ADD COLUMN same_state INTEGER,
ADD COLUMN python INTEGER,
ADD COLUMN sql_language INTEGER,
ADD COLUMN excel INTEGER,
ADD COLUMN hadoop INTEGER,
ADD COLUMN spark INTEGER,
ADD COLUMN aws INTEGER,
ADD COLUMN gcp INTEGER,
ADD COLUMN tableau INTEGER;

-- Fill cleaned_job_title with values	
UPDATE DS
SET simple_job_title = 
	CASE
        WHEN job_title ILIKE '%scientist%' THEN 'Data Scientist'
        WHEN job_title ILIKE '%ml%' OR job_title ILIKE '%machine learning%' THEN 'ML Engineer'
        WHEN job_title ILIKE '%engineer%' OR job_title ILIKE '%modeler%' OR job_title ILIKE '%architect%' THEN 'Data Engineer'
        WHEN job_title ILIKE '%analyst%' THEN 'Analyst'
        WHEN job_title ILIKE '%manager%' THEN 'Manager'
        ELSE '-1'
    END;	

-- Fill Seniority 
UPDATE DS
SET Seniority =
	CASE
		WHEN job_title ILIKE '%sr%' OR job_title ILIKE '%senior%' THEN 'Senior'
		WHEN job_title ILIKE '%jr%' OR job_title ILIKE '%junior%' THEN 'Junior'
		ELSE '-1'
	END;

-- Change Salary Estimate to 'int-int'
UPDATE DS
SET salary_estimate = 
		regexp_replace(split_part(salary_estimate, '-', 1), '[^\d]', '', 'g') || '-' ||
		regexp_replace(split_part(salary_estimate, '-', 2), '[^\d]', '', 'g')

-- Fill min_salary, max_salary, avg_salary
UPDATE DS
SET min_salary = CAST(split_part(salary_estimate, '-', 1) AS INTEGER),
max_salary = CAST(split_part(salary_estimate, '-', 2) AS INTEGER);

UPDATE DS
SET avg_salary = min_salary + (max_salary - min_salary)/2;
		
-- Change -1 entries to 0 in ratings
UPDATE DS
SET rating = 0
WHERE rating = -1;

-- Fixing locations entries
SELECT DISTINCT locations FROM DS
WHERE LENGTH(TRIM(split_part(locations, ',', 2))) != 2

UPDATE DS
SET locations =
	CASE
		WHEN locations = 'New Jersey' THEN 'New Jersey, NJ'
		WHEN locations = 'California' THEN 'California, CA'
		WHEN locations = 'Utah' THEN 'Utah, UT'
		WHEN locations = 'Texas' THEN 'Texas, TX'
		WHEN locations = 'United States' THEN 'United States, US'
		WHEN locations = 'Remote' THEN 'Remote, RE'
		ELSE locations
	END;

UPDATE DS
SET locations = 'MaryLand, MD'
WHERE locations = 'Patuxent, Anne Arundel, MD';

-- Fill job_state and same_state
UPDATE DS
SET job_state = TRIM(split_part(locations, ',', 2)),
same_state = 
	CASE
		WHEN TRIM(split_part(locations, ',', 2)) = TRIM(split_part(headquarters, ',', 2)) THEN 1
		ELSE 0
	END;

-- Fill all data tools columns
UPDATE DS
SET 
    python = CASE WHEN job_description ILIKE '%python%' THEN 1 ELSE 0 END,
    sql_language = CASE WHEN job_description ILIKE '%sql%' THEN 1 ELSE 0 END,
    excel = CASE WHEN job_description ILIKE '%excel%' THEN 1 ELSE 0 END,
    hadoop = CASE WHEN job_description ILIKE '%hadoop%' THEN 1 ELSE 0 END,
    spark = CASE WHEN job_description ILIKE '%spark%' THEN 1 ELSE 0 END,
    aws = CASE WHEN job_description ILIKE '%aws%' THEN 1 ELSE 0 END,
    gcp = CASE WHEN job_description ILIKE '%gcp%' THEN 1 ELSE 0 END,
    tableau = CASE WHEN job_description ILIKE '%tableau%' THEN 1 ELSE 0 END;
	
-- fixing size_of-company column
SELECT size_of_company, count(*) 
FROM DS 
GROUP BY size_of_company;

UPDATE DS
SET size_of_company = '-1'
WHERE size_of_company = 'Unknown';

-- Add Company age column 
ALTER TABLE DS
ADD COLUMN company_age INTEGER;

--Fill Company age column
UPDATE DS
SET company_age = 
	CASE
		WHEN founded = -1 THEN -1
		ELSE 2021 - founded
	END;

--Drop unnecessary columns
ALTER TABLE DS
DROP COLUMN founded,
DROP COLUMN competitors;

-- export as csv 
COPY (
    SELECT *
    FROM DS
    ORDER BY id
) TO '/Users/angtingwei/glassdoor_DS_jobs.csv'
WITH CSV HEADER;





