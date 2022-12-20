--procedure
create or replace procedure update_sal(v_emp_id in number,v_salary in number)
as

begin
update employees set salary=salary+v_salary where employee_id=v_emp_id;
commit;
dbms_output.put_line('succesfully executed');


end;


create or replace procedure up_sal
(emp_id in employees.employee_id%type,v_name out employees.first_name%type,v_salary out employees.salary%type)
as 

begin

select first_name,salary into v_name,v_salary from employees where employee_id=emp_id;

exception when others then

dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

end;


declare

v_n employees.first_name%type;
v_s employees.salary%type;

begin

up_sal(100,v_n,v_s);
dbms_output.put_line(v_n);
dbms_output.put_line(v_s);

end;


--declaring bind variable'


variable first_name varchar2(100)
variable v_salary number

execute up_sal(100,:first_name,:v_salary)

print first_name v_salary




-- another way to prin out variable




declare
v_na employees.first_name%type;
v_sa employees.salary%type;


begin

up_sal(100,v_na,v_sa);
dbms_output.put_line(v_na||' '||v_sa);

end;






select * from employees where employee_id=100;
execute update_sal(100,50);

select * from user_errors where name='update_sal';

select * from employees;

select * from employees where employee_id=100;

execute update_sal(100,50) ;
select * from employees where employee_id=100;

begin
update_sal(&emp_id,&emp_sal);

end;


select * from user_objects where object_name='update_sal';

select *from user_source where name='update_sal' order by line;



drop procedure update_sal;


select * from user_errors;







--- imagine we have 12 lengths tel number for ex
--994706006546  994 (70) 6006546;

create or replace procedure format_tel(
v_tel in out varchar2
)
is

begin

v_tel:=substr(v_tel,1,3)||'('||substr(v_tel,4,2)||')'||substr(v_tel,6);


end;

declare

v_n varhcar2(100);

variable v_nomre varchar2(100);

execute :v_nomre:='994706006546'
execute format_tel(:v_nomre)
print :v_nomre


declare
v_tel varchar2(100);


begin
v_tel:='994706006546';
format_tel(v_tel);
dbms_output.put_line(v_tel);


end;
-- exception handling  


--exception handling with boolean type

create or replace procedure p(v boolean)
as
x boolean;
begin
x:=v;
if x then
dbms_output.put_line('it is true');
else 
dbms_output.put_line('its false');

end if;


end;



execute p(false);

--- 



create or replace procedure test_proc(
v_dep in departments%rowtype
)
as
begin

insert into departments values v_dep;

end;


select * from departments;



declare

v_rec departments%rowtype;


begin
v_rec.department_id:=2;
v_rec.department_name:='baliqcilix';

test_proc(v_rec);



end;


select * from departments;

