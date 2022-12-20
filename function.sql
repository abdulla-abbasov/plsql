-- now compling function

create or replace function pranc_func(emp_id number)
return number
is 
v_sal number;

begin
select salary into v_sal from employees where employee_id=emp_id;
return v_sal;


end;

-- invoke a function right now;
SET SERVEROUTPUT ON;
declare

v_v number;



begin


dbms_output.put_line(func_prac(100));


end;




create or replace function examp_func(emp_id number)
return varchar2
is
f_name employees.first_name%type;
begin

select first_name into f_name from employees where employee_id=emp_id;
dbms_output.put_line(f_name);
return f_name;
end;


select * from employees;



create or replace function get_sal(emp_id number)
return number
is
v_sal employees.salary%type;

begin

select salary into v_sal from employees where employee_id=emp_id;
return v_sal;
end;

set serveroutput on;
declare
v_exec number;


begin

v_exec:=get_sal(100);
dbms_output.put_line(v_exec);


end;



begin


dbms_output.put_line(get_sal(100));


end;



select *from user_objects 
where object_name='GET_SAL';


-- NO DATA FOUND IN FUNCTION

 create or replace function get_sal(emp_id number)
return number
is
v_sal employees.salary%type;

begin

select salary into v_sal from employees where employee_id=emp_id;
return v_sal;
EXCEPTION when no_data_found then
 return -1;
end;

begin


dbms_output.put_line(get_sal(9999));


end;



