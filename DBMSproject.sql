connect system
shorifulsoumic

----------------------------------------------------------lab 01----------------------------------------------------------
													--table creation--

drop table managements;
drop table funds;
drop table alumni;
drop table students;


create table students(
	s_id integer primary key, 
	s_name varchar(20), 
	s_dept varchar(20), 
	s_batch varchar(4)
);
	
create table alumni(
	a_id integer primary key, 
	a_name varchar(20), 
	a_dept varchar(20), 
	a_batch varchar(4),
	a_phoneNumber varchar(14),
	a_address varchar(30)
);
	
create table funds(
	f_id integer primary key, 
	f_amount integer,
	a_id integer,
	foreign key(a_id) references alumni on delete cascade
);

create table managements(
	s_id integer, 
	f_id integer,
	spending varchar(20),
	foreign key(s_id) references students on delete cascade,
	foreign key(f_id) references funds on delete cascade
);

-----------------------------------------------------------lab 09-----------------------------------------------------------
													    ---trigger---

--if contribution of the alumni to be distributed is less than 1000 then it will be used as donation
																	--else it will be used in events. 
create trigger tr_spending
before update or insert on managements
for each row
declare 
	checkAmount funds.f_amount%type;
begin
	select f_amount into checkAmount from funds where f_id=:new.f_id;
	--coollect information about the amount from funds table
	if checkAmount<1000 then :new.spending:='donation';
	else :new.spending:='event';
	end if;
end tr_spending;
/
show errors;

--if a student graduates his/her information will be added in the alumni table
--thus his/her information from the students table will be removed
create trigger tr_alumni
before update or insert on alumni
for each row
begin
	delete from students where students.s_id=:new.a_id;
end tr_alumni;
/
show errors;

-----------------------------------------------------------lab 01-----------------------------------------------------------
insert into students(s_id, s_name, s_dept, s_batch) values(1807001, 'mahin', 'cse', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807002, 'iftee', 'cse', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807003, 'rupok', 'eee', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807004, 'ratul', 'cse', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807005, 'nafiul', 'cse', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807006, 'subah', 'eee', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807007, 'oishi', 'cse', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807008, 'taqiul', 'cse', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807009, 'tanvir', 'me', '2k18');
insert into students(s_id, s_name, s_dept, s_batch) values(1807010, 'prothoma', 'cse', '2k18');

insert into alumni(a_id, a_name, a_dept, a_batch, a_phonenumber, a_address) values(1607001, 'nuhash', 'cse', '2k16', '+8801875782911', 'joypurhat');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607002, 'noman', 'me', '2k16', '+8801875782911', 'bogura');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607003, 'sourov', 'ce', '2k16', '+8801875782911', 'bogura');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607004, 'saikan', 'cse', '2k16', '+8801875782911', 'joypurhat');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607005, 'dipto', 'eee', '2k16', '+8801875782911', 'joypurhat');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607006, 'asiq', 'me', '2k16', '+8801875782911', 'bogura');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607007, 'tushar', 'cse', '2k16', '+8801875782911', 'joypurhat');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607008, 'limon', 'eee', '2k16', '+8801875782911', 'bogura');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607009, 'awal', 'cse', '2k16', '+8801875782911', 'joypurhat');
insert into alumni(a_id, a_name, a_dept, a_batch, a_phoneNumber, a_address) values(1607010, 'niom', 'eee', '2k16', '+8801875782911', 'joypurhat');

insert into funds(f_id, f_amount, a_id) values(0001, 1000, 1607001);
insert into funds(f_id, f_amount, a_id) values(0002, 500, 1607002);
insert into funds(f_id, f_amount, a_id) values(0003, 1000, 1607003);
insert into funds(f_id, f_amount, a_id) values(0004, 200, 1607001);
insert into funds(f_id, f_amount, a_id) values(0005, 100, 1607002);
insert into funds(f_id, f_amount, a_id) values(0006, 10000, 1607003);
insert into funds(f_id, f_amount, a_id) values(0007, 1000, 1607001);
insert into funds(f_id, f_amount, a_id) values(0008, 100, 1607002);
insert into funds(f_id, f_amount, a_id) values(0009, 100, 1607003);
insert into funds(f_id, f_amount, a_id) values(0010, 500, 1607004);

insert into managements(s_id, f_id) values(1807001, 0001);
insert into managements(s_id, f_id) values(1807001, 0002);
insert into managements(s_id, f_id) values(1807003, 0003);
insert into managements(s_id, f_id) values(1807001, 0004);
insert into managements(s_id, f_id) values(1807002, 0005);
insert into managements(s_id, f_id) values(1807003, 0006);
insert into managements(s_id, f_id) values(1807004, 0007);
insert into managements(s_id, f_id) values(1807005, 0008);
insert into managements(s_id, f_id) values(1807006, 0008);
insert into managements(s_id, f_id) values(1807007, 0008);

select * from students;
select * from alumni;
select * from funds;
select * from managements;


----------------------------------------------------------lab 02, 03----------------------------------------------------------
													--table alteration--

--add (add column)
alter table students add temp_column VARCHAR2(50);
desc students;
select * from students;

--modify (modify column data type)
alter table students modify temp_column VARCHAR2(60);
desc students;
select * from students;

--rename (rename column)
alter table students rename column temp_column to tmp_column;
desc students;
select * from students;

--drop (drop column)
alter table students drop column tmp_column;
desc students;
select * from students;


--update (update a value)
update students set s_name = 'pokpok' where s_id=1807003;
desc students;
select * from students;


--delete (delete a value)
delete from students where s_id=1807008;
desc students;
select * from students;

insert into students(s_id, s_name, s_dept, s_batch) values(1807008, 'taqiul', 'cse', '2k18');
select * from students;


													--select operations--
