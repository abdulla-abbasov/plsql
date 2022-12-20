-- simple if statements with else
declare
v_no number:=&v;


begin
IF  v_no<10  THEN
DBMS_OUTPUT.PUT_LINE('10DAN KICIKDIR');
ELSE
DBMS_OUTPUT.PUT_LINE('10DAN BOYUKDUR');
END IF;

end;


--if elsif statements
declare
v_grade number:=&v;


begin
IF v_grade between 90 and 100 then
dbms_output.put_line('A aldin');
elsif v_grade between 80 and 90 then
dbms_output.put_line('B aldin');
elsif v_grade between 70 and 80 then
dbms_output.put_line('C aldin');
else
dbms_output.put_line('sinifde qaldin aldin');

end if;
end;





--if elsif statements
declare
v_grade number:=&v;


begin
IF v_grade between 0 and 100 then
    IF v_grade between 90 and 100 then
    dbms_output.put_line('A aldin');
    elsif v_grade between 80 and 90 then
    dbms_output.put_line('B aldin');
    elsif v_grade between 70 and 80 then
    dbms_output.put_line('C aldin');
    else
    dbms_output.put_line('sinifde qaldin aldin');
    
    end if;
ELSE
    dbms_output.put_line('grade should be in 0 and 100');
end if;    
end;


--
declare

v_sal employees.salary%type;

begin
select salary into v_sal from employees where employee_id=&emp_id;

if v_sal >15000 then
dbms_output.put_line('1500den yuxari maas alir');

elsif v_sal<15000 then
dbms_output.put_line('1500den yuxari maas alir');



end if;


end;


--null values

declare

x number:=6;
y number;


begin
if x<>y then
dbms_output.put_line('x ya beraber deyil');
else 
dbms_output.put_line('null value');


end if;


end;


declare
x number:=7;
y number;


begin

if nvl(x,0) <> nvl(y,0) then
dbms_output.put_line('beabre deyiller');
else dbms_output.put_line('null value');
end if;
end;



--case expression

declare
v_sal number;
v_val varchar2(100);



begin
select salary into v_sal from employees where employee_id=&emp_id;
v_val:=case
when v_sal is null then 'no salary'
when v_sal between 1000 and 5000 then 'medium salary'
when v_sal between 5000 and 7000 then 'greater than mdeium salary'
when v_sal>10000 then 'higher salary'
end;
dbms_output.put_line(v_val);


end;

-- loop-->basic loop

declare
v_counter number:=0;


begin

LOOP
v_counter:=v_counter+1;
dbms_output.put_line('salam dostum');
exit when v_counter=3;



END LOOP;

end;


--exit with if
declare
v_counter number:=0;


begin

LOOP
v_counter:=v_counter+1;
dbms_output.put_line('salam dostum');
if v_counter=3 then exit;
end if;



END LOOP;

end;


--print employee name with id 100 101 102 

declare
v_id number:=100;
v_name varchar2(100);


begin

loop
exit when v_id>102;
select first_name into v_name from employees where employee_id=v_id;
dbms_output.put_line('employee name '||v_name);
v_id:=v_id+1;
end loop;


end;


--while loop

declare
v_id number:=100;
v_name varchar2(100);


begin
while v_id<=103
loop
select first_name into v_name from employees where employee_id=v_id;
dbms_output.put_line('name'||v_name);
v_id:=v_id+1;



end loop;


end;




-- for loop examples and statements explanantion

begin
for i in 1..3
loop
dbms_output.put_line('hello'||i);


end loop;

end;


--one time execute
begin
for i in 1..1
loop
dbms_output.put_line('hello'||i);

end loop;

end;



-- reverse for loop
begin 
for i in reverse 1..3
loop
dbms_output.put_line('salam aleykum'||i);

end loop;

end;



declare

v_name varchar2(100);

begin

for i in 100..102
loop
select first_name into v_name from employees where employee_id=i;
dbms_output.put_line('employee name is  '||v_name);

end loop;





end;

/* try to do this
*
**
***
****

*/
declare

v_name varchar2(100):='';

begin
for i in 1..4
loop
v_name:=v_name||'*';
dbms_output.put_line(v_name);
end loop;

end;





declare

v_sym varchar2(100);

begin
for i in 1..10

loop
    if i between 1 and 5 then
    v_sym:=i||chr(10)||':)';
    else 
    v_sym:=i;
    end if;
    
    dbms_output.put_line(v_sym);



end loop;
end;


declare
v_char  varchar2(100);


begin
for i in 1..9
loop
  dbms_output.put_line(i);
  continue when i>5;
  dbms_output.put_line(':)');

end loop;


end;


