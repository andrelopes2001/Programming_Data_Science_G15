use university;

set @highest_salary = (select MAX(salary) from instructor);

select instructor.name from instructor where instructor.salary = @highest_salary;