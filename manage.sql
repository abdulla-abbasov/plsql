--
select text from all_source where lower(name)='dbms_db_version' order by line;


begin
dbms_output.put_line(dbms_db_version.version);

end;

create or replace function get_sal(p_id number) return number $if dbms_db_version.version>11 $then result_cache $end
is
v_sal number;

begin
select salary into v_sal from employees where employee_id=p_id;

end;

----
begin
dbms_output.put_line($$plsql_code_type);
dbms_output.put_line($$plsql_optimize_level);
dbms_output.put_line($$plsql_warnings);
end;
