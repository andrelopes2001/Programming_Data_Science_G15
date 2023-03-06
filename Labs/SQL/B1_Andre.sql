USE university;

-- B_1a
SELECT course.title FROM course WHERE course.credits = 3;

-- B_1b
SELECT student.name FROM student
JOIN takes ON student.ID = takes.ID
JOIN teaches ON takes.course_id = teaches.course_id
JOIN instructor ON teaches.ID = instructor.ID
WHERE instructor.name = 'Einstein';

-- B_1c
SELECT MAX(salary) AS highest_salary FROM instructor;

-- B_1d
set @highest_salary = (select MAX(salary) from instructor);
select instructor.name from instructor where instructor.salary = @highest_salary;

-- B_1e
select course_id, count(*)
from takes
where course_id in
(select section.course_id from section
where section.semester = 'Fall') and takes.semester = 'Fall'
group by course_id;

-- B_1f
create table if not exists temp as
	(select course_id, count(*) as enrollments
	from takes
	where course_id in
	(select section.course_id from section
	where section.semester = 'Fall') and takes.semester = 'Fall'
	group by course_id);
select max(enrollments) as max_n_enrollments from temp;

-- B_1g
create table if not exists temp as
	(select course_id, count(*) as enrollments
	from takes
	where course_id in
	(select section.course_id from section
	where section.semester = 'Fall') and takes.semester = 'Fall'
	group by course_id);
select course_id from temp where enrollments = (select max(enrollments) from temp);