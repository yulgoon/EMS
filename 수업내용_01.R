print(1+2)
1+1
'aaa'
"aaa"
pi
print(pi, digit=5)
print(3,4)
print(pi, digit=3)
print('a','b')
cat(1,':','a')
cat('a','b')
5/2	#나누기, 소숫점 계산
5%/%2	#정수 나누기, 소숫점 절삭
#5%2	#나머지 오류 => 명령어x
5%%2	#나머지
3^3	#제곱
2^2
2^3
3**3	#제곱
100000
10000
'1'+'2'	#문자열+문자열 => 오류
300
3e+2
as.numeric('1')+as.numeric('2')	#as.numeric('a') 문자열 => 숫자
savehistory('C:/Users/GD/Desktop/20230724.r')


#변수 선언이 필요x
#값을 초기화할 때 자료형 결정

a <- 1	#a 변수에 1의 값을 저장 (정수형)
a	#a의 값을 출력
a <- 'b'	#a 변수에 'b'의 값을 다시 저장 (문자열)
a	#a의 값을 출력

# => 변수 선언이 없으므로 자료형이 변하는 것에 주의

a = 1	# =도 대입연산자로 사용가능 하지만 대체로 <- 사용
a

sum(1,2,3)	#[1] 6
sum(1,2,NA)	#[1] NA 	#결측값, NA 연산의 결과가 NA
sum(1,2,NA,na.rm=T)	#[1] 3	#na.rm=T 결측값이 있다면 결측값은 제외하고 합계 계산

n = NA		#변수 n에 결측값 저장
sum(1,2,n)	#NA

#Factor type: 값의 범주(범위)를 가지고 있는 자료형
#1) 순서가 있는 Factor: 순위형 데이터
#2) 순서가 없는 Factor: 명목형 데이터

data <- c(3,2,2,1,1,2,3,3,2)
data			#list (or vector) type
fdata <- factor(data)
fdata			#factor type

#### 날짜, 시간 관련 데이터
#오늘 날짜, 현재 시간 => 대/소문자 주의
Sys.Date()	#KST 타입으로 출력
Sys.time()		#KST 타입으로 출력
date()		#"weekday month day hour:minute:second year"로 출력(USA type)

date1 <- as.Date('2023-07-25')	#날짜를 설정
typeof(date1)			#double (or float)
mode(date1)			#numeric
# => 날짜 자료형은 연산이 가능

date2 <- as.Date('24-07-2023')	#형식 부분에서 오류 발생
date2	#[1] "0024-07-20"			#이상한 날짜 출력

date2 <- as.Date('24-07-2023', format='%d-%m-%Y')	#형식 지정, 대/소문자 주의
date2	#[1] "2023-07-24"	#지정한 형식으로 출력

#날짜 자료형의 연산
as.Date('2023-07-24') - as.Date('2023-08-11') #날짜 - 날짜: 일수 리턴
'2023-07-24' - '2023-08-11'                      #오류 => 문자열끼리 연산 불가

as.Date('2023-07-24') + 7	#날짜에서 7일 이후의 날짜 계산

#R에서 사용되는 데이터 object(데이터 모임(덩어리))
#vector: 데이터를 한 줄로 모아놓은 데이터(1차원 형태로)
data <- c(1,2,3)
data

#factor: 범위를 가진 데이터 객체
fdata <- factor(data)
fdata

#matrix: 표 형태의 데이터, 행과 열로 이루어진 데이터(2차원 형태로), dataframe
#array: 배열, 1차원 ~ n차원 데이터 저장
#list: vector와 비슷, 다양한 자료형을 1차원 형태로 저장

### Data Object 내부에 저장할 객체
#1) 숫자형: numeric
#- 정수
#- 실수
#- 복소수
#2) 문자형: character: ", ' 표시
#3) 논리형: logical; boolean과 같은 type
#- 참: TRUE, T, 1
#- 거짓: FALSE, F, 0
#4) 날짜형(date): 내부적으로 숫자로 저장, 표현은 문자 형태로 날짜 표현

