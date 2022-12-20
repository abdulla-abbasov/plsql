--exception


declare

v_name varchar2(100);


begin

select first_name into v_name from employees where employee_id=1;

    exception
    when no_data_found then
    dbms_output.put_line('no return values from this statement');

end;



declare
v_id employees.employee_id%type;


begin

select employee_id into v_id from employees where first_name=&x;
dbms_output.put_line('employee idsi: '||v_id);

exception
when no_data_found then

dbms_output.put_line('data tapilmadi');

when too_many_values then
dbms_output.put_line('coxlu data qayitdi');
when others then
dbms_output.put_line('basqa error var fix etmek lazim');




end;


declare
v_name employees.first_name%type;
begin   
for i in 99..104
LOOP
BEGIN
select first_name into v_name from employees where employee_id=i;
dbms_output.put_line('employee idili calisanin adi: '||v_name);
   EXCEPTION WHEN NO_DATA_FOUND THEN 
   NULL;
   
 END;
END LOOP;


end;


--

desc departments;

declare
e_error exception;
pragma exception_init(e_error,-01400);



begin
 
 begin
 insert into departments(department_id,department_name) values
 (150,null);
 exception when e_error then
 dbms_output.put_line('insert failed');
 dbms_output.put_line(sqlcode);
 dbms_output.put_line(sqlerrm);
 when others then
 null;
 end;
 
 
 begin
 update employees set employee_id='12' where employee_id=100;
 
 exception 
 when others then
 dbms_output.put_line('failed');
 dbms_output.put_line(sqlcode);
 dbms_output.put_line(sqlerrm);

 
 
 
 
 end;


end;




--user defined exceptions;


declare

v_emp_id  number:=1;

err_msg exception;


begin
update employees set salary=salary+100 where employee_id=v_emp_id;

dbms_output.put_line(sql%rowcount);

if sql%notfound then
 raise err_msg;
end if;

commit;

exception when err_msg then

dbms_output.put_line('No data');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);


end;




--group functions in exception

declare
v_sum number;



begin
select sum(salary) into v_sum from employees where department_id=&n;
dbms_output.put_line(v_sum);
dbms_output.put_line(sql%rowcount);

exception when others then
dbms_output.put_line('basqa error var');





end;


declare
v_num_sal number;
v_er exception;



begin
select sum(salary) into v_num_sal from employees where department_id=&x;
dbms_output.put_line('sum salary'||v_num_sal);

if v_num_sal is not null then
dbms_output.put_line('everything is okay');
else 
raise v_er;
end if;

exception when v_er then

dbms_output.put_line('sum value is 0 and its not good way to specify it here');


end;



---


declare
v_sal number(6);
v_er exception;



begin
    begin
        select sum(salary) into v_sal from employees where department_id=&id;
        dbms_output.put_line('sum _salary is: '||v_sal);
        dbms_output.put_line(sql%rowcount);
        if v_sal is not null then
        dbms_output.put_line('everything is on way');
        else raise v_er;
        end if;
        
        exception when v_er then
        dbms_output.put_line('no data found');
    
    

    end;
    exception when others then
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);

end;


select department_id from employees;




