---
drop table hr_table;
create table hr_table(p_id number,p_name varchar2(100));

create or replace procedure add_hr(p_id number,p_name varchar2)
is
begin
insert into hr_table values(p_id,p_name);
end;

grant execute on add_hr to bmw;

drop table t;

------ DEFINER AND INVOKERS RIGHT;
create table t (test_value varchar2(100));

create or replace procedure child_block is
begin
insert into t values('child block');
COMMIT;
end child_block;


create or replace procedure parent_block is
begin
insert into t values('parent block');
child_block;
ROLLBACK;
end parent_block;

EXECUTE PARENT_BLOCK;

select * from t;

create or replace procedure child_block is
pragma autonomous_transaction;
begin
insert into t values('child block inserted');
commit;

end child_block;

create or replace procedure parent_block is
begin
insert into t values('parent block intserted');
child_block;
rollback;
end parent_block;

execute parent_block;

truncate table t;

select * from t;