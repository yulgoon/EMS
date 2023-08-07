##################################################################################################################
#콘솔 출력
# print(1+2): 한 개만 출력
# cat(1, 2): 2개 이상 출력
#연산자
# /     : 나누기
# %/%   : 정수나누기(정수몫)
# %%    : 나머지
# ^, ** : 제곱
#
#함수
# as.Numeric(문자열): 숫자로된 문자열을 숫자로 변경
# as.Data('날짜'): 날짜형 문자열을 날짜로 변경
# Sys.Date(): 오늘 날짜
# Sys.time(): 오늘 일시
# date(): 현재 일시, 출력 형식이 미국식 기준
#
#Data Object: 데이터 모임
# 벡터(vector): 데이터를 1차원 형태로 저장 객체
#   c(1,2,3)
#   1:3
#   seq(1,10,2)
#   rep(1:3,2)
# 팩터(factor): 범위를 가진 벡터의 일종
# 리스트(list): 파이썬의 dict 형태
# 매트릭스(matrix): 2차원 배열
# 데이터프레임(data.frame): 2차원 테이블 형태의 데이터
# 어레이(array): 보통 3차원 이상의 데이터 표현
#
# 데이터의 자료형
#   숫자형: numeric(정수(integer), 실수(double), 복소수(complex))
#   문자형: character => 'aaa', "aaa"
#   논리형: logical(TRUE(T, 1), FALSE(F, 0))
#   날짜형: date, 내부적으로는 numeric, 외부적으로는 문자형으로 출력
#
#집합
# 합집합: union
# 교집합: intersect
# 차집합: setdiff
##################################################################################################################

#cf) rbind(), cbind(): 물리적으로 데이터 병합
#merge(A, B): 병합, 두 개의 데이터프레임을 합하는 기능 => join
#             컬럼을 기준으로 데이터 병합
#             컬럼명의 값이 A, B 서로 같은 데이터만 병합
#merge(A, B, by='key column'): key column의 값이 같은 값만 병합, similar to 'inner join'

cust_id <- c('c01','c02','c03','c04','c05','c06','c07')
last_name <- c('Kim','Lee','Choi','Park','Bae','Kim','Lim')
cust1 <- data.frame(cust_id, last_name)
cust1

cust2 <- data.frame(cust_id = c('c05','c06','c07','c08','c09'), last_name = c('Bae','Kim','Lim','Cho','Yoo'))
cust2

#merge(A, B, by='key column'): key column의 값이 같은 값만 병합, inner join과 같다
cust3 <- merge(cust1, cust2)  #컬럼명의 값이 같은 데이터만 병합
cust3
cust3 <- merge(cust1, cust2, by='cust_id')  #cust_id 컬럼의 값으로 데이터 병합
# => last_name의 데이터가 달라도 cust_id가 같으면 병합
#by의 속성: merge의 key 값
cust3

#merge(A, B, by='key column', all=TRUE): key column을 기준으로 A, B의 모든 데이터 병합, similar to 'full outer join'
cust4 <- merge(x=cust1, y=cust2, by='cust_id', all=TRUE)
cust4

cust5 <- merge(x=cust1, y=cust2, by='cust_id', all.x=TRUE) #key 병합, all.x=TRUE: 모든 x 데이터만 병합, 'left outer join
cust5

cust6 <- merge(x=cust1, y=cust2, by='cust_id', all.y=TRUE) #key 병합, all.x=TRUE: 모든 y 데이터만 병합, 'right outer join
cust6

#cf) cbind, rbind: 단순히 append()
#data.frame에 행 추가: rbind => 열의 수가 같아야 함
df1 = data.frame(name=c('apple','banana','cherry'), price=c(300,200,100))
df1
#df1에 망고, 400 행을 추가하기
df1 = rbind(df1, data.frame(name='mango', price=400)) #df1, df2 데이터를 행으로 붙임
df1

#data.frame에 열 추가: cbind => 행의 수가 같아야 함
df1 <- cbind(df1, data.frame(qty=c(10,20,30,40,50)))  #현재 행의 수가 안 맞기 때문에 오류

