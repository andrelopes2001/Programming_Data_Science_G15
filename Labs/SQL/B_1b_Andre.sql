USE university;

SELECT student.name FROM student
JOIN takes ON student.ID = takes.ID
JOIN teaches ON takes.course_id = teaches.course_id
JOIN instructor ON teaches.ID = instructor.ID
WHERE instructor.name = 'Einstein';