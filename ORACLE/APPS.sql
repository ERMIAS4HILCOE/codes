--                   OBJECT METHODS
            /*----------------------------------------------------------------------------
            Object methods, also known as subprograms, 
                are functions or procedures that you can declare in an object type
            definition to implement behavior that you want objects of that type to perform
              complex objects
              Member PROCEDURES and FUNCTIONS , CONSTRCTOR AND STATIC METHODS
              Member methods provide an application with access to the data of an object instance.
            --------------------------------------------------------------------------------*/


         /*Because the value of the IN OUT actual parameter is copied into the 
         corresponding formal parameter, the copying slows down 
         execution when the parameters hold large data structures such as instances of large object types. 
         */
         
         
CREATE OR REPLACE TYPE employee_typ AS OBJECT
(
     id NUMBER,
     name VARCHAR2(20),
     date_of_birth DATE,
     salary NUMBER,
     MEMBER PROCEDURE insert_emp(empObj IN OUT NOCOPY employee_typ),
    CONSTRUCTOR FUNCTION employee_typ RETURN SELF AS RESULT
 );
 /
     --create object table
     
 CREATE TABLE emp_tab OF employee_typ;
  / 
        
    --declaring body specification 
    
 CREATE OR REPLACE TYPE BODY employee_typ AS
     MEMBER PROCEDURE insert_emp(empObj IN OUT NOCOPY employee_typ) IS
     BEGIN 
      INSERT INTO EMP_TAB VALUES(empObj);
     END insert_emp;
     CONSTRUCTOR FUNCTION employee_typ RETURN SELF AS RESULT IS
     BEGIN
     RETURN;
     END employee_typ;
 END;
 /
 
 DECLARE 
 empAlmaz employee_typ:=employee_typ(1,'Almaz','05-MAR-2018',4566);
 empMohammed employee_typ:=employee_typ(2,'Mohammed','05-MAR-2000',566);
 regEmployee employee_typ:=employee_typ();
 BEGIN
 --empObj.insert_emp(empObj.id,empObj.name,empObj.date_of_birth,empObj.salary);
  regEmployee.insert_emp(empAlmaz);
  regEmployee.insert_emp(empMohammed);
 END;
 /
 SELECT e.name,e.date_of_birth from emp_tab e;
 
 DROP TYPE BODY employee_typ;
 /* 
 ALTER TYPE employee_typ ADD  MMEMBER FUNCTION get_age RETURN NUMBER  CASCADE;
 */
 ALTER TYPE employee_typ ADD MEMBER FUNCTION get_age RETURN NUMBER CASCADE; 
 DESC EMPLOYEE_TYP;
 
 CONN test/test@ORCL;
 
  
 CREATE TYPE BODY employee_typ AS
 MEMBER PROCEDURE insert_emp(empObj IN OUT NOCOPY employee_typ) IS
 BEGIN 
  INSERT INTO EMP_TAB VALUES(empObj);
 END insert_emp;
 CONSTRUCTOR FUNCTION employee_typ RETURN SELF AS RESULT IS
 BEGIN
 RETURN;
 END employee_typ;
 MEMBER FUNCTION get_age RETURN NUMBER IS
 BEGIN
  RETURN TRUNC(Months_Between(Sysdate, date_of_birth)/12);
 END get_age;
 End;
 /
 
  
 SELECT e.name,e.get_age() Age from emp_tab e;
 
 