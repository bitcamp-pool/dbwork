
--[system 계정에서 확인 : 계정들 확인]
--SQL> select username, account_status from dba_users;

--[hr 계정의 lock 해제]
--SQL> alter user hr account unlock;
--확인
--SQL> select username, account_status from dba_users;

--[hr 계정의 비번 변경(a1234)]
--SQL> alter user hr identified by a1234;

--[system 계정에서 다른 계정으로 이동할때]
--SQL> show user
--USER is "SYSTEM"
--SQL> conn hr/a1234
--Connected.
--SQL> show user
--USER is "HR"
--SQL> select * from tab;
--conn system/manager

----------------------------------------------------------------------------
--DDL(CREATE, DROP, ALTER)
--DML(INSERT, DELETE, UPDATE, SELECT)
--DCL
--TABLE(컬럼과 레코드로 구성)

--emp 전체 데이터 확인
select * from employees; --ctrl+enter

--first_name과 last_name만 조회
SELECT first_name, last_name
FROM employees;
    
--emp의 테이블 구조 확인
Desc Employees;

--직업 종류별로 한번씩만 출력(중복 제거)
select DISTINCT job_id from employees;

--이름을 붙여서 출력하고 제목을 '이름'으로 출력
SELECT first_name||' '||last_name as "이름" from employees;
SELECT first_name||' '||last_name "이름" from employees; --"   " : 공백가능
SELECT first_name||' '||last_name 이름 from employees;   --이 름 : 공백불가

--조건으로 검색할 경우에 where절 사용
select first_name, job_id 
from employees
where first_name = 'Steven';

--A로 시작하는 사람 검색할 때 like 사용
select first_name, job_id 
from employees
where first_name like 'A%';

--A이거나 S로 시작하는 사람 검색 or 연산자 사용
select first_name, job_id 
from employees
where first_name like 'A%' or first_name like 'S%';

--a나 s를 포함하고 있는 사람
select first_name, job_id 
from employees
where first_name like '%a%' or first_name like '%s%';

--대소문자 상관없이 a나 s를 포함하고 있는 사람(대소문자 변환 함수 사용)
select first_name, job_id 
from employees
where lower(first_name) like '%a%' or lower(first_name) like '%s%';

select first_name, job_id 
from employees
where upper(first_name) like '%A%' or upper(first_name) like '%S%';

--lower, upper 확인
select  first_name 원이름, 
        upper(first_name) 대문자, 
        lower(first_name) 소문자
from employees;

-- [연산자의 활용]

--first_name 이 a로 끝나는 사람
select first_name
from employees
where lower(first_name) like '%a';

--first_name에서 두번째 글자가 a인 사람
select first_name
from employees
where first_name like '_a%'; 
--세번째 글자가 a인 사람
select first_name
from employees
where first_name like '__a%'; 

--연봉(salary)이 5,000 이상인 경우만 출력
select first_name, salary
from employees
where salary >= 5000;

--연봉 5,000 ~ 8,000 인 경우 출력
select first_name, salary
from employees
where salary >= 5000 and salary <= 8000;

select first_name, salary
from employees
where salary BETWEEN 5000 and 8000;

--연봉이 3,000미만 이거나 10,000 이상인 경우만 출력
select first_name, salary
from employees
where salary <= 3000 or salary >= 10000; --3000출력

select first_name, salary
from employees
where salary NOT BETWEEN 3000 and 10000; --3000출력X

--manager_id가 100, 103, 120인 경우 출력
select first_name, manager_id
from employees
where manager_id = 100 or manager_id = 103 or manager_id = 120;

select first_name, manager_id
from employees
where manager_id IN (100, 103, 120);

--first_name, salary, commission_pct 출력
select first_name, salary, commission_pct
from employees; --commission_pct: null 값이 존재

select first_name, salary, commission_pct
from employees
where commission_pct IS NULL;  --commission_pct = 'null' (X) 문자열이 아니다!

select first_name, salary, commission_pct
from employees
where commission_pct IS NOT NULL;  

--salary 와 comm을 더할 경우 : comm이 null 이면 결과도 null
select salary + commission_pct from employees;

--NVL(컬럼명, 값): null 일 경우 값 지정(mysql에서는 if null
select  salary 연봉, 
        NVL(commission_pct, 0) 커미션, 
        salary + NVL(commission_pct, 0) 총연봉
from employees;

--comm이 널이 아닌 사람 중 salary가 5000 이상인 사람의 first_name과 salary, comm 만 출력
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is NOT NULL and salary >= 5000;

--직업(job_id)이 it_prog 이거나 pu_man 인 사람을 조회(first_name, job_id)
select first_name, job_id
from employees
where job_id = 'IT_PROG' or job_id = 'PU_MAN';

select first_name, job_id
from employees
where job_id IN ('IT_PROG', 'PU_MAN');

--





