--select a specific students
select s_name from students where s_id='1807001';

--select a range of students
select s_name from students where s_id between 1807001 and 1807005;

--Set membership using IN/NOT IN
select s_name from students where s_id in (1807001,1807005, 1807008);
select s_name from students where s_id not in (1807001,1807005, 1807008);


-----------------------------------------------------------lab 04-----------------------------------------------------------
													--select operations--

--Order by values(order student's according to their roll)
select s_name, s_id from students order by s_id;
select s_name, s_id from students order by s_id desc;


--Order by values using multiple columns
--(select alumni from alumni table ordering by their amount of contribution)
select a_id, f_amount from funds order by f_amount;
select a_id, f_amount from funds order by f_amount, a_id;


--select unique elements
--(see disticnt amounts in fund table)
select distinct (f_amount) from funds;


													--aggregate function--

--maximum amount in funds table
select  max(f_amount) from funds;

--minimum amount in funds table
select  min(f_amount) from funds;

--total amount in funds table
select  sum(f_amount) from funds;

--total count of entries in funds table
select  count(f_amount) from funds;

--total count of disticnt entries in funds table
select count(distinct (f_amount)) from funds;

--average amount in funds table
select  avg(f_amount) from funds;


--group by clause
--total contribution of each alumni--
select a_id, sum(f_amount) from funds group by a_id; 

--having clause
--total contribution of each alumni whose id is greater than 1607002--
select a_id, sum(f_amount) from funds group by a_id having a_id>1607002; 


-----------------------------------------------------------lab 05-----------------------------------------------------------

--nested query
--find contribution of alumni with a specific id for a range of amount 
select a_id, f_amount from funds where f_amount<1000;
select f_amount, a_id from (select a_id, f_amount from funds where f_amount<1000) where a_id=1607002;



--union all  and union operation

--all alumni whose address is joypurhat
select a_id from alumni where a_address='joypurhat';
--all alumni whose contribution is greater than 100
select a_id from funds where f_amount>100;

--if union all is applied all rows are seleceted from both the table
select a_id from alumni where a_address='joypurhat'
union all 
select a_id from funds where f_amount>100;

-- if union is applied only distinct rows are selected form both the table
select a_id from alumni where a_address='joypurhat'
union
select a_id from funds where f_amount>100;

-- select names and adresses of alumni after union operation
select a_id, a_name, a_address from alumni where a_id in (select a_id from alumni where a_address='joypurhat'
															union
														select a_id from funds where f_amount>100);


--interect operation 
--all alumni who have contribution greater than	100 and address is joypurhat
select a_id, a_name, a_address from alumni where a_id in (select a_id from alumni where a_address='joypurhat'
															intersect
														select a_id from funds where f_amount>100);

--minus operation
--all alumni who have contribution is less than or equal 100 and address is joypurhat
select a_id, a_name, a_address from alumni where a_id in (select a_id from alumni where a_address='joypurhat'
															minus
														select a_id from funds where f_amount>100);




-----------------------------------------------------------lab 06-----------------------------------------------------------
													--------Join--------
--students who are managing funds
select distinct students.s_name, managements.spending 
	from students join managements 
		on students.s_id=managements.s_id;

--students who are managing event type funds
select distinct s_name from 
	(select students.s_name, managements.spending from 
		students  join  managements 
			on students.s_id=managements.s_id)
 where spending='event';

--total amount of funds allocated for donation
select sum(f_amount) from 
	(select funds.f_amount, managements.spending 
		from funds join managements 
			on funds.f_id=managements.f_id)
where spending='donation';

-----------------------------------------------------------lab 07-----------------------------------------------------------
													--------PL/SQL--------

--Type of spending by the studets for the maximum contribution by alumni
set SERVEROUTPUT on 
declare 
	max_amount funds.f_amount%type;
	max_amount_id funds.f_id%type;
	spending_type managements.spending%type;
begin
	select max(f_amount) into max_amount from funds;
	select f_id into max_amount_id from funds where max_amount=f_amount;
	select spending into spending_type from managements where f_id=max_amount_id;
	dbms_output.put_line('Type of spending by the studets for the maximum contribution by alumni: ' || spending_type);	
end;
/

-----------------------------------------------------------lab 08-----------------------------------------------------------
														---cursor---
--get specified info upto a certail amount in students table
set SERVEROUTPUT on
declare 
	cursor stud is select s_id, s_name, s_dept from students;
	student stud%rowtype;

begin
open stud;
	loop 
		fetch stud into student;
		exit when stud%rowcount >5;
		dbms_output.put_line('Student with id: '|| student.s_id || ' whose name is: '|| student.s_name || ' is from department: '|| student.s_dept);
	end loop;
close stud;		
end;
/

													   ---procedure---
--list of all students with details using procedure-- 
set SERVEROUTPUT on
create or replace procedure showStudentDetails is
	cursor stud is select s_id, s_name, s_dept from students;
	student stud%rowtype;
	totrow integer;

begin
select count(*) into totrow from students;
open stud;
	loop 
		fetch stud into student;
		dbms_output.put_line('Student with id: "'|| student.s_id || '" whose name is: "'|| student.s_name || '" is from department: "'|| student.s_dept||'"');
		exit when stud%rowcount>=totrow;
	end loop;
close stud;		
end;
/
show errors;

begin
	showStudentDetails;
end;
/

													   ---function---
--get total sum of fund using funciton
set SERVEROUTPUT on
create or replace function totalFund return number is 
	total funds.f_amount%type;

begin
	select sum(f_amount) into total from funds;
	return total;
end;
/
show errors;

begin
	dbms_output.put_line('Total funds from the alumni is: ' || totalFund);
end;
/


