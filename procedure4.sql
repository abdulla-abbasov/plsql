--
create or replace procedure update_sal2(v_id in  number,v_sal in number)
is

begin
update employees set salary=salary+v_sal where employee_id=v_id;
commit;
exception
when others then
dbms_output.put_line(sqlerrm);
dbms_output.put_line(sqlcode);
end;

select * from user_errors where name='update_sal2';


execute update_sal2(100,50);

select * from employees where employee_id=100;

select * from user_objects where object_name='update_sal2';

select * from user_source where name='update_sal2' order by line;


begin

update_sal2();

end;


drop procedure update_sal2;




create or replace procedure show_info(p_id employees.employee_id%type,
p_name out employees.first_name%type,
p_sal out employees.salary%type
)
is


begin
select first_name,salary into p_name,p_sal from employees where employee_id=p_id;
exception when others then
dbms_output.put_line(sqlerrm);
dbms_output.put_line(sqlcode);




end;

variable v_sal number
variable v_name varchar2(50)

execute show_info(105,:v_name,:v_sal);

print v_sal;
print v_name;



declare
v_sal employees.salary%type;
v_name employees.first_name%type;
begin
show_info(105,v_name,v_sal);

dbms_output.put_line(v_name||''||v_sal);

end;



