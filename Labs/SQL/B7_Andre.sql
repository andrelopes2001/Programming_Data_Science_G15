-- B_7a
select custid, fname, dob, year(current_date())-year(dob) as age from customer
order by YEAR(dob), fname;

-- B_7b
select custid, fname, (CASE WHEN mname IS NULL THEN ltname ELSE mname END) as custname
from customer
order by custname;

-- B_7c
select acnumber, customer.custid, fname, ltname, aod 
from account, customer
where account.custid = customer.custid;

-- B_7d
select count(custid) as cust_count 
from customer
where city = 'Delhi';

-- B_7e
select acnumber, customer.custid, fname
from account, customer
where account.custid = customer.custid and day(aod) > 15;

-- B_7f
select acnumber, fname, city, occupation 
from account, customer
where account.custid=customer.custid and occupation != 'Student 'and occupation != 'Service' and occupation != 'Business';

-- B_7g
select bcity, count(bid) as city_count
from branch
group by bcity
order by city_count;

-- B_7h
select acnumber, customer.custid, fname
from account, customer
where account.custid = customer.custid and account.astatus = 'Active';

-- B_7i
select customer.custid, fname, sum(loan_amount) as total_amount
from loan, customer
where loan.custid = customer.custid
group by loan.custid;




