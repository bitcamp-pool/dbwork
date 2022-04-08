
--[system �������� Ȯ�� : ������ Ȯ��]
--SQL> select username, account_status from dba_users;

--[hr ������ lock ����]
--SQL> alter user hr account unlock;
--Ȯ��
--SQL> select username, account_status from dba_users;

--[hr ������ ��� ����(a1234)]
--SQL> alter user hr identified by a1234;

--[system �������� �ٸ� �������� �̵��Ҷ�]
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
--TABLE(�÷��� ���ڵ�� ����)

--emp ��ü ������ Ȯ��
select * from employees; --ctrl+enter

--first_name�� last_name�� ��ȸ
SELECT first_name, last_name
FROM employees;
    
--emp�� ���̺� ���� Ȯ��
Desc Employees;

--���� �������� �ѹ����� ���(�ߺ� ����)
select DISTINCT job_id from employees;

--�̸��� �ٿ��� ����ϰ� ������ '�̸�'���� ���
SELECT first_name||' '||last_name as "�̸�" from employees;
SELECT first_name||' '||last_name "�̸�" from employees; --"   " : ���鰡��
SELECT first_name||' '||last_name �̸� from employees;   --�� �� : ����Ұ�

--�������� �˻��� ��쿡 where�� ���
select first_name, job_id 
from employees
where first_name = 'Steven';

--A�� �����ϴ� ��� �˻��� �� like ���
select first_name, job_id 
from employees
where first_name like 'A%';

--A�̰ų� S�� �����ϴ� ��� �˻� or ������ ���
select first_name, job_id 
from employees
where first_name like 'A%' or first_name like 'S%';

--a�� s�� �����ϰ� �ִ� ���
select first_name, job_id 
from employees
where first_name like '%a%' or first_name like '%s%';

--��ҹ��� ������� a�� s�� �����ϰ� �ִ� ���(��ҹ��� ��ȯ �Լ� ���)
select first_name, job_id 
from employees
where lower(first_name) like '%a%' or lower(first_name) like '%s%';

select first_name, job_id 
from employees
where upper(first_name) like '%A%' or upper(first_name) like '%S%';

--lower, upper Ȯ��
select  first_name ���̸�, 
        upper(first_name) �빮��, 
        lower(first_name) �ҹ���
from employees;

-- [�������� Ȱ��]

--first_name �� a�� ������ ���
select first_name
from employees
where lower(first_name) like '%a';

--first_name���� �ι�° ���ڰ� a�� ���
select first_name
from employees
where first_name like '_a%'; 
--����° ���ڰ� a�� ���
select first_name
from employees
where first_name like '__a%'; 

--����(salary)�� 5,000 �̻��� ��츸 ���
select first_name, salary
from employees
where salary >= 5000;

--���� 5,000 ~ 8,000 �� ��� ���
select first_name, salary
from employees
where salary >= 5000 and salary <= 8000;

select first_name, salary
from employees
where salary BETWEEN 5000 and 8000;

--������ 3,000�̸� �̰ų� 10,000 �̻��� ��츸 ���
select first_name, salary
from employees
where salary <= 3000 or salary >= 10000; --3000���

select first_name, salary
from employees
where salary NOT BETWEEN 3000 and 10000; --3000���X

--manager_id�� 100, 103, 120�� ��� ���
select first_name, manager_id
from employees
where manager_id = 100 or manager_id = 103 or manager_id = 120;

select first_name, manager_id
from employees
where manager_id IN (100, 103, 120);

--first_name, salary, commission_pct ���
select first_name, salary, commission_pct
from employees; --commission_pct: null ���� ����

select first_name, salary, commission_pct
from employees
where commission_pct IS NULL;  --commission_pct = 'null' (X) ���ڿ��� �ƴϴ�!

select first_name, salary, commission_pct
from employees
where commission_pct IS NOT NULL;  

--salary �� comm�� ���� ��� : comm�� null �̸� ����� null
select salary + commission_pct from employees;

--NVL(�÷���, ��): null �� ��� �� ����(mysql������ if null
select  salary ����, 
        NVL(commission_pct, 0) Ŀ�̼�, 
        salary + NVL(commission_pct, 0) �ѿ���
from employees;

--comm�� ���� �ƴ� ��� �� salary�� 5000 �̻��� ����� first_name�� salary, comm �� ���
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is NOT NULL and salary >= 5000;

--����(job_id)�� it_prog �̰ų� pu_man �� ����� ��ȸ(first_name, job_id)
select first_name, job_id
from employees
where job_id = 'IT_PROG' or job_id = 'PU_MAN';

select first_name, job_id
from employees
where job_id IN ('IT_PROG', 'PU_MAN');

--





















