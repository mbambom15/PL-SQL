DECLARE 
	vstaffnr		s_staff.staffnr%TYPE := &staffno;
	voffice_nr		s_staff.office_nr%TYPE := '&office_no';
	vjob			s_staff.job%type := '&job_desc';
	vsalary         s_staff.salary%TYPE := &salary;
	vbonus			s_staff.bonus%type	:= &bonus;
	
	
BEGIN
	UPDATE s_staff
	SET office_nr = voffice_nr, job = vjob, salary = vsalary, bonus = vbonus
	WHERE staffnr = vstaffnr;
	
	
	dbms_output.put_line(SQL%ROWCOUNT||' Staff member(s) details modded');
END;
/
-------
DEFINE stud_number = 96445566;
DECLARE
	v_studnr	s_student.studnr%TYPE;
	v_initials	s_student.initials%TYPE;
	v_surname	s_student.surname%TYPE;
	
	v_num_subj	NUMBER(2);
	v_total_fee NUMBER(6,2);
	
	v_dip_name	s_diploma.dip_name%TYPE;
	v_fac_name  s_faculty.fac_name%TYPE;
BEGIN
	SELECT s.studnr,s.initials,s.surname,COUNT(su.subj_code), SUM(su.subj_fee), d.dip_name,f.fac_name
	INTO v_studnr ,v_initials, v_surname, v_num_subj, v_total_fee, v_dip_name, v_fac_name
	FROM s_student s, s_registration r, s_subject su, s_diploma d, s_faculty f
	WHERE s.studnr = r.studnr
	AND r.subj_code = su.subj_code
	AND su.dip_code = d.dip_code
	AND d.fac_code = f.fac_code
    AND s.studnr = stud_number;
	GROUP BY s.studnr,s.initials,s.surname,d.dip_name,f.fac_name;

	 DBMS_OUTPUT.PUT_LINE('Student Details');
	 DBMS_OUTPUT.PUT_LINE('=======================');
	 DBMS_OUTPUT.PUT_LINE(v_studnr||' '||v_initials||' '||v_surname); 
	 DBMS_OUTPUT.PUT_LINE('=======================');
	 DBMS_OUTPUT.PUT_LINE('Faculty : '||v_fac_name); 
	 DBMS_OUTPUT.PUT_LINE(' Diploma : '||v_dip_name); 
	 DBMS_OUTPUT.PUT_LINE('Number of subjects : '||v_num_subj); 
	 DBMS_OUTPUT.PUT_LINE('Total Amount due : '||TO_CHAR(v_total_fee,'L09,999.00'));
END;
/
----
set serveroutput on;

DECLARE
	v_job    	o_emp.job%type:=UPPER('&job_desc');
	v_empno  	o_emp.empno%type;
	v_sum_Total	o_emp.sal%type;
BEGIN
	select job, COUNT(empno), SUM(sal)
	into v_job, v_empno, v_sum_Total
	from o_emp
	where job = v_job
	GROUP BY job;
	
	dbms_output.put_line('The job code '||v_job||' has ' ||v_empno||'employees with total salary of'||TO_CHAR(v_sum_Total,'L99,999.00'));
END;
/	

-----
DECLARE
    v_empno        o_emp.empno%type := &emp_no;
    v_ename        o_emp.ename%type;
    v_job          o_emp.job%type;
    v_dname        o_dept.dname%type;
    v_loc          o_dept.loc%type;
    v_sal          o_emp.sal%type;
    v_grade        o_salgrade.grade%type;
    
    v_annualsal    o_emp.sal%type;
    v_salincreased o_emp.sal%type;
BEGIN
    SELECT e.ename, e.job, e.empno, e.sal, d.dname, d.loc, sg.grade
    INTO v_ename, v_job, v_empno, v_sal, v_dname, v_loc, v_grade
    FROM o_emp e
    JOIN o_dept d ON d.deptno = e.deptno
    JOIN o_salgrade sg ON e.sal BETWEEN sg.losal AND sg.hisal
    WHERE e.empno = v_empno;

    v_annualsal := v_sal * 12;
    v_salincreased := v_sal * 1.25;

    dbms_output.put_line('Staff_no: ' || v_empno);
    dbms_output.put_line(v_ename || '(' || v_job || ')' || ' works in ' || v_dname || '/' || v_loc || ' earning ' || TO_CHAR(v_sal, '99,999.00') || ' on grade ' || v_grade);
    dbms_output.put_line('Annual salary is: R' || TO_CHAR(v_annualsal, '99,999.99'));
    dbms_output.put_line('Increase in salary: R' || TO_CHAR(v_salincreased, '99,999.99'));
END;
/
