--
drop table test_emp;

create table test_emp(emp_id number,
first_name varchar2(100));

create or replace trigger emp_test_check
for insert or update or delete
on test_emp
compound trigger
--we can define variables here
--x number;
    before statement is
    begin
    dbms_output.put_line('1');
    end before statement;
    
    before each row is
    begin
    dbms_output.put_line('2');
    
    end before each row;
    
    after each row is
    begin
    dbms_output.put_line('3');
    end after each row;
    
    after statement is
    begin
    dbms_output.put_line('4');
    
    end after statement;
 
end;    
    
    
insert into test_emp values(2,'Nurlan');  

select * from customers;
    drop table customers;
create table customers(cust_id number,v_name varchar2(100));
desc customers;

create or replace trigger before_innsert
before  insert on customers
for each row
declare
max_id number;


begin
select nvl(max(cust_id),0)+1 into max_id  from customers;
:new.cust_id:=max_id;
end;

truncate table customers;
select * from customers;
insert into customers(v_name) values('Abdulla');

select * from customers;

select max(cust_id) form customers;
select * from employees;
select job_id,min(salary),max(salary) from employees group by job_id order by 1;


create or replace trigger update_check_sal 
before insert or update on employees
for each row
declare
v_min_sal number;
v_max_sal number;
begin
  select max(salary),min(salary) into v_min_sal,v_max_sal from employees where job_id=:new.job_id;
  if :new.salary not between v_min_sal and v_max_sal then
  raise_application_error(-20300,'Bu mebleg daxil edile bilmez');
  end if;

end;

drop trigger update_check_sal;

create or replace trigger check_sal 
for 
insert or update on employees
compound trigger
type emp_sal is record(minsal number,maxsal number);
type emp_arr is table of emp_sal index by binary integer;
emp emp_arr;
 before statement is
 begin
 for i in(select job_id,min(salary) min_sal,max(salary) max_sal from employees group by job_id order by 1)
 loop
 emp(i.job_id).minsal:=i.min_sal;
 emp(i.job_id).maxsal:=i.max_sal;
 
 end loop;
 end before statement;
 
 before each row is
 begin
 if :new.salary not between emp(:new.job_id).minsal and emp(:new.job_id).maxsal then
    raise_application_error(-20300,'invalid range');
    end if;
 end before each row;
end;














