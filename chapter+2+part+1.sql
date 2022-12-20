begin
dbms_output.put_line('my first anonyms block');
end;

--we will do same Exercise using sql*plus
--------------------------------------------

begin
dbms_output.put_line('this the first line');
dbms_output.put_line('this is the second line');
end;
---------------------------------------------

declare
begin
dbms_output.put_line('hello world');
end;
----------------------------------------------

declare
v number;
begin
v:=5;
dbms_output.put_line('hello world');
dbms_output.put_line(v);
end;
----------------------------------------------