# 벡터
a <- c(1,2,3,4,5)	#a 변수에 1~5까지 값을 저장
a
a <- 1:5
a
# a~f 문자를 b 변수에 저장
b <- 'a':'f'	#오류, 문자는 :을 이용하여 저장 불가
b <- c('a','b','c','d','e','f')
b

#날짜를 벡터로 저장하기, seq()함수 이용
date1 <- seq(from=as.Date('2023-07-30'), to=as.Date('2023-08-02'), by=1)
date1	#[1] "2023-07-30" "2023-07-31" "2023-08-01" "2023-08-02"

date2 <- seq(from=as.Date('2023-01-02'), to=as.Date('2023-12-02'), by='month')
date2

date3 <- seq(from=as.Date('2000-01-01'), to=as.Date('2023-12-31'), by='year')
date3

objects()	#생성한 변수들을 조회
objects(all.names=T)	#[1] ".Random.seed"	# => 내부적으로 숨긴 변수도 조회

#생성된 변수 제거
rm(a)	# 생성된 a 변수 삭제

ls()	#생성한 변수들을 조회
rm(list=ls())	#ls()로 조회되는 생성된 모든 변수 제거

ls()
objects()

a <- 1
b <- 2
ls()
rm(list=objects())	#objects()로 조회되는 생성된 모든 변수 제거
objects()

vec1 = 1:5

#3번째 요소 조회
vec1[3]	#[1] 2	# => R에서 인덱스는 1부터 시작

#3번째 요소만 제외하고 조회
vec1[-3]	#[1] 1 2 4 5	# => 삭제가 아니고 제외만 함

vec1	#[1] 1 2 3 4 5

#벡터 요소의 길이
length(vec1)

#1~3까지의 요소만 조회
vec1[1:3]

#2번째 요소의 값을 6으로 변경
vec1[2] <- 6
#[1] 1 6 3 4 5

#9번째 요소의 값을 9로 변경
vec1[9] <- 9	#[1]  1  6  3  4  5 NA NA NA  9	# => 중간에 비는 번호는 결측값으로 만들어서 저장
length(vec1)	#[1] 9	#결측값도 자릿수는 차지

vec1[6] <- nullfile()
vec1	#[1] "1"    "6"    "3"    "4"    "5"    "nul:" NA     NA     "9"   

length(vec1)

#NA: 값이 없고 자릿수는 차지함
#NULL: 값, 자릿수 모두 없음

#vec1의 3번째 자리 이후 10을 추가
#append(벡터명, 추가값, 인덱스 자릿수)
vec1 <- append(vec1, 10, after=3)
vec1	#[1] "1"    "6"    "3"    "10"   "4"    "5"    "nul:" NA     NA     "9"

#vec1의 3번째 자리 이후 11, 12를 추가
vec1 <- append(vec1, 11:12, after=3)
vec1

#vec1의 5번째 자리 이후 13, 15, 17을 추가
vec1 <- append(vec1, c(13, 15, 17), after=5)
vec1

#벡터의 연산	=> + 연산은 숫자형 연산만 가능
c(1,2,3) + c(4,5,6)	#[1] 5 7 9
c(1,2,3) + 10	#[1] 11 12 13

v1 <- c(1,2,3)
v2 <- c(4,5,6)
v1 + v2	#[1] 5 7 9

#벡터의 내용을 합하기
#v3 <- ('1', '2', '3')
#Error: unexpected ',' in "v3 <- ('1',"

v3 <- c('1', '2', '3')

v1 + v3
#Error in v1 + v3 : non-numeric argument to binary operator

union(v1,v3)	#합집합 형태여서 동일 데이터 값은 한 번 저장
#[1] "1" "2" "3"	#v1은 정수형 데이터였으나 v3과 데이터 타입을 맞춰 문자열로 바뀜