df1 = rbind(df1, data.frame(name='strawberry', price=500))  #rbind로 1행 추가
df1 <- cbind(df1, data.frame(qty=c(10,20,30,40,50)))        #이제는 행의 수가 같기 때문에 실행
df1

#subset(data, select=컬럼명, 컬럼명 벡터형태): 부분 데이터만 리턴
no <- c(1,2,3,4,5)
name <- c('서진수','주시현','최경우','이동근','윤정웅')
address <- c('서울','대전','포항','경주','경기')
tel <- c(1111, 2222, 3333, 4444, 5555)
hobby <- c('독서','미술','여행','요리','운동')
member <- data.frame(NO=no, NAME=name, ADDRESS=address, TEL=tel, HOBBY=hobby)
member

#번호, 이름, 전화번호 데이터만 저장
member2 = subset(member, select=c(NO, NAME, TEL))
member2

#전화번호 외의 데이터만 저장: select= -컬럼명, 컬럼명 벡터형태): select부분 데이터 제외하고 리턴
member3 = subset(member, select=-TEL)
member3

#컬럼명 변경하기
colnames(member3) <- c('번호','이름','주소','취미')
col.names(member3) <- c('번호','이름','주소','취미') #오류발생
member3
member3[(c(5,4)),] # 5, 4행의 데이터 조회
member3[(c(5,4,3,2,1)),] # 역순으로 데이터 조회

##################################################################################################################
#조건문: if 구문
# if(조건식1){
#   문장1: 조건식1의 결과가 T인 경우 문장1 수행되는 문장
# } else if(조건식2){
#   문장2: 조건식1의 결과가 F, 조건식2의 결과가 T인 경우 수행되는 문장
# }
# ........
# else{
#   모든 if, else if  결과가 F인 경우 수행되는 문장
# }
##################################################################################################################

#입력된 숫자가 0보다 크면 2배 값을 반환, 0보다 작거나 같으면 0을 반환
#함수로 작성하기
f1 <- function(x){
  if(x>0){
    return (x*2)
  }
  else{
    return (0)
  }
}
f1(10)

##################################################################################################################
#함수: function, method, procedure, module, etc.
##################################################################################################################

#Q. 입력된 숫자가 0보다 크면 '양수', 0보다 작으면 '음수', 0이면 0을 반환하는 함수 f2를 구현하기

f2 <- function(x){
  if(x>0){
    return ('양수')
  }
  else if(x<0){
    return ('음수')
  }
  else{
    return (0)
  }
}

##################################################################################################################
#ifelse(조건식, 참, 거짓) 구문: 조건연산자
##################################################################################################################

#점수가 60이상이면 합격, 미만이면 불합격으로 출력하기
score = 80
ifelse(score >= 60, '합격', '불합격') #"합격"

score = 50
ifelse(score >= 60, '합격', '불합격') #"불합격"

#ASCii => unicode(UTF-8)
#소문자, 대문자, 숫자인 경우 출력(ASCii)
ch = 'A'
if(ch >= 'A' & ch <= 'Z') {
  '대문자'
} else if(ch >= 'a' & ch <= 'z') {
  '소문자'
} else if(ch >= '0' & ch <='9') {
  '숫자'
} else {
  '기타문자'
}

#ASCii 코드값
charToRaw('A')              #16진수 값: Hexadecimal
#strtoi: 문자열을 정수형으로 변환
#strtoi(charToRaw('A'), 16L): charToRaw('A') 코드값을 16진수로 인식해서 정수형(10진수)으로 변환
strtoi(charToRaw('A'), 16L) #10진수 값: Decimal

##################################################################################################################
#반복문: for(변수 in 객체){실행문장}
##################################################################################################################

#1부터 10까지 값을 출력
for(i in c(1:10)){
  print(i)
}

#1부터 10까지 값의 합을 출력
total = 0
for(i in c(1:10)){
  total = total + i
}
total

#1부터 100까지의 값 중 짝수의 합을 출력
#1
total = 0
for(i in c(1:100)){
  if(i %% 2 == 0){
    total = total + i
  }
}
total

#2
total = 0
for(i in seq(2,100,2)){
  total = total + i
}
total

#3: next
total = 0
for(i in c(1:100)){
  if(i %% 2 == 1){
    next              #반복문의 처음으로 제어 이동, JAVA의 continue 기능
  }
  total = total + i
}
total

#break: 반복문을 강제로 중지
#1 ~ 100까지의 수 중 합이 100을 넘을 때의 i값을 출력
total = 0
for(i in c(1:100)){
  total = total + i
  if(total > 100){
    break
  }
}
cat('합:', total, ', i의 값:', i)

#Q1. 1 ~ 100 사이의 수 중 2의 배수이거나 3의 배수인 숫자의 합을 구하기
res = 0
for(i in c(1:100)){
  if(i %% 2 == 0 | i %% 3 == 0){
    res = res + i
    #    cat('i의 값:', i, ', i의 합:', res)
  }
}
res

#Q2. 1 ~ 100 사이의 수 중 2의 배수도 아니고 3의 배수도 아닌 숫자의 합을 구하기
res = 0
for(i in c(1:100)){
  if(i %% 2 == 0 | i %% 3 == 0){
    next
  }
  res = res + i
  #  cat('  i의 값:', i, ', i의 합:', res)
}
res

##################################################################################################################
#while(조건문): 조건문의 결과가 참인 경우만 반복문 수행
##################################################################################################################

i <- 0
while(i<5){
  print(i)
  i <- i+1
}

#1 ~ 100 사이의 값의 합이 100보다 큰 경우의 숫자를 출력하기, while 구문 구현
i <- 0
total <- 0
while(total < 100){
  total <- total + i
  i <- i + 1
}
cat(total, i) #105 15: i의 값 15

i <- 0
total <- 0
while(total < 100){
  i <- i + 1
  total <- total + i
}
cat(total, i) #105 14: i의 값 14
#구문 안의 내용을 어떻게 구성하느냐에 따라 결과 값이 달라질 수 있다

#500, 100, 50, 10원짜리 동전이 있다, 금액을 입력받아 동전으로 변경하는 함수 chgcoin 구현하기
#단, 동전의 갯수는 최소한으로 한다
#vector 객체로 500, 100, 50, 10 설정

x500 = 0
x100 = 0
x50 = 0
x10 = 0

chg500 = 0
chg100 = 0
chg50 = 0
#chg10 = 0

chgcoin <- function(x){
  x500 = x %/% 500
  chg500 = x %% 500
  
  x100 = chg500 %/% 100
  chg100 = chg500 %% 100
  
  x50 = chg100 %/% 50
  chg50 = chg100 %% 50
  
  x10 = chg50 %/% 10
#  chg10 = chg50 %% 10
  
  cat('금액:', x, '원\n', '500원 동전:', x500,'개\n', '100원 동전:', x100,'개\n' ,'50원 동전:', x50,'개\n', '500원 동전:', x10,'개')
}

chgcoin(2580)

#for 반복문으로 수행
chgcoin = function(money){
  for(c in c(500, 100, 50, 10)){
    cat(c, '원 동전:', money %/% c,'개\n')
    money <- money %% c
  }
}
chgcoin(2580)

#while 반복문으로 수행
chgcoin = function(money){
  coin <- c(500, 100, 50, 10)
  i <- 1
  while(money > 0){
    cat(coin[i], '원 동전:', money %/% coin[i],'개\n')
    money <- money %% coin[i]
    i = i + 1
  }
}
chgcoin(2580)

#repeat: 조건 없이 계속 반복, 통상 반복 탈출을 위해 중간에 break 필요함
  chgcoin = function(money){
    coin <- c(500, 100, 50, 10)
    i <- 1
    repeat{
      cat(coin[i], '원 동전:', money %/% coin[i],'개\n')
      money <- money %% coin[i]
      if(money <= 0){
        break
      }
      i = i + 1
    }
  }
  chgcoin(2580)
  
##################################################################################################################
# 정규식
##################################################################################################################
char1 <- c('apple', 'Apple', 'APPLE', 'banana', 'grape')

#grep: char1 벡터 데이터에서 'apple'의 위치를 반환
grep('apple', char1)

char2 <- c('banana', 'apple')
grep(char2, char1)  #banana 위치만 반한
grep('banana|apple|grape', char1) #banana or apple 문자열을 char1에서 위치 반환

grep('banana|apple|grape', char1, value=T)  #value=T: char1에서 값을 반환

#char1 데이터의 요소 중 pp 문자열을 가진 데이터의 위치를 출력하기
#char1 데이터의 요소 중 pp 문자열을 가진 데이터를 출력하기
grep('pp', char1)
grep('pp', char1, value=T)

#대문자 A를 포함하는 문자를 출력하자, char1에서
grep('A', char1, value=T)

#char1에서 소문자 a로 시작하는 문자를 출력하자
grep('^a', char1, value=T)

#char1에서 소문자 e로 끝나는 문자를 출력하자
grep('e$', char1, value=T)

char3 <- c('apple1', 'apple', 'Apple2', 'APPLE', 'banana', 'grape1', 'grape2')
#char3에서 ap 문자를 포함하는 문자를 출력하자
grep('ap', char3, value=T)

#정규식 숫자로 표현: 숫자 => [0-9](특정 문자를 포함할 때), \d(\\d), [[:digit;]](그저 숫자가 포함되면 찾음)
#char3에서 숫자를 포함하는 문자를 출력하자
grep('[0-9]', char3, value=T)
grep('\\d', char3, value=T)
grep('[[:digit:]]', char3, value=T)

#Q. char3에서 대문자를 포함하는 문자를 출력하자
grep('[A-Z]', char3, value=T)
grep('[[:upper:]]', char3, value=T)


#char3에서 대문자를 포함하는 문자를 출력하자
grep('[a-a]', char3, value=T)
grep('[[:lower:]]', char3, value=T)

char4 <- c('홍길동','apple','가나다abc','가나다123','이 몽 룡','1234','!@#%','APPLE')
#영문자를 포함하는 문자열을 출력하자
grep('[A-Za-z]',char4,value=T)
grep('[A-z]', char4, value=T)

grep('[[:alpha:]]', char4, value=T) #문자가 포함되면 가져옴, 영문자/한글 다 됨

#문자, 숫자를 포함하는 문자열을 출력하자
grep('[[:alnum:]]', char4, value=T)

#영문자, 숫자를 포함하는 문자열을 출력하자
grep('[A-Z0-9a-z]', char4, value=T)

#한글만 포함하는 문자열 출력하자
grep('[ㄱ-힣]', char4, value=T)

#숫자로 시작하는 문자열을 출력하자
grep('^[0-9]', char4, value=T)

#숫자로 끝나는 문자열을 출력하자
grep('[0-9]$', char4, value=T)

#숫자 외의 문자를 포함하는 문자열을 출력하자
grep('[^0-9]', char4, value=T)

#공백 문자를 포함하는 문자열을 출력하기
grep('\\s', char4, value=T) #\\s: 공백(small letter)
grep('[[:blank:]]', char4, value=T)
grep(' ', char4, value=T)

#공백 문자를 포함하지 않는 문자열을 출력하기
grep('\\S', char4, value=T) #이 경우는 전체 다 출력 됨(capital letter)

#R에서는 문자열의 + 연산자 사용할 수 없음
'a'+'b' #오류 발생
#paste(): 문자열을 연결하여 하나의 문자열로 반환
paste(char4, collapse='-')
paste('a','b','c')
paste('a','b','c', sep='')
paste('a','b','c', sep='-')

#substr(문자열, 시작인덱스, 종료인덱스): 부분문자열
substr('abc123', 3, 3)  #c
substr('abc123', 1, 3)  #abc

#strsplit: 하나의 문자열을 분리문자를 이용하여 여러개 문자열로 나누어 반환
strsplit('2023/7/27', split = '/')

