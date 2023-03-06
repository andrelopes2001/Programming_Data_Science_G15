use chinook;

-- B_6a
select BillingCountry, count(InvoiceId) as count
from Invoice
group by BillingCountry
order by count desc;

-- B_6b
select BillingCity, sum(Total) as total_city_ammount
from Invoice
group by BillingCity
order by total_city_ammount desc;

-- B_6c