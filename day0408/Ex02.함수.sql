
--[�׷��Լ� ���� : min, max, sum, avg, count]

--emp���̺��� �� ����
select count(*) count from employees;

--salary�� ���հ� ��� ���ϱ�
select sum(salary), avg(salary) from employees;             --�Ҽ������ϰ� �ʹ� ����
select sum(salary), round(avg(salary), 0) from employees;   --�ݿø�
select sum(salary), floor(avg(salary)) from employees;      --����
select sum(salary), ceil(avg(salary))  from employees;      --�ø�

--salary�� �ְ����� ��������
select min(salary) ��������, max(salary) �ְ��� from employees;

-- [�������� ���]
--salary�� ���������� �޴� ����� �̸��� ������ ����Ͻÿ�
select first_name, salary
from employees
where salary = (select MIN(salary) from employees); --���������� �ٲ� �� �ִ� ���̹Ƿ�

--��� �������� ���� �޴� ����� �̸�(first+last)�� ������ ����Ͻÿ�
select first_name||' '||last_name name, salary
from employees
where salary > (select AVG(salary) from employees);

--first_name �� Bruce�� ���� ������ ���� ��� ���(first_name, job_id ���)
select first_name, job_id
from employees
where job_id = (select job_id 
                from employees 
                where first_name = 'Bruce');

--select/from/where/group by/having/order by
--������ �ο����� ��� ���� ���ϱ�
SELECT  job_id ����, 
        count(*) �ο���, 
        round(avg(salary), 0) ��տ���
from employees
GROUP BY job_id;
--���� ������ ��� ������ ���� ������� ���(3�� ��(��տ���) ����)
SELECT  job_id ����, 
        count(*) �ο���, 
        round(avg(salary), 0) ��տ���
from employees
GROUP BY job_id
ORDER BY 3
DESC;
--���� ������ �ο����� ���� �׷���� ���
SELECT  job_id ����, 
        count(*) �ο���, 
        round(avg(salary), 0) ��տ���
from employees
GROUP BY job_id
ORDER BY 2 --�ι�° ��(�ο���)
DESC;
--���� ������ �ο��� 5�� �̻��� ���� ���
SELECT  job_id ����, 
        count(*) �ο���, 
        round(avg(salary), 0) ��տ���
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5
ORDER BY 2 
DESC;

--[JOIN]
--join�� �̿��ؼ� first_name�� department_id�� �̿��ؼ� �μ��� ��ȸ
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--���� sql������ ���� �ߺ����� ���� �÷����� �տ� ���̺�� ���� ����
SELECT first_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--��¥�� ���� �Լ��� ����(dual�� ����)
-- �� Dual ���̺�
-- dual ���̺��� ����ڰ� �Լ�(���)�� ������ �� �ӽ÷� ����ϴµ� �����ϴ�.
-- �Լ��� ���� ������ �˰� ������ Ư�� ���̺��� ������ �ʿ���� 
-- dual ���̺��� �̿��Ͽ� �Լ��� ���� ����(return)���� �� �ִ�.

select sysdate from dual;                                           --����
select sysdate + 1 from dual;                                       --���糯¥���� ������
select sysdate + 7 from dual;                                       --���糯¥���� ������ ��

--���� ��¥���� �⵵ 4�ڸ��� ����
select TO_CHAR(sysdate, 'YYYY') from dual;                          --2022
select TO_CHAR(sysdate, 'yyyy') from dual;                          --2022
select TO_CHAR(sysdate, 'YY') from dual;                            --22
select TO_CHAR(sysdate, 'YEAR') from dual;                          --���ڿ�

--���� ��¥���� �� 2�ڸ��� ����
select TO_CHAR(sysdate, 'MM') from dual;                            --04

--���� ��¥�� ��¥�� �ð����� ǥ��
select TO_CHAR(sysdate, 'yyyy-mm-dd HH24:MI') from dual;            --2022-04-08 15:40
select TO_CHAR(sysdate, 'yyyy-mm-dd am HH24:MI') from dual;         --2022-04-08 ���� 15:41
select TO_CHAR(sysdate, 'yyyy-mm-dd pm HH24:MI') from dual;         --2022-04-08 ���� 15:41

--emp���̺��� first_name�� hire_date�� ����ϴµ� hire_date�� yyyy-mm-dd �������� ���
select first_name name, TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date from employees;

--hire_date���� �⵵�� �����ؼ� 2006�⿡ �Ի��� ����� ��ȸ(first_name, hire_date)
SELECT first_name, TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2006';

--hire_date���� �⵵�� �����ؼ� 5���� �Ի��� ����� ��ȸ(first_name, hire_date)
SELECT first_name, TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'mm') = '05';                          --WHERE TO_CHAR(hire_date, 'mm') = 5; �����߻�

--������ �÷��� �Ի� ������ ���(����⵵-�Ի�⵵)
SELECT  first_name, 
        TO_CHAR(hire_date, 'yyyy-mm-dd') hire_date,
        TO_CHAR(sysdate, 'yyyy') - TO_CHAR(hire_date, 'yyyy') �Ի���� 
FROM employees;

--[�����Լ� ����]
select ABS(-5), ABS(5) from dual;                               --���밪
select ROUND(23.45, 1) from dual;                               --23.5
select ROUND(23.43, 1) from dual;                               --23.4
select ROUND(4567893, -1) from dual;                            --10��   ���������� ���(�ݿø�) 4567890
select ROUND(4567893, -2) from dual;                            --100��  ���������� ���(�ݿø�) 4567900
select ROUND(4567893, -3) from dual;                            --1000�� ���������� ���(�ݿø�) 4568000
select TRUNC(4567893, -3) from dual;                            --1000�� ���������� ���(�ݳ���) 4567000

select MOD(10, 3) from dual;                                    --1 :10�� 3���� ���� ������
select POWER(2, 3) from dual;                                   --8 : 2�� 3��

--[���ڿ� ó�� �Լ� ����]
select CONCAT('hello', 'kitty') from dual;                      --hellokitty
select 'hello'||'kitty' from dual;                              --hellokitty

select INITCAP('haPPy dAY') from dual;                          --Happy Day
select LOWER('haPPy dAY') from dual;                            --happy day
select UPPER('haPPy dAY') from dual;                            --HAPPY DAY

select LPAD('3500', 10, '*') from dual;                         --******3500 :10�ڸ� �� ���� �ڸ�����ŭ �������κ�ǥ
select RPAD('3500', 10, '*') from dual;                         --3500****** :10�ڸ� �� ���� �ڸ�����ŭ ���������� ��ǥ

select SUBSTR('happy day', 3, 3) from dual;                     --ppy :3��° ���ں��� 3�� ����
select SUBSTR('happy day', -3, 3) from dual;                    --day :�ڿ��� 3��° ���ں��� 3�� ����

select LENGTH('happy day') from dual;                           --9 :���� ���� ����
select REPLACE('Have a Nice Day', 'a', '*')       from dual;    --H*ve * Nice D*y :��� a�� *��  ����
select REPLACE('Have a Nice Day', 'Nice', 'Good') from dual;    --Have a Good Day :Nice�� Good�� ����













