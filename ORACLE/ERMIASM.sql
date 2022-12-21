--OBJECT METHODS

--obj creation

CREATE OR REPLACE type employee is object
(
    empid number,
    empname varchar2(10),
    job varchar2(10),
    hiredate date,
    sal number,
    MEMBER FUNCTION f_getSal return number,
    member procedure p_changeSal(newsal varchar2)
);
/

-- create body of obj
create or replace type BODY employee as 
 MEMBER FUNCTION f_getSal return number
 is 
 begin
    return sal;
     end f_getSal;
    
     member procedure p_changeSal
     (newsal varchar2)
    is 
    begin sal := newSal;
    end p_changeSal;
    end;
    /

-- obj variable
SET SERVEROUTPUT ON;
declare
    emp1 employee;
    emp2 employee;

begin
--aasign values to obj att using default constructor
    emp1 := employee(1,'ermias','analyst',SYSDATE + 1,3000);
    --or USING NEW WORD
    emp2 := new employee(1,'ermias','analyst',SYSDATE,3000);
     --or VARNAME .ATT NAME
     emp1.sal :=3500;
     
     dbms_output.put_line(emp1.empname||' old salary : '|| emp1.F_getSal());
     emp1.p_changeSal(4000);
    dbms_output.put_line(emp1.empname||' new salary : '|| emp1.F_getSal());
end;
/



        --OBJECT TABLE OR COLUMN
        
     -- pre execution step
     column v_emp format a64;
     column comments format a8;
CREATE TABLE emp1 of employee;
CREATE TABLE emp2 ( emp employee, comments varchar2(50));

--obj table or column
declare 
    v_emp employee;
begin
    v_emp := employee(1,'ermias','analyst',SYSDATE ,3000);
    
insert into emp1 values(v_emp);

insert into emp1 values (employee (2,'mati','manager',sysdate,6000));

insert into emp2 values(v_emp,'good');

INSERT INTO emp2 values (employee(2,'mati','manager',sysdate,6000),'good');
end;
/

--post execution step

 
select * from emp2;