---Question 1.
SET SERVEROUTPUT ON;

DECLARE
 v_isbn bk_books.isbn%TYPE := UPPER('&book_isbn');
 v_title bk_books.title%TYPE;
 v_fname bk_author.fname%TYPE;
 v_lname bk_author.lname%TYPE;
 v_publisher bk_publisher.name%TYPE;
 v_pubdate bk_books.pubdate%TYPE;
 v_cost bk_costs.cost%TYPE;
 v_vat CONSTANT NUMBER(9,2) := 0.14;
 v_sellingPrice NUMBER(9,2);
BEGIN
 SELECT UPPER(b.title),UPPER(a.fname),UPPER(a.lname),UPPER(p.name),b.pubdate,c.cost
 INTO v_title,v_fname,v_lname,v_publisher,v_pubdate,v_cost
 FROM bk_books b, bk_publisher p, bk_author a,bk_costs c
 WHERE b.authorid = a.authorid
 AND b.pubid = p.pubid
 AND b.isbn = c.isbn
 AND b.isbn = v_isbn;
 v_sellingPrice := v_cost * (1 + v_vat);
 
 dbms_output.put_line(v_title);
 dbms_output.put_line('By :'||SUBSTR(v_fname,1,1)||'.'||v_lname||'('||v_fname||')');
 dbms_output.put_line('Published by: '||v_publisher);
 dbms_output.put_line('Edition: '||TO_CHAR(v_pubdate,'YYYY'));
 dbms_output.put_line('Price: '||TO_CHAR(v_sellingPrice,'fmL99,999.00')||'(VAT INCLUDED)');
END;
/
---Question 2
DECLARE
 v_radius NUMBER(9,2) := &circle_radi;
 v_diameter NUMBER(9,2);
 v_circumference NUMBER(9,2);
 v_area NUMBER(9,2);
 v_pi CONSTANT NUMBER(9,2) := 22.3;
 v_choice INT;
BEGIN
 v_diameter := 2 * v_radius;
 v_circumference := 2 * (v_pi * v_radius);
 v_area := v_pi *(v_radius * v_radius);
 dbms_output.put_line('Enter 1 for diameter| 2 for circumference| 3 for area');
 v_choice := &choice;
 IF v_choice = 1 THEN dbms_output.put_line('the diameter of the circle is: '|| v_diameter);
 ELSIF v_choice = 2 THEN dbms_output.put_line('The circumference is '|| v_circumference);
 ELSIF v_choice = 3 THEn dbms_output.put_line('The area is: '||v_area);
 ELSE dbms_output.put_line('Enter a valid number');
 END IF;
END;
/
---Q3
DECLARE
 v_radius NUMBER(9,2) := &circle_radi;
 v_diameter NUMBER(9,2);
 v_circumference NUMBER(9,2);
 v_area NUMBER(9,2);
 v_pi CONSTANT NUMBER(9,2) := 22.3;
 v_choice INT;
BEGIN
 v_diameter := 2 * v_radius;
 v_circumference := 2 * (v_pi * v_radius);
 v_area := v_pi *(v_radius * v_radius);
 dbms_output.put_line('Enter 1 for diameter| 2 for circumference| 3 for area');
 v_choice := &choice;
 
 CASE
  WHEN v_choice = 1 THEN dbms_output.put_line('the diameter of the circle is: '|| v_diameter);
  WHEN v_choice = 2 THEN dbms_output.put_line('The circumference is '|| v_circumference);
  WHEN v_choice = 3 THEn dbms_output.put_line('The area is: '||v_area);
  ELSE dbms_output.put_line('Enter a valid number');
 END CASE;
END;
/

---Q4--RECORDS
DECLARE 
 v_orderNo bk_orderitems.order#%TYPE := &order_num;
 v_costTot bk_costs.cost%TYPE;
 
 TYPE v_cust_order IS RECORD(
  v_fname bk_customers.firstname%TYPE,
  v_lname bk_customers.lastname%TYPE,
  v_item bk_orderitems.item#%TYPE,
  v_qty bk_orderitems.quantity%TYPE,
  v_cost bk_costs.cost%TYPE);
 
  v_order v_cust_order;
BEGIN
 SELECT UPPER(c.firstname),UPPER(c.lastname),i.item#, i.quantity,d.cost
 INTO v_order
 FROM bk_orderitems i, bk_orders o, bk_customers c, bk_costs d
 WHERE i.order# = o.order#
 AND o.customer# = c.customer#
 AND i.isbn = d.isbn
 AND i.order# = v_orderNo;
 v_costTot := v_order.v_qty * v_order.v_cost;
 dbms_output.put_line('Customer: '||v_order.v_fname||' '||v_order.v_lname);
 dbms_output.put_line('Summary of order');
 dbms_output.put_line('Number of items: '||v_order.v_item);
 dbms_output.put_line('Quantity of items in order: '||v_order.v_qty);
 dbms_output.put_line('Total value: '||TO_CHAR(v_costTot,'fmL99,999.00'));
END;
/