#Q.exam1 함수: 인자 값이 5보다 크면 1반환, 작으면 0 반환
#1
exam1 = function(x){
  return (ifelse(x>5, 1, 0))
}

#2
exam1 = function(x){
  if(x>5){
    return (1)
  }else{
    return (0)
  }
}
exam1(10)
exam1(5)
exam1(0)
exam1(-5)

#Q.exam2: x, y 두 개의 매개변수 중 큰 수에서 작은 수를 뺀 값을 리턴 하는 함수
exam2 <- function(x, y){
  return (ifelse(x>y, x-y, y-x))
}
exam2(30, 20)
exam2(20, 30)

#Q.exam3: 사과 10개를 한 바구니에 담는다고 가정할 때 사과의 갯수를 매개변수로 입력받아 필요한 바구니 수를 리턴하는 함수
exam3 <- function(x){
  return (ifelse(x%/%10==0,x%/%10,(x%/%10)+1))
}
exam3(54)
exam3(101)

#Q.exam4: 1부터 매개변수로 입력받은 수까지의 전체합, 짝수, 홀수의 합을 출력하는 함수
tNum = 0
eNum = 0
oNum = 0

exam4 <- function(x){
  for(i in c(1:x)){
    tNum = tNum + i
    if(i %% 2 == 0){
      eNum = eNum + i
    }else{
      oNum = oNum + i
    }
  }
  cat(tNum, eNum, oNum)
}

exam4(10)
exam4(100)

##################################################################################################################
# R에서 제공하는 iris 데이터 살펴보자
##################################################################################################################

head(iris)  #첫 6행
tail(iris)  #끝 6행
iris #ctrl + space

#iris 데이터 자료형
class(iris) #data.frame
dim(iris) #150행 5열: 50개씩 3종의 아이리스 데이터를 가지고 있음
nrow(iris) #행의 갯수
ncol(iris) #열의 갯수
colnames(iris) #열의 이름
rownames(iris)

str(iris) #iris 데이터의 요약정보

#iris 데이터의 Species의 column만 조회
iris[,'Species']
iris[,5]

#iris 데이터의 Species column의 levels 조회
levels(iris[,'Species'])

#품종별 데이터 갯수 조회
table(iris[,'Species'])
iris[,-5]

#colSums(): 열별 합계 조회
colSums(iris[,-5])

#colMeans(): 열별 평균 조회
colMeans(iris[,-5])

#rowSums(): 행별 합계 조회
rowSums(iris[,-5])

#rowMeans(): 행별 평균 조회
rowMeans(iris[,-5])

#조건에 맞는 행들만 조회하기 => Species가 setosa인 데이터
iris1 <- subset(iris, Species=='setosa')
str(iris1)
levels(iris1[,5]) #원본 데이터의 내용도 같이 조회 됨

#Sepal.Length > 5, Sepal.Width > 4인 행들만 조회
iris2 <- subset(iris, Sepal.Length > 5 & Sepal.Width > 4)
str(iris2)
iris2[,5]
iris2

#column 조회
#Sepal.Length > 5, Sepal.Width > 4인 행들의 Petal.Length, Petal.Width, Species 컬럼만 조회
iris3 <- iris2[, c('Petal.Length', 'Petal.Width', 'Species')]
# iris3 <- iris2[, 3:5]
iris3

iris4 <- subset(iris, Sepal.Length > 5 & Sepal.Width > 4)[,3:5]
#iris4 <- subset(iris, Sepal.Length > 5 & Sepal.Width > 4)[,c(3,4,5)]
#iris4 <- subset(iris, Sepal.Length > 5 & Sepal.Width > 4)[,c('Petal.Length', 'Petal.Width', 'Species')]
iris4

class(iris)
class(state.x77)

state.x77 #미국의 각 주 정보 데이터, matrix 형태 => 각 값의 자료형이 모두 같다
          #로우명과 컬럼명은 레코드와 컬럼의 이름이므로 자료형과 관계x
mode(state.x77) #numeric
mode(iris) #list

