use university;

select course_id, count(*)
from takes
where course_id in
(select section.course_id from section
where section.semester = 'Fall') and takes.semester = 'Fall'
group by course_id;