union(v2,v3)	#[1] "4" "5" "6" "1" "2" "3"

v4 <- c('1', '2', '3', '4', '5')
v1+v4
#Error in v1 + v4 : non-numeric argument to binary operator	#argument의 자릿수가 같아야 연산 가능

#뺄셈
v1-v2	#-3 -3 -3
#setdiff: 차집합
setdiff(v4, v1)	#4 5
setdiff(v1, v4)	#

#intersect: 교집합
intersect(v4, v1)	#1 2 3
intersect(v1, v4)	#1 2 3

mean(v1)	#평균
sum(v1)	#합계

names(v1) <- c('a', 'b', 'c')

#seq()
v5 <- seq(1, 5)
v5	#[1] 1 2 3 4 5

v6 <- seq(2, -2)
v6	#[1]  2  1  0 -1 -2

v7 <- seq(1, 10, 2)
v7	#[1] 1 3 5 7 9

#rep(): repeat
v8 <- rep(1:3, 2)
v8	#[1] 1 2 3 1 2 3

v9 <- rep(1:3, each=2)
v9	#[1] 1 1 2 2 3 3

#v9의 길이 조회하기
length(v9)	#[1]6
NROW(v9)	#[1]6

#값 %in% 벡터: 벡터 내부에 값이 존재?
3 %in% v9	#TRUE
4 %in% v9	#FALSE

#Q: 다섯명의 학생이 시험 점수가 80 60 70 50 90입니다.

#score 벡터 변수에 저장하기
score = c(80, 60, 70, 50, 90)

