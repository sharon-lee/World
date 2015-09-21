
select count(*) from city;
select * from city;
select * from country;
select * from city where CountryCode;
select * from countrylanguage;

-- select code,name from country;

-- select country.Name, country.IndepYear, country.HeadOfState, city.Name, city.Population from city inner join country where country.Code="KOR"&&city.CountryCode="KOR"; 
--char type
-- char(10) 자리수제한 255max
-- varchar(10) 255max
-- longvarchar(1000) - oracle ==> long, mySQL ==> text, mediumtext
-- clob -대량의 데이타 oracle ==> clob, mysql ==> longtext

-- numeric (10, 2) 정수, 실수 표현
-- decimal (10, 2) 저장방식의 차이 

-- Timestamp (날짜, 시간) - Oracle ==> date, mysql ==> datetime 
-- Date (날짜) - 
-- Time (시간) - 

-- Blob - 대량의 Binary Data 저장 - oracle ==> blob, mysql ==> blob, mediumblob, longblob

--CONSTRAINT PK_DEPT  PRIMARY KEY,
-- CTRL+SHIFT+Y : 소문자
-- CTRL+SHIFT+X : 대문자
-- 
-- dept
-- 
drop table dept;
create table dept (
	deptno numeric(2) not null,
	dname varchar(14) ,
	loc varchar(13),
	constraint pk_dept primary key (deptno)
)engine=innodb default charset=utf8;

-- 
-- emp 표준방식을 쓰도록
-- 
drop table emp;
create table emp (
	empno numeric(4) not null,
	ename varchar(10),
	job varchar(9),
	mgr numeric(4),
	hiredate datetime,
	sal numeric(7,2),
	comm numeric(7,2),
	deptno numeric(2) ,
	constraint pk_emp primary key (empno),
	constraint fk_deptno foreign key (deptno) references dept(deptno)
)engine=innodb default charset=utf8;
-- hiredate timestamp - insert시의 시간이 들어감

-- 
-- bonus 표준방식을 쓰도록
-- 
drop table bonus;
create table bonus(
	ename varchar(10)	,
	job varchar(9)  ,
	sal numeric,
	comm numeric
) engine=innodb default charset=utf8;

-- 
-- salgrade 표준방식을 쓰도록
-- 
drop table salgrade;
create table salgrade ( 
	grade numeric,
	losal numeric,
	hisal numeric 
)engine=innodb default charset=utf8;

select * from dept;

select * from emp;

insert into EMP
(
 	empno,
 	ename,
 	job
)
values
(
	1001,
	'HONG',
	'dev''test'''
);

-- totalItem
select count(*) from city; 		

-- Pagination에 이용 : limit start, count ==> start는 index처럼 0부터 시작

-- ? start ==> firstItem - 1
-- > count ==> lastItem - firstItem + 1

-- 1 page :  1 - 10 ==> limit 0 - 9
select *
  from city
 limit 0, 10;

-- 2 page : 11 - 20 ==> limit 10 - 19
select *
  from city
 limit 10, 10;
 
/*
 * Blob type: DB에 file을 upload할 때 blob 처리
 */
create table filelist (
	fname 			varchar(50) primary key,
	flength 		numeric(10),
	flast_modified 	datetime,
	image 			longblob

);


select count(*) from filelist;
select * from filelist;

/*
 * Member Table 생성, Table상에서 제약상황을 걸어야 코드상에서 처리 불필요
 * id는 사용자입력 없이 자동으로 발번/생성 (책원Table). error가 나도 증가
 * numeric(5)는 auto_increment를 하면 error, int로 해줘야
 * unique는 table안에서 indexing개념(조회가 빨라짐)
 */   

   
/*
 * Member Table 생성 - email, password 로직처리 필요
 * email 	xxx@xxx.com형식이어야 (regex-정규표현식)
 * password 영문 and 숫자 and 6자리 이상 and not 3자리이상 반복 
 * 			암호화(encryption) ==> MD5, SHA-256 (Secure Hash Algorithm) 단방향 암호화(역방향 불가능)
 * Java Model Class - Value Object - Java Mapping 관계 필요
 */
drop table member;

create table member (
	id			int not null auto_increment,
	email 		varchar(64) not null,
	password	varchar(64) not null,
	name		varchar(12) not null,
	regdate		timestamp not null,
	constraint member_pk primary key (id, email),
	constraint member_id_uq unique (id),
	constraint member_email_uq unique (email)
);

alter table member auto_increment=1000;

select * from member;


drop table member2;

create table member2 (
	id			int not null,
	email 		varchar(64) not null,
	password	varchar(64) not null,
	name		varchar(12) not null,
	regdate		timestamp not null,
	constraint member2_pk primary key (id, email),
	constraint member2_id_uq unique (id),
	constraint member2_email_uq unique (email)
);

select * from member2;

alter table member auto_increment=1000;


/*
 * id는 insert와 동시에 자동 채번
 * id, email 모두 중복되어서는 안됨. email도 unique하게 만들어야. DB차원에서 integrity check해야
 * date을 String형태로 주면 DB가 알아서 처리
 * Placehold Preparestatement가 알아서 처리
 * email validation check @xxx.com
 * 중복 check는 DB에서 처리, ' 처리, password(영문/숫자/특수문자) 암호화 처리 - 로직 처리
 */
insert into member 
(email, password, name, regdate)
values
('xxx123', 'yyy', 'zzz', '2015/08/12');
 
select last_insert_id();

/*  채번 테이블
 * id generator - 채번 table 역할
 * * 채번 id *
 * * next된 값 * : 다른 session이 update하지 못하도록 lock을 걸어야 
 * sql은 대소문자를 가리지 않음
 */ 
select * from id_generator;

drop table id_generator;

create table id_generator (
	name  		varchar(20) not null primary key, 
	nextval		numeric(10) not null, 
	incval	 	numeric(5) not null

);  
 
insert into  id_generator 
(name, nextval, incval)
values
('memberId', 10000, 100);


/*
 * Pagination
 * limit start index(from index 0), length(갯수)
 */
select	*
  from	city
 where	countrycode = 'KOR' 
 order	by name
 limit 	10, 10;
 
/*
 * District 분석
 */ 
select *
  from city
 where countrycode = "KOR";
 
select distinct district
  from city
 where countrycode = "KOR";
 
select code, name 
  from country 
 
insert into  city 
(name, countryCode, district, population)
values
('홍길동', 'KOR', 'xxxxx', 100); 
 
 
 
 
 
 
 
 
 
 
 
 







 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

