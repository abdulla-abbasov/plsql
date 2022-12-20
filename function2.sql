--
create or replace function get_sal(emp_id number)
return number
is 
v_sal number;
begin

select salary into v_sal from employees where employee_id=emp_id;
return v_sal;

end;


begin
dbms_output.put_line(get_sal(100));
end;
execute dbms_output.put_line(get_sal(100));

select get_sal(100) from dual;

select * from user_objects where object_name='get_sal';

select line,text from user_source where name='GET_SAL';



create or replace function get_sal(emp_id number)
return number
is 
v_sal number;
begin

select salary into v_sal from employees where employee_id=emp_id;
return v_sal;
EXCEPTION
WHEN no_data_found then
return -1;
end;

execute dbms_output.put_line(get_sal(999));




