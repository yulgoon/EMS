#학생 테이블 생성하기
CREATE table student (
  studno INT PRIMARY KEY,
  NAME VARCHAR(20) NOT NULL,
  grade INT,
  major VARCHAR(50)
)
# student 테이블의 데이터 조회하기
SELECT * FROM student
# student 테이블의 데이터 추가하기
INSERT INTO student (studno,NAME,grade,major)
VALUES (1,'홍길동',1,'경영') 
INSERT INTO student (studno,NAME,grade,major)
VALUES (2,'이몽룡',2,'무역') 
INSERT INTO student (studno,NAME,grade,major)
VALUES (3,'김삿갓',3,'컴공') 

# student 테이블의 데이터 조회하기
SELECT * FROM student

# student 테이블의 이름과 학년 데이터 조회하기
SELECT NAME,grade FROM student

# student 테이블의 2학년 학생의 모든 컬럼을 조회하기
SELECT * FROM student
WHERE grade = 2

# student 테이블의 2학년 학생의 이름,전공 컬럼을 조회하기
SELECT NAME,major FROM student
WHERE grade = 2

SELECT NAME,major FROM student
WHERE 1=2

# 수정 : 이름 홍길동인 학생의 전공:회계로 학년:2로
# 변경하기
SELECT * FROM student
UPDATE student SET major='회계', grade=2
WHERE NAME='홍길동'

SELECT * FROM student

#삭제 : 김삿갓 학생을 학생 정보에서 제거 시키기
#       레코드 삭제
DELETE FROM student WHERE NAME='김삿갓'

SELECT * FROM student
# DML : 데이터 조작어
#    insert : 레코드 추가
#       insert into 테이블명 (컬럼명1,컬럼명2,...)
#          VALUES(값1,값2,...)
INSERT INTO student (studno,NAME,grade,major)
VALUES (1,'홍길동',1,'경영') 

#    update : 레코드의 컬럼의 값을 수정하기
#      update 테이블명 set 컬럼명1=값1, 컬럼명2=값2,...
#      where 레코드 선택 조건
UPDATE student SET major='회계', grade=2
WHERE NAME='홍길동'

#    delete : 레코드 삭제.
#        delete from 테이블명 where 레코드 선택 조건
DELETE FROM student WHERE NAME='김삿갓'

#  select : 테이블의 내용 조회.
#    select 컬럼명1,컬럼명2,... | *(모든컬럼)
#    from  테이블명
#    where 레코드선택조건
#    group by 컬럼명 => 그룹함수 사용시 가능
#    having 그룹함수조건
#    order by 컬럼명 [asc|desc]  => 정렬
#이름으로 정렬하기
SELECT * FROM student ORDER BY NAME

SET autocommit = FALSE;
SELECT * FROM student
COMMIT;
DELETE FROM student WHERE studno=3
SELECT * FROM student
ROLLBACK;

#Transaction (트랜젝션) : 업무단위. 
# TCL(DCL의 일부)  => DML 명령어 실행 후 가능
# commit : 결과 물리적인 저장 공간에 저장
# rollback : 수정된 내용을 취소

UPDATE student SET NAME='가가가' 
SELECT * FROM student
ROLLBACK

#DDL : 데이터 정의어. TCL  대상 아님. 
# create : 객체 생성
#   create table 테이블명 (컬럼명1 자료형2,.....)
# alter : 객체의 구조 변경 
#    ALTER table 테이블명 조건
ALTER TABLE student ADD major2 VARCHAR(50)
SELECT * FROM student
# drop : 객체 제거
DROP TABLE student
SELECT * FROM student
rollbackauth_groupauth_group_permissionsauth_permissionauth_userauth_user_groups