#조건 함수: 결과 TRUE, FALSE
is.matrix(iris) #FALSE: data.frame
is.matrix(state.x77) #TRUE: matrix
is.data.frame(iris) #TRUE: data.frame
is.data.frame(state.x77) #FALSE: matrix

#matrix => data.frame
df77 <- data.frame(state.x77)
class(df77)
mode(df77) #list

#data.frame => matrix
#데이터의 자료형이 전부 문자열로 바껴 버림 => 모든 데이터 값의 자료형이 동일해야 하는데 Species의 문자열 값 때문에 그렇다
miris <- as.matrix(iris) #이러면 전체 문자열로 바껴서 잘 바뀐게 아니다
class(miris)

#Species 컬럼을 제외하고 숫자 값만 가지고 있는 데이터로 만들어서 data.frame으로 변환
miris <- as.matrix(iris[,1:4])
head(miris)
class(miris) #matrix
mode(miris) #numeric

#trees 데이터: 벚나무의 정보를 저장한 데이터
#1. 직경(Girth)의 평균값 구하기
class(trees[,1])
head(trees)
trees[,1]
colMeans(trees[,1]) #에러
mean(trees[,1])
mean(trees$Girth)
mean(trees[,'Girth'])

#2. 직경(Girth)이 전체 직경 평균값보다 큰 데이터만 조회하기
subset(trees, Girth > mean(trees[,1]))

#3. - 직경(Girth)이 전체 직경 평균값보다 크고,
#   - 높이(Height)가 80보다 크고,
#   - 부피(Volume)가 50보다 큰 데이터를 selltree에 저장하고 레코드의 갯수를 출력하기
selltree <- subset(trees, Girth > mean(trees$Girth) & Height > 80 & Volume > 50)
#selltree <- subset(trees, Girth > mean(trees[,'Girth']) & Height > 80 & Volume > 50)
#selltree <- subset(trees, Girth > mean(trees[,1]) & Height > 80 & Volume > 50)
#selltree <- subset(trees, Girth > colMeans(trees[1]) & Height > 80 & Volume > 50)
#selltree <- subset(trees, Girth > colMeans(trees['Girth']) & Height > 80 & Volume > 50)
selltree
str(selltree)
dim(selltree)
nrow(selltree)

##################################################################################################################
#1.R에서 제공하는 cars 데이터셋은 자동차의 속도와 제동거리에 대한 자료이다.
# 이 데이터셋에 대해 다음 문제를 해결하기 위한 코드를 작성하시오.
##################################################################################################################

#1)
class(cars) #data.frame

#2)
dim(cars)

#3)
head(cars)

#4)
str(cars)

#5)
mean(cars[,1])
mean(cars[,2])
colMeans(cars)

#6)
max(cars[2])
max(cars$dist)

#7)
subset(cars, cars[2] == max(cars[2]))
subset(cars, dist == max(cars$dist))

#7-2) 제동거리가 max일 때, 속력만 구하자
subset(cars, dist == max(cars$dist))[,'speed']
subset(cars, dist == max(cars$dist))['speed']

##################################################################################################################
#2.R에서 제공하는 InsectSprays 데이터셋은 살충제의 효과에 대한 자료이다.
# 이 데이터셋에 대해 다음 문제를 해결하기 위한 코드를 작성하시오.
##################################################################################################################

#1)
is.matrix(InsectSprays)
class(InsectSprays)

#2)
str(InsectSprays)

#3)
tail(InsectSprays, 10)
tail(InsectSprays, n=10)

#4)
levels(InsectSprays[,'spray'])
levels(InsectSprays$spray)
levels(InsectSprays[,2])

#5)
table(InsectSprays$spray)

#6)
InsectSprays.e <- subset(InsectSprays, InsectSprays[,'spray'] == 'E')
InsectSprays.e

InsectSprays.e <- subset(InsectSprays, spray == 'E')
InsectSprays.e

#7)
mean(InsectSprays.e[,1])
mean(InsectSprays.e$count)
mean(InsectSprays.e[,'count'])
