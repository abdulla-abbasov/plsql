---

create table ename as
select distinct first_name from employees;

select * from ename;






declare
type ename_t is table of varchar2(100);
ename_table ename_t:=ename_t();
c number:=0;


begin
for i in (select * from ename)
loop
c:=c+1;
ename_table.extend;
ename_table(c):=i.first_name;
end loop;   
forall i in ename_table.first..ename_table.last save exceptions

update ename set first_name=first_name||' to be added' where first_name=ename_table(i);
exception
when others  then null;


end;

select * from ename;


---- design bulk statement 6


drop table ename;

create table ename as

select distinct first_name from employees;

declare
type ename_type is table of varchar2(100);
ename_table ename_type:=ename_type();
c number:=0;
errors number;
begin
for i in (select * from ename)
loop
c:=c+1;
ename_table.extend;
ename_table(c):=i.first_name;
end loop;

forall i in ename_table.first..ename_table.last save exceptions
update ename set first_name=first_name||'  to be added' where first_name=ename_table(i);

exception when others then
errors:=sql%bulk_exceptions.count;
dbms_output.put_line('The total numbers of errors occuered are '||errors);
for j in errors
loop

dbms_output.put_line('error iteration is'||sql%bulk_exceptions(j).error_index
||'error code is '||sql%bulk_exceptions(j).error_code||'error message is '
||sqlerrm(-sql%bulk_exceptions(j).error_code));
end loop;
end;



--bulk collect

create table ename_2 as

select first_name,last_name from employees;

select * from ename_2;

declare
type t_emp is table of varchar2(100);
v_emp t_emp:=t_emp();
c number:=0;


begin
select first_name bulk collect into v_emp from ename_2;
for i in v_emp.first..v_emp.last
loop
dbms_output.put_line(v_emp(i));

end loop;


end;




--- cursor without bulk collect
declare
type  emp_t is table of employees%rowtype;
emp_table emp_t;
cursor emp_c is select * from employees;
c number:=0;
begin
emp_table:=emp_t();
open emp_c;
loop
emp_table.extend;
c:=c+1;
fetch emp_c into emp_table(c);
exit when emp_c%notfound;
dbms_output.put_line(emp_table(c).salary);
end loop;
close emp_c;
end;

-- with bulk collection


declare
type emp_t is table of employees%rowtype;
emp_table emp_t;
cursor emp_c is select * from employees;


begin
open emp_c;

fetch emp_c bulk collect into emp_table;
for i in emp_table.first..emp_table.last
loop

dbms_output.put_line(emp_table(i).first_name);

end loop;


end;



-- bulk collection with limit
declare
type emp_t is table of departments%rowtype;
emp_table  emp_t;
cursor emp_c is select * from departments ;
begin
open emp_c;
fetch emp_c bulk collect into emp_table limit 5;
for i in emp_table.first..emp_table.last
loop
dbms_output.put_line(emp_table(i).manager_id);
end loop;
close emp_c;
end;





select * from departments;


create or replace procedure change_emp(emp_id number,emp_salary number)
is
new_sal number(25);
begin
update employees set salary=salary+emp_salary where employee_id=emp_id
returning salary into new_sal;
dbms_output.put_line(new_sal);
end;


exec change_emp(100,50);


drop table emp_2;

create table emp_2 as
select employee_id,salary from employees;


select * from emp_2;

declare
type emp_t is table of emp_2%rowtype;
emp_table emp_t:=emp_t();
emp_table_2 emp_t:=emp_t();
begin
select * bulk collect into emp_table from emp_2;
forall i in emp_table.first..emp_table.last

update emp_table set salary=salary/2  where employee_id=emp_table(i).employee_id
returning  salary,employee_id bulk collect into emp_table_2;
for i in emp_table_2.first.. emp_table_2.last
   loop
   dbms_output.put_line(emp_table_2(i).employee_id||emp_table_2(i).salary);
   end loop;
end;

------------

declare
type emp_t is table of number index by binary_integer;
emp_table emp_t;
begin
emp_table(1):=100;
emp_table(2):=101;
emp_table(3):=102;
emp_table(101):=104;
dbms_output.put_line(emp_table.first||emp_table.last);
forall i in emp_table.first..emp_table.last save exceptions
update employees set salary=salary+100 where employee_id=emp_table(i);
end;





declare
type emp_t is table of number index by binary_integer;
emp_table emp_t;
begin
emp_table(1):=100;
emp_table(2):=101;
emp_table(3):=102;
emp_table(101):=104;
dbms_output.put_line(emp_table.first||emp_table.last);
forall i in indices of emp_table
update employees set salary=salary+100 where employee_id=emp_table(i);
end;










