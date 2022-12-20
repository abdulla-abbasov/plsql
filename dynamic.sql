--
create or replace function get_emp(p_id employees.employee_id%type) 
return employees%rowtype
is
p_res employees%rowtype;
begin
select * into p_res from employees where employee_id=p_id;
return p_res;


end;


declare

p_res_1 employees%rowtype;


begin

p_res_1:=get_emp(100);
dbms_output.put_line(p_res_1.employee_id||'adi: '||p_res_1.first_name);

end;



--
create or replace function get_emp_2(p_id employees.employee_id%type)
return employees%rowtype
is
v_emp employees%rowtype;
n_var varchar2(1000);

begin
n_var:='select * from employees where employe_id=:1';
execute immediate n_var into v_emp using p_id;
return v_emp;
end;

--
declare
v_emp employees%rowtype;

begin
v_emp:=get_emp_2(105);
dbms_output.put_line(v_emp.salary||' '||v_emp.first_name);

end;






