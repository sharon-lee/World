
-- 등록을 위한 명령어
mvn install:install-file -Dfile=ojdbc6.jar -DartifactId=ojdbc6 -DgroupId=com.oracle -Dversion=11.2.0 -Dpackaging=jar

--    mvn install:install-file -Dfile=<path-to-file> -DgroupId=<group-id> \
--       -DartifactId=<artifact-id> -Dversion=<version> -Dpackaging=<packaging>
        
        
select * from DEPT;
select * from EMP;
select * from BONUS;
select * from SALGRADE;

--
-- Inner Join 1
--
select * 
  from dept inner join emp 
    on dept.deptno = emp.deptno;

--
-- Inner Join 2
--
select * 
  from dept, emp 
 where dept.deptno = emp.deptno;
 
--
-- Inner Join 1 (Query)
--
select dept.deptno, dept.dname, emp.ename, emp.hiredate
  from dept inner join emp 
    on dept.deptno = emp.deptno
 order by dept.deptno asc;
 
select dept.deptno, dept.dname, emp.ename, emp.hiredate
 from dept inner join emp 
   on dept.deptno = emp.deptno
order by dept.deptno desc;

--
-- Inner Join 2 Alias 별칭
--
select d.deptno, d.dname, e.ename, e.hiredate 
 from dept d, emp e 
where d.deptno = e.deptno
order by d.deptno desc;

--
-- Left Outer Join 1 부서별 직원 리스트
--
select d.deptno, d.dname, e.ename, e.hiredate
  from dept d left outer join emp e
    on d.deptno = e.deptno 
 order by d.deptno asc;

-- 1. emp table에 직원을 추가하라
-- empno = 8000
-- ename = 홍길동
-- job = developer
-- ...
-- deptno = 80
-- dname = 총무부
-- dloc = 서울

insert into dept(deptno, dname, loc)  values (80, '총무부', '서울');
insert into emp (empno, ename, job, deptno) values (8000, '홍길동', 'developer', 80);
select * from DEPT;
select * from EMP;

-- 2. dept 정보를 수정하라
-- deptno = 20
-- dname = 개발부
-- loc = 부산

alter table emp drop CONSTRAINT FK_DEPTNO;
alter table dept drop PRIMARY KEY;
update dept set deptno=20, dname='개발부',loc='부산' where deptno=20;
ALTER TABLE dept ADD CONSTRAINT PK_DEPT PRIMARY KEY(deptno);
ALTER TABLE emp ADD CONSTRAINT FK_DEPTNO foreign key(deptno) REFERENCES dept(deptno);
select * from DEPT;
select * from EMP;

-- 3. 직원 정보를 삭제하라
-- empno > 7300 and empno <= 7600
delete from emp where empno > 7300 and empno <=7600;
select * from EMP;

-- 4. 부서별 직원정보를 출력하라 (단 모든 부서를 출력하라)
select * from dept order by deptno asc ;
select *
  from dept d left outer join emp e
    on d.deptno = e.deptno 
 order by d.deptno asc;
 select d.deptno, d.dname, e.ename, e.hiredate
  from dept d left outer join emp e
    on d.deptno = e.deptno 
 order by d.deptno asc;
 -- group by는 통계 목적
-- select e.deptno from emp e left outer join dept d on d.deptno = e.deptno group by e.deptno;
select * from EMP;

-- 5. 부서별 직원급여평균을 출력하라 group by
SELECT deptno, COUNT(*), ROUND(AVG(sal)) "급여평균", 
       ROUND(SUM(sal)) "급여합계"
  FROM emp
 GROUP BY deptno;
 -- select deptno,avg(sal),max(sal),min(sal) from emp group by deptno having avg(sal)>300; 
 
-- MyBatis, JDBC Programming Format 
select * from emp;
commit
rollback
insert into EMP
(
 	empno,
 	ename,
 	job,
 	mgr,
 	hiredate,
 	sal,
 	deptno
)
values
(
	1000,
	'홍길동2',
	'dev''xxx''',
	7000,
	'2015/09/10',
	300.2,
	10
);
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

select * from emp;
delete from emp where empno=9300;
delete from emp where empno=8000;

/*
 * City
 */
drop table city;

-- default '' NULL stream
create table city (
	  id 			numeric(11) not null,
	  name 			char(35) 	default '',
	  countrycode 	char(3) 	default '',
	  district  	char(20) 	default '',
	  population 	numeric(11) default 0,
	  constraint 	pk_city 	primary key (id),
	  constraint 	fk_country 	foreign key (countrycode) references country(code)
);

/*
 * Country
 */
drop table country;

create table country (
	  code 				char(3) 		default '',
	  name 				char(52) 		default '',
	  continent 		char(20) 		default 'Asia',
	  region 			char(26) 		default '',
	  surfacearea 		numeric(10,2) 	default 0.00,
	  indepyear 		numeric(6) 		default null, 
	  population 		numeric(11) 	default 0,
	  lifeexpectancy 	numeric(3,1) 	default null,
	  gnp 				numeric(10,2) 	default null,
	  gnpold 			numeric(10,2) 	default null,
	  localname 		char(45) 		default '',
	  governmentform 	char(45) 		default '',
	  headofstate 		char(60) 		default null,
	  capital 			numeric(11) 	default null,
	  code2 char(2) 	default '',
	  constraint ck_continent check (continent in ('Asia','Europe','North America','Africa','Oceania','Antarctica','South America')), 
	  constraint pk_country primary key (code)
);
--default null은 의미없음. default로 null이므로
 
/*
 * Country Language
 */
drop table countrylanguage;

