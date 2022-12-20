declare
v_sal employees.salary%type;
new_salary employees.salary%type;



begin
select  salary into v_sal from employees where employee_id=100;
dbms_output.put_line('old salary '||v_sal);
new_salary:=v_sal+100;

update employees set salary=new_salary  where employee_id=100;
dbms_output.put_line('new salary '||new_salary);

insert into departments(department_id,department_name,manager_id,location_id)
values (1,'test',null,null);
commit;

end;




select * from employees where employee_id=100;

select *from departments where department_id=1;





select * from employees where department_id=20;

declare

v_rows_updated number:=0;

begin

update employees set salary=salary+100 where department_id=20;

v_rows_updated:=sql%rowcount;

dbms_output.put_line('number of rows affected by sql '||v_rows_updated);

end;




declare
v_rows_exist boolean:=true;
begin
update employees set salary=salary+100 where employee_id=9999;
v_rows_exist:=sql%found;

if v_rows_exist=false then
dbms_output.put_line('no rows affected by this commanf');
else 
dbms_output.put_line('rows affected by command');
end if;
end;
