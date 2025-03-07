----Question 1.
DECLARE
 v_pi CONSTANT NUMBER(9,2) :=22.3;
 v_radius NUMBER(9,2) := &cylinder_radius;
 v_height NUMBER(9,2) := &cylinder_height;
 v_vol NUMBER(9,2);
 v_area NUMBER(9,2);
BEGIN
  v_vol := v_pi * (v_radius * v_radius) * v_height;
  v_area := 2 * v_pi *(v_radius * v_radius) + 2 * v_pi * (v_radius * v_radius);
  
  dbms_output.put_line('The volume of the cylinder is '||v_vol);
  dbms_output.put_line('The area of the cylinder is '||v_area);
END;
/
----Question 2
DECLARE 
 v_auth varchar2(4):=UPPER('&auther_id');
 v_lname varchar2(10);
 v_fname varchar2(10);
 v_title varchar2(10);
BEGIN
 select a.fname, a.lname, COUNT(b.title)
 into v_fname, v_lname, v_title
 from bk_author a, bk_books b
 where a.authorid = b.authorid
 and v_auth = a.authorid
 GROUP BY a.authorid,a.fname,a.lname;
 
 dbms_output.put_line(UPPER(v_lname)||', '||UPPER(v_fname)||' has written '||v_title||' book(s)');
 
 ---Question 3
DECLARE
  v_isbn bk_books.isbn%TYPE := '&isbn';
  v_title bk_books.title%TYPE;
  v_category bk_books.category%TYPE;
  v_pubdate bk_books.pubdate%TYPE;
  v_pubname bk_publisher.name%TYPE;
  v_cost bk_costs.cost%TYPE;
  v_retail bk_costs.retail%TYPE;
  v_profit bk_costs.retail%TYPE;
BEGIN
 select b.title,b.category,b.pubdate, p.name,c.cost,c.retail
 into v_title, v_category, v_pubdate, v_pubname, v_cost,v_retail
 from bk_publisher p,bk_books b, bk_costs c
 where b.pubid = p.pubid
 and b.isbn = c.isbn
 and v_isbn = b.isbn;
 
 v_profit := v_retail - v_cost;
 
 dbms_output.put_line('Books Details');
 dbms_output.put_line('===================');
 dbms_output.put_line('Title: '||v_title);
 dbms_output.put_line('Category: '|| v_category);
 dbms_output.put_line('Published by: '||v_pubname||'('||TO_CHAR(v_pubdate,'YYYY')||')');
 dbms_output.put_line('Cost Price: '||TO_CHAR(v_cost, 'L99,999.00'));
 dbms_output.put_line('Retail Price: '||TO_CHAR(v_retail. 'L99,999.00'));
 dbms_output.put_line('Profit/Gains: '||TO_CHAR(v_profit, 'L99,999.00'));
 dbms_output.put_line('END');
END;
/
 