create table countrylanguage (
  countrycode 	char(3) 	default '',
  language 		char(30) 	default '',
  isofficial 	char(1) 	default 'f',
  percentage 	numeric(4,1) 	default '0.0',
  constraint ck_isofficial check (isofficial in ('t','f')), 
  constraint pk_countrylanguage primary key (countrycode,language)
  
);

/*
 * Blob type: DB에 file을 upload할 때 blob 처리
 */
create table filelist (
	fname 			varchar(50) primary key,
	flength 		numeric(10),
	flast_modified 	date,
	image 			blob

);

select count(*) from filelist;

delete from dept where deptno = 19;

select * from dept;
  
update dept 
   set dname='xxx',
       loc='yyy' 
   where deptno=70;
  
/*
 * Spring/MyBatis
 */
/*
 * Member Table 생성
 * id는 사용자입력 없이 자동으로 생성 (책원Table). DB마다 발번/채번 방식이 다름. 채번/발번테이블을 만들어 로직에 의해서 관리
 * numeric(5)
 * not null check
 * regdate		timestamp not null default sysdate,
 */   
drop table member;
   
create table member (
	id			int not null,
	email 		varchar(64) not null,
	password	varchar(64) not null,
	name		varchar(12) not null,
	regdate		timestamp not null,
	constraint member_pk primary key (id, email),
	constraint member_id_uq unique (id),
	constraint member_email_uq unique (email)
);

select * from member;

/*
 * member2는 DB에 독립적으로 채번테이블을 사용할 것
 */
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

/*
 * Sequence:채번/발번(번호 벌급)DB dependent(Oracle dependent)
 * Oracle, MySQL insert 로직을 같게 하기 위해서 채번테이블을 별도 생성 관리해야 
 */
drop sequence member_id_seq;

create sequence member_id_seq
start with 1000;  

/*
 * dual:pseudo table id발급용
 */
select member_id_seq.nextval from dual;
select member_id_seq.currval from dual;

select * from member;
select * from member where id=1005;


/*
 * Oracle은 id 발급을 먼저 하고 그 값을 보관, 입력해줘야
 * date을 String형태로 주면 DB가 알아서 처리
 * Placehold Preparestatement가 알아서 처리
 * email validation check @xxx.com
 * 중복 check는 DB에서 처리, ' 처리, password(영문/숫자/특수문자) 암호화 처리 - 로직 처리
 */
insert into member 
(id, email, password, name, regdate)
values
(1004, 'xxx1@xxx.com', 'yyy1', 'zz''z', '2015/08/11');   
   
/* 채번 테이블
 * id generator - 채번 table 역할 - DB에 의존적이지 않음- 개발자가 로직처리해야함 
 * * 채번 id *
 * * next된 값 * : 다른 session이 update하지 못하도록 lock을 걸어야 (select시에 row lock을 검- update시에 lock이 풀리도록)
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
 * update 고려사항
 * set에 조건처리가 들어가야 email, password,name,regdate에 null이 들어오면 set에 기술하지 않도록 조건처리. Error처리
 */
select * from member;

update 	member
   set 	email 	= null,
		password= 'qwer1234',
		name 	= null,
		regdate = null
 where	id 		= 27300;

update 	member
   set 	password= 'qwer1234'
 where	id 		= 27300;

update 	member
   set 	name= '홍순이'
 where	id 		= 123123123;

 //ORA-00971: missing SET keyword (0 rows affected)
 update 	member
 where	id 		= 27300;

/*
 * Pagination
 * subquery
 */
select	rownum, e.*
  from	emp e
 where 	rownum <= 10    
 order	by e.ename;
 
 /* Oracle Pagination Query: subquery
  * temporary inner table(temp table 임시테이블을 만들고 rownum으로 select)을 먼저 build하고 나서 rownum으로 numbering
  * rownum은 가상의 column이므로 연산대상이 아님. 대소비교를 위한 범위지정 불가하므로 
  * subquery써서 inner table을 만들어서 rownum을 table의 column으로 저장하고 나서 범위지정해서 select 가능
  * 일반적으로 rownum은 읽을때 불러올때 부여되고 저장되지 않으므로 Page에 보여주는 Data는 query에 따라 달라질수 있다. 
  */
select outer.*
  from (select  rownum rn, inner.*
  	      from (select	e.*
                  from	emp e
                 order  by e.ename 
	           ) inner 
       ) outer
 where outer.rn >= 1
   and outer.rn <= 10

select outer.*
  from (select  rownum rn, inner.*
  	      from (select	m.*
                  from	member m
                 order  by m.id 
	           ) inner 
       ) outer
 where outer.rn >= 11
   and outer.rn <= 20
   
   select outer.rn,
	   outer.id,
       outer.email,
       outer.password,
       outer.name,
       outer.regdate
  from (select  rownum rn, inner.*
  	      from (select	m.*
                  from	member m
				  order  by m.id 
	           ) inner 
       ) outer
 where outer.rn >= 11
   and outer.rn <= 20
   
select outer.rn,
	   outer.id,
       outer.email,
       outer.password,
       outer.name,
       outer.regdate
  from (select  rownum rn, inner.*
  	      from (select	m.*
                  from	member m
				  order  by m.id asc
	           ) inner 
       ) outer
 where outer.rn >= 11
   and outer.rn <= 20

   
select outer.rn,
	   outer.id,
       outer.email,
       outer.password,
       outer.name,
       outer.regdate
  from (select  rownum rn, inner.*
  	      from (select	m.*
                  from	member m
                 order  by m.id  desc
	           ) inner 
       ) outer
 where outer.rn >= 11
   and outer.rn <= 20

   
 where 	rownum >= 5
   and	rownum <= 10
 
select	rownum, e.*
  from	emp e 
 order	by e.ename; 
 

select *
  from member
  order by id desc;
 

 
 
 
 
 
 
 
 
 







   
   
   
   
   