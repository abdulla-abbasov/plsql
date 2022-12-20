begin

dbms_output.put_line('Fathers ''s day');


end;


select q'? it is fasther's day ?' from dual ;









declare

v_no number:=300;
v_date date;
v_timestampt timestamp;
v_project_period interval year to month;



begin
v_no:=123.23;
v_date:=sysdate;
v_timestampt:=current_timestamp;
v_project_period:='03-05';

dbms_output.put_line(v_no);
dbms_output.put_line(v_date);
dbms_output.put_line(v_timestampt);
dbms_output.put_line('project period is'||'='||v_project_period);
dbms_output.put_line(to_char(sysdate,'dd-mm-yyyy hh:mi:ss'));

end;




-- %type attribute using 
declare
v_salary employees.salary%type;


begin
v_salary:=100;
dbms_output.put_line(v_salary);



end;



select *from employees where employee_id=100;

declare
v_name employees.first_name%type;
v_salary employees.salary%type;



begin

select first_name,salary into v_name,v_salary from employees where employee_id=100;

dbms_output.put_line(v_name);
dbms_output.put_line(v_salary);


end;


---- bind variables



variable v_result number;


begin

select salary into :v_result from employees where employee_id=100;


end;


print v_result;



begin  <<outer>>
declare
v_name varchar2(100):='Nurlan';
v_date date:='21-Oct-2003';
v_age number(4):=12;

begin

   declare
   v_age number(5):=33;
   v_name varchar2(100):='Abdulla';
   
   begin
   
   dbms_output.put_line(v_age);
   dbms_output.put_line(outer.v_age);

   
   end ;


end;
end outer;
