#평균과 총점
cat('평균 :', mean(score))
  cat('총점 :', sum(score))
  
  #0~10까지 0.5씩 증가하는 실수 벡터를 생성
  v1 <- seq(0, 10, 0.5)
  
  #5번째 요소의 값 조회하기
  x = c(2, -1, 3, 7, 0.5, 8)
  x[5]
  
  #1~3번째 요소의 값 조회6,2,하기
  x[1:3]
  
  #5번째 요소의 값만 제외하고 조회하기
  x[-5]
  
  #factor: 범주가 있는 자료형
  #factor_test.txt 파일을 생성 (D:/R/data/factor_test.txt)
  getwd()
  setwd('D:/R/data')	# => factor_test.txt 파일이 저장된 폴더 경로
  
  #혈액형을 범주형 데이터로 출력
  #1. 혈액형 데이터 조회
  txt1$blood
  f1 <- factor(txt1$blood)
  f1	#[1] A  O  B  AB A  O 
  #Levels: A AB B O
  
  #2. 성별 데이터 조회
  f2 <- factor(txt1$sex)
  f2	#[1] 남 여 남 남 남 여
  #Levels: 남 여
  
  #3. 지역 데이터 조회
  f3 <- factor(txt1$location)
  f3	#[1] 부산 강원 경북 충남 전북 전남
  #Levels: 강원 경북 부산 전남 전북 충남
  
  #summary(): 건수 정보를 표로 출력
  s1 <- summary(f1)
  s1			#A AB  B  O
  #2  1   1  2
  s2 <- summary(f2)
  s2			#남 여 
  #4  2 
  
  s3 <- summary(f3)
  s3			#강원 경북 부산 전남 전북 충남 
  #  1     1    1     1     1     1 
  
  ######################################################
  
  #matrix
  #matrix(data,nrow=숫자,ncol=숫자,byrow=T/F,dimnames=)
  #data: 데이터
  #nrow=행의 수
  #ncol=열의 수
  #byrow=T/F(행우선/열우선), 기본값: F
  #dimnames=행과 열의 이름 설정
  
  ######################################################
  mat1 <- matrix(c(1,2,3,4))
  mat1			#4행 1열: 열우선
  
  mat2 <- matrix(c(1,2,3,4), nrow=2)
  mat2			#2행 2열: 열우선
  mat3 <- matrix(c(1,2,3,4), ncol=2)
  mat3			#mat2와 동일
  
  mat4 <- matrix(c(1,2,3,4), nrow=2, byrow=T)
  mat4			#2행 2열: 행우선
  
  mat5 <- matrix(c(1,2,3,4), byrow=T)
  mat5			#4행 1열: byrow=T가 안 통함
  
  mat6 <- matrix(c(1,2,3,4), ncol=4)
  mat6			#1행 4열: byrow와 관계 없이 ncol이 4개이기 때문에 강제로 1행 4열로 저장
  
  #값을 조회하기
  #1열의 값 조회하기
  mat3[,1]		#1 2
  #1행의 값 조회하기
  mat3[1,]		#1 3
  #2행 2열의 값 조회하기
  mat3[2, 2]	#4
  
  #Q: mat7 변수에 1~9까지의 숫자를 3행 3열 matrix로 생성하기
  mat7 <- matrix(1:9, ncol=3, byrow=T)
  mat7
  
  #rbind(): 행 추가
  #mat7 matrix에 11, 12, 13 값을 가진 행 추가하기
  mat7 <- rbind(mat7, 11:13)
  mat7		#4행 3열: 행 추가 시, 열 갯수가 동일해야 함
  
  #cbind(): 열 추가
  mat7 <- cbind(mat7, 14:17)
  mat7
  
  #Q: a,b,c,d 4개의 문자열을 2행 2열 matrix 객체로 생성하기
  mat8 <- matrix(c('a', 'b', 'c', 'd'), nrow=2, byrow=T)
  mat8
  
  #e, f 2개 문자 열추가
  mat8 <-cbind(mat8, c('e', 'f'))
  mat8
  
  #cf) mat8 <-cbind(mat8, 'e', 'f')
  
  #colnames(): 컬럼 이름 설정하기
  colnames(mat8) <- c('first', 'second', 'third')
  
  #rownames(): 로우 이름 설정하기
  rownames(mat8) <- c('one', 'two')
  
  #nrow(): 행의 갯수 리턴
  nrow(mat8)	#2
  
  #ncol(): 행의 갯수 리턴
  ncol(mat8)	#3
  
  #length(): 행렬 관계 없이 전체 갯수
  length(mat8)	#6
  mode(mat8)	#"character"	# => mode(): 요소의 자료형
  
  #matrix의 연산
  a <- matrix(1:3, 3, 3)	#1~3사이의 값을 3열로 표시(열우선)
  a	#      [,1]  [,2]  [,3]
  #[1,]    1    1    1
  #[2,]    2    2    2
  #[3,]    3    3    3
  
  b <- matrix(4:6, 3, 3)
  b	#     [,1] [,2] [,3]
  #[1,]   4   4   4
  #[2,]   5   5   5
  #[3,]   6   6   6
  
  
  #행렬성분의 곱
  a*b	#     [,1]   [,2]   [,3]
  #[1,]    4    4     4
  #[2,]   10   10   10
  #[3,]   18   18   18
  
  #행렬의 곱
  a%*%b	#       [,1]  [,2]  [,3]
  #[1,]   15   15   15
  #[2,]   30   30   30			
  #[3,]   45   45   45
  
  #결과
  #[1,1] 1*4 + 1*5 + 1*6 = 15
  #[1,2] 1*4 + 1*5 + 1*6 = 15
  #[1,3] 1*4 + 1*5 + 1*6 = 15
  #[2,1] 2*4 + 2*5 + 2*6 = 30
  #[2,2] 2*4 + 2*5 + 2*6 = 30
  #[2,3] 2*4 + 2*5 + 2*6 = 30
  #[3,1] 3*4 + 3*5 + 3*6 = 45
  #[3,2] 3*4 + 3*5 + 3*6 = 45
  #[3,3] 3*4 + 3*5 + 3*6 = 45
  
  #t(): 행렬 반전 => 전치 행렬
  c <- matrix(c(1,-2,4,-1,3,-5,2,7,5),3,3)
  t(c)	#전치 행렬
  
  #solve(): 역행렬 => 행렬의 곱의 결과가 단위 행렬인 행렬
  c1=solve(c)	#c1 = c의 역행렬
  c1	
  c %*% c1		#출력 => 단위 행렬
  
  #colSums(): 배열의 열별 합계
  c
  colSums(c)
  
  #rowSums(): 배열의 행별 합계
  rowSums(c)
  
  x <- rep(1:4, 4)
  x
  x[9] <- NA
  m <- matrix(x, nrow=4)
  m
  
  #Q: m matrix의 행의 합, 영의 합 출력
  colSums(m)	#10 10  NA 10
  rowSums(m)	#NA  8 12 16
  
  #Q: m matrix의 행의 합, 영의 합을 NA 제외하고 출력
  colSums(m, na.rm=T)	#10 10  9 10
  rowSums(m, na.rm=T)	#3  8 12 16
  
  #Q: m matrix의 행의 평균, 열의 평균 출력
  colMeans(m, na.rm=T)	#2.5 2.5 3.0 2.5
  rowMeans(m, na.rm=T)	#1 2 3 4
  
  ######################################################
  
  #배열: 일반적으로 3차원 이상의 자료형으로 구성할 때 사용(1, 2차원은 각각 vector, matrix 사용)
  #array: 배열은 n차원 표현이 가능하므로 1, 2차원도 표현은 가능
  
  ######################################################
  
  arr1 <- array(c(1:12),dim=c(4,3))
  arr1
  
  #3차원 배열
  arr2 <- array(c(1:12), dim=c(2,2,3))
  arr2
  
  #요소 조회: [행, 열, 층]
  arr2[2,2,2]	#8
  arr2[2,2,3]	#12
  arr2[1,2,2]	#7
  
  #dim(): 배열의 구조
  dim(arr1)		#4 3 => 4행 3열
  dim(arr2)		#2 2 3 => 2행 2열 3층
  
  ######################################################
  
  #list: (이름, 값) 형태로 저장된 데이터
  # 파이썬의 딕셔너리{}
  
  ######################################################
  
  list1 <- list(name='James Seo', address='Seoul', tel='010-1111-2222', pay=500)
  list1
  
  #name의 값 조회
  list1$name	#name 데이터 값을 리턴
  list1[2:3]		#2번째 데이터에서 3번째 데이터 조회, address, tel의 값을 조회
  #정확히 파이썬의 dict라고 하기에도 뭐하다...
  
  #name, pay 값 조회
  list1[c(1,4)]
  
  #Q: name= '홍길동', height=170인 리스트 x
  x <- list(name= '홍길동', height=170)
  x
  
  #Q: name= '홍길동', height=170, score=80, 90, 85인 리스트 y
  y <- list(name= '홍길동', height=170, score=c(80, 90, 85))		#리스트(벡터) 형태
  y
  
  #영어점수 출력
  y$score[2]
  
  #새로운 데이터 추가
  y$birthday <- '1990-05-01'
  
  #name을 '김삿갓'으로 변경
  y$name='김삿갓'
  
  #birthday 값을 제거
  y$birthday <- NULL	# 값 및 아예 자리까지 전부 제거
  
  #name 값에 홍길동, 김삿갓 둘 다 저장하기
  y$name <- c('홍길동','김삿갓')	#$name
  #[1] "홍길동" "김삿갓"
  
  #name에서 김삿갓만 출력
  y$name[2]
  
  #name 값 출력하기
  y$name
  y[1]
  
  ######################################################
  
  #data.frame: 사실은 matrix이지만 list처럼 하나의 자리에 여러가지 요소를 넣을 수 있음
  #matrix: 요소의 자료형이 동일
  #data.frame: 요소의 자료형이 달라도 됨
  
  ######################################################
  
  d <- data.frame(x = c(1, 2, 3, 4, 5), y = c(2, 4, 6, 8, 10))
  d
  
  #d 데이터에서 x 값 조회
  d$x
  
  #d 데이터에서 y 값 조회
  d$y
  
  ##### data.frame 객체 생성하기
  #1. 벡터를 이용한 생성
  no<- c(1,2,3,4)
  no
  name <- c('Apple','Peach','Banana','Grape')
  name
  price <- c(500,1000,500,2000)
  price
  qty <- c(5,2,6,1)
  qty
  
  #data.frame 생성
  sales <- data.frame(No=no, NAME=name, PRICE=price, QTY=qty)
  sales
  
  #1행 3열 데이터 조회
  sales[1,3]
  
  #1열 데이터 조회
  sales[1]
  
  #1행 데이터 조회
  sales[1,]
  
  #cf) sales[,1]
  
  #1행, 3행 데이터 조회
  sales[c(1,3),]	#  No   NAME PRICE QTY
  #1  1  Apple   500   5
  #3  3 Banana   500   6
  
  #1열, 3열 데이터 조회
  sales[c(1,3)]	#  No PRICE
  #1  1   500
  #2  2  1000
  #3  3   500
  #4  4  2000
  sales[,c(1,3)]	#vector 앞에 ,를 찍어도 같은 결과 조회
  
  #1행, 3행 중 1열, 3열 데이터 조회
  sales[c(1,3),c(1,3)]	#  No PRICE
  #1  1   500
  #3  3   500
  
  #1~3행까지의 데이터 출력하기
  sales[1:3,]
  
  #1~3행까지의 데이터 중 2~4열 데이터 출력하기
  sales[1:3,2:4]
  
  #하나의 vector로 data.frame 생성 (vector => matrix => data.frame) 
  x <- c(1,'Apple',500,5,2,'Peach',1000,2,3,'Banana',500,6,4,'Grape',2000,1)
  m1 <- matrix(x, nrow=4, byrow=T)	#m1의 자료형: 문자열로 전부 바뀜
  
  #matrix로 data.frame 객체 생성하기
  sales2 <- data.frame(m1)
  sales2
  
  #열의 이름 'NO','NAME','PRICE','QTY'로 수정
  names(sales2) <- c('NO','NAME','PRICE','QTY')
  names(sale2)	#[1] "NO"    "NAME"  "PRICE" "QTY", sales2 데이터의 컬럼명 조회
  
  mode(sales2)
  length(sales2)	#4 => 4개의 컬럼
  #cf) length(m1)	#16 => 각 요소 하나하나의 총 갯수(길이)
  
  #행의 이름 조회하기
  row.names(sales2)
  
  #행의 이름 A,B,C,D로 수정
  row.names(sales2) <- c('A','B','C','D')
  
  #수량이 5개 미만인 상품만 조회
  #subset(): 조건으로 조회
  
  subset(sales2, QTY < 5)
  #  NO  NAME PRICE QTY
  #B  2 Peach  1000   2
  #D  4 Grape  2000   1
  
  subset(sales2, QTY >= 5)
  #  NO   NAME PRICE QTY
  #A  1 Apple   500   5
  #C  3 Banana   500   6
  
  #가격이 2000인 데이터 조회
  subset(sales2, PRICE == 2000)
  
  #vector data의 조건
  x = 1:20
  
  #10 이상인 데이터만 조회
  x[x>=10]		#vector는 조건식을 바로 넣어서 조회 가능
  x>=10		#논리형으로 반환, T/F
  
  #x 데이터 중 짝수인 데이터만 조회
  x[x%%2==0]
  
  #rbind: 행 추가(합하기)
  no <- c(1,2,3)
  name <- c('apple','banana','peach')
  price <- c(100,200,300)
  
  #data.frame df1 생성
  df1 <- data.frame(NO=no, NAME=name, PRICE=price)
  df1
  
  no <- c(10,20,30)
  name <- c('train','car','aeroplane')
  price <- c(1000,2000,3000)
  
  #data.frame df2 생성
  df2 <- data.frame(NO=no, NAME=name, PRICE=price)
  df2
  
  #rbind(): 행 합치기
  df3 <- rbind(df1, df2)
  df3
  
  #cbind(): 열 합치기
  df4 <- cbind(df1, df2)
  df4
  
  #Q: 문제1
  #data.frame x를 구현하기
  #x
  
  #matrix 함수를 이용하여 구현하기
  x = matrix(1:9, nrow=3)
  rownames(x) <- c('r1','r2','r3')
  colnames(x) <- c('c1','c2','c3')
  
  #cf) x <- matrix(1:9, nrow=3, dimnames=list(c('r1','r2','r3'),c('c1','c2','c3')))
  
  #matrix x를 data.frame x로 변환
  x = data.frame(x)
  x
  
  #행과 열의 갯수 출력하기
  #cf) dim(x)
  nrow(x)
  ncol(x)
  
  #행과 열의 이름 출력 하기
  rownames(x)
  row.names(x)
  colnames(x)
  names(x)
  
  #Q: 문제2
  #x = c(2, -1, 3, 7, 0.5, 8)가 실행되었다고 하자. 다음 물음을 R언어로 답하시오.
  x = c(2, -1, 3, 7, 0.5, 8)
  x
  
  #6, 2, 4번째 원소를 동시에 찾아라.	#8 -1 7
  x[c(6, 2, 4)]
  
  #x의 원소 중 0보다 큰 값을 찾아라.
  x[x>0]
  
  #짝수 원소들을 찾아라.
  x[x%%2==0]
  
  #x에서 홀수 원소를 찾아 제거하라. 결측값이 있게 생성하기.
  x[x%%2==1] <- NA		#2.0  NA  NA  NA 0.5 8.0
  
  #cf) 홀수 값을 제외한 나머지 값만 저장, 결측값이 없이 생성하기.
  setdiff(x, x[(x%%2)==1])	#2.0 0.5 8.0
  
  #Q: 문제3
  #다음과 같은 번호(ID), 성명(name), 성적(score)를 성분으로 하는 리스트가 있다.
  L = list(ID=c(1,2,3), name=c('Kim','Lee','Park'), score=c(80,95,75))
  L
  
  #length(L)은 얼마이며, 이것은 무엇을 의미하는가?
  #3
  #L의 컬럼 갯수를 의미
  
  #성적 75를 80으로 수정하라.
  L$score[3] <- 80	# 정확한 조건이 아님
  L$score[L$score==75] <- 80
  
  #L$name=='Park'의 결과를 쓰고, 무엇을 의미하는지 설명하라.
  #FALSE FALSE  TRUE
  #list L의 name column의 각 값이 Park인지 검증하여, Park이면 TRUE, Park가 아니면 FALSE 반환
  
  #L$score[L$name=='Park']의 결과를 쓰고, 문장이 무엇을 의미하는지 설명하라.
  80
  #L$name의 값이 Park인 행의 score 값을 조회
  
  #1번 학생의 이름과 성적을 알아내는 문장을 만들어 보아라.
  cat(L$name[L$ID==1], L$score[L$ID==1])	#화면에 출력
  union(L$name[L$ID==1], L$score[L$ID==1])	#자료형이 문자열로 통일
  c(L$name[L$ID==1], L$score[L$ID==1])	#객체에 저장
  
  v <- c(1,2,'3',4)   # 1번
  sum(v)              # 2번
  
vec <- c(62,32,36,29,39,44,81)
names(vec) <- c('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat')
vec
sum(vec)
#grep('1|6|7', vec)
vec[c(6, 7, 1)]
