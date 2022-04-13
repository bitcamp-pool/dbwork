--[포트포워딩하기]
--컴퓨터에서 특정 포트를 개방하여 통신하는 것

--01. 사설IP 찾기
--CMD : ipconfig
--   무선 LAN 어댑터 Wi-Fi:
--
--   연결별 DNS 접미사. . . . : Davolink
--   링크-로컬 IPv6 주소 . . . . : fe80::761c:11a6:1f5c:76c6%10
--   IPv4 주소 . . . . . . . . . : 192.168.***.***
--   서브넷 마스크 . . . . . . . : 255.255.255.0
--***기본 게이트웨이 . . . . . . : 192.168.***.1 로 접속

--02. 공인IP 찾기
-- 브라우저 주소창 : my ip    IP주소	123.45.123.51(공유기=라우터)

--03. NAT(Network Address Translation)기술
--사설IP : 192.168.0.0~192.168.255.255 약 65,000개(LAN)
--private ip ->Gateway(Router) dddr->public ip
--192.168.0.4->192.168.0.1->NAT가 ip변경:(WAN)123.45.123.51->외부서버 요청
--외부서버 응답->(WAN)123.45.123.51->192.168.0.1(공유기)->192.168.0.4

--04. 포트(PORT: 0~65535)
--app찾기
--0~1023 : Well-known port(22-SSH, 80-http...)해당포트로 리스너 작동
--또 다른 웹서버 관습적으로 8080번으로...
--http://myhome.org:8080

--05. 포트포워딩
--(공인아이피)123.45.123.51:8080외부접속->공유기->192.168.0.4:80
--즉, 라우터 설정

--06. 유동(Dynamic) VS 고정(Static) IP Address
--서버(서비스)-------> ISP(통신사) --------> home
--                     회수/분배

--07. DHCP(Dynamic Host Configuration Protocol) 
--   : 랜선 연결 시 알아서 IP, DNS, 서브넷, 게이트웨이 등을 동적으로 할당 
--공유기(DHCP서버 내장)<--->기기(DHCP클라이언트 내장)
--기기주소에 ip 할당   <--->통신장비 고유 식별자 : 맥,물리적 주소
--할당된 ip를 고정ip로 변경: ip변경을 막기 위해
--제어판>네트워크 및 인터넷>고급네트워크 설정>어댑터 옵션 변경>속성>IPv4>속성

--08. 방화벽 설정
--제어판>네트워크 및 인터넷>고급네트워크 설정>Windows 방화벽>고급설정
-->인바운드 규칙>새규칙

--09. 오라클 원격접속을 위한 DB설정(저장 프로시저 실행)
--EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE); 로컬접속만 허용(false)
--sqlplus로 원격접속
--sqlplus bitcamp/a1234@222.106.201.63:1521/xe 

--10. MySQL 원격접속을 위한 DB설정
--null,  message from server: "Host '192.168.0.1' is not allowed to connect to this MySQL server"
--원격접속을 허용해 주는 로컬 작업이 필요
--SELECT Host,User,plugin,authentication_string FROM mysql.user;
--SELECT Host,User,plugin,password              FROM mysql.user; 버전5.7이하
--즉, root계정으로는 로컬에서만 접속 가능
--모든 IP 허용(참고로 %은 모든 아이피를 포함하지만, localhost는 포함되지 않는다.)

--방법
--GRANT ALL PRIVILEGES ON *.* TO '아이디'@'%' IDENTIFIED BY '패스워드';
--예: 111.222.XXX.XXX 허용
--GRANT ALL PRIVILEGES ON *.* TO '아이디'@'111.222.%' IDENTIFIED BY '패스워드';
--예: 111.222.33.44 특정 1개 허용
--GRANT ALL PRIVILEGES ON *.* TO '아이디'@'111.222.33.44' IDENTIFIED BY '패스워드';

--원래상태 복구
--DELETE FROM mysql.user WHERE Host='%' AND User='아이디';
--FLUSH PRIVILEGES;

C:\Users\bitcamp>mysql -u root -p
Enter password: ****
mysql> use mysql
Database changed
mysql> select host, user, password from mysql.user;
+-----------+------+-------------------------------------------+
| host      | user | password                                  |
+-----------+------+-------------------------------------------+
| localhost | root | *A4B6157319038724E3560894F7F932C8886EBFCF |
+-----------+------+-------------------------------------------+
-- localhost나 127.0.0.1만 등록이 되어있는 것을 확인 할 수 있는데, 외부에서 접근이 되게 하려면, 따로 등록이 필요

-- 1) 특정 IP 접근 허용 설정
-- mysql> grant all privileges on DB명.테이블명 to 'root'@'220.000.00.000' identified by 'root의 패스워드';


-- 2) 특정 IP 대역 접근 허용 설정
-- mysql> grant all privileges on DB명.테이블명  to 'root'@'220.000.%' identified by 'root의 패스워드';


-- 3) 모든 IP의 접근 허용 설정
-- mysql> grant all privileges on DB명.테이블명  to 'root'@'%' identified by 'root의 패스워드'

mysql> grant all privileges on *.* to 'root'@'%' identified by '1234';
Query OK, 0 rows affected (0.03 sec)

mysql> select host, user, password from mysql.user;
+-----------+------+-------------------------------------------+
| host      | user | password                                  |
+-----------+------+-------------------------------------------+
| localhost | root | *A4B6157319038724E3560894F7F932C8886EBFCF |
| %         | root | *A4B6157319038724E3560894F7F932C8886EBFCF |
+-----------+------+-------------------------------------------+

mysql> flush privileges;
Query OK, 0 rows affected (0.03 sec)

-- 4. LISTEN IP 대역 변경

-- my.cnf 설정파일에서 bind-address라는 부분을 주석처리.
-- vi /etc/my.cnf
-- # bind-address = 127.0.0.1

-- 5. mysql 재시작
-- 주석처리가 끝났으면, mysql을 재시작.
-- /etc/init.d/mysqld restart