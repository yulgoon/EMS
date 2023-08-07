##############################################
# 조건문 : if구문, ifelse구문 (조건연산자)
#
# 반복문 : for (변수 in 순서가 있는 객체값) { ...  }
# 반복문 : while (조건문){ ...  }
# 반복문 : repeat{ break   }
#
# 반복문 종료 : break
# 반복문 다음으로  : next (반복문의 처음으로 제어 이동.)

# 정규식 : grep (패턴, 데이터,value=T) : 데이터 중 패턴에 맞는 데이터를 선택
#  패턴  [0-9],[[:digit:]],\d,\s,\S....
##############################################
# 종업원 팁 데이터 분석하기 : reshape2 패키지에 저장된 자료됨. 
# reshape2 패키지 설정하기
install.packages("reshape2") #reshape2 패키지 설치. 경로에 한글,공백이 있는 경우 오류발생가능
library(reshape2)  #설치된 패키지 중 사용
.libPaths()  #패키지가 설치된 위치 조회. 
#.libPaths(변경할폴더). # 패키지 설치 폴더 변경

class(tips)

#요일별 팀을 받은 갯수를 조회하기
table(tips$day)
str(tips)

# Dinner인 경우만 dinner 데이터에 저장. 
# Lunch인 경우만 lunch 데이터에 저장. 
dinner = subset(tips,time=="Dinner")
lunch = subset(tips,time=="Lunch")
str(dinner)
str(lunch)
#dinner 데이터에서 요일별 건수 조회하기
table(dinner$day)
#lunch 데이터에서 요일별 건수 조회하기
table(lunch$day)

#dinner,lunch 데이터에서 결제금액, 팁, 인원수의 평균 조회하기
colMeans(dinner[c("total_bill","tip","size")])
colMeans(lunch[c("total_bill","tip","size")])

#결제 금액 대비 팁의 비율 조회하기
tips$tip / tips$total_bill
#결제 금액 대비 팁의 비율의 평균 조회하기
mean(tips$tip / tips$total_bill)
#결제 금액 대비 팁의 비율의 최대값 조회하기
max(tips$tip / tips$total_bill)
#결제 금액 대비 팁의 비율의 최소값 조회하기
min(tips$tip / tips$total_bill)

#저녁시간의 결제 금액 대비 팁의 비율의 평균 조회하기
mean(dinner$tip / dinner$total_bill)
#점심시간의 결제 금액 대비 팁의 비율의 평균 조회하기
mean(lunch$tip / lunch$total_bill)

#### 키보드에서 데이터 입력받기 
# BMI : 몸무게/미터환산키의 제곱
# BMI : 25 미만 : 정상
# BMI : 25 이상 30미만 : 과체중
# BMI : 30 이상 : 비만 
#키와 몸무게를 키보드에서 입력받기 
install.packages('svDialogs') #키보드 입력을 위한 패키지 설정
library(svDialogs)             #키보드 입력을 위한 패키지 사용
height <- dlgInput('Input Height(cm)')$res
weight <- dlgInput('Input weight(kg)')$res
height  #문자열
weight
#BMI 계산.
# 키와 몸무게값을 숫자형 변경하기
h <- as.numeric(height)
w <- as.numeric(weight) 
h
w
# 키를 미터로 환산하기
h <- h/100
h
bmi <- w/h^2
bmi
if (bmi < 25) {
  result <- "정상"
} else if(bmi >= 25 & bmi < 30) {
  result <- "과체중"
} else {
  result <- "비만"
}
cat("키:",height,",몸무게:",weight,",bmi:",bmi,"=>",result)
## 파일로 부터 데이터 입력받기
# airquality.csv 파일을 다운받아 현재폴더/data/폴더에 붙여넣기
getwd()
#데이터폴더설정
setwd("d:/20230717/R/data")
getwd()
#header = T : 첫번째 줄은 header 정보. 컬럼명으로 설정.
air <- read.csv("airquality.csv",header = T) #첫번째 줄은 컬럼명
#air <- read.csv("airquality.csv",header = F) #첫번째 줄도 데이터
str(air)
head(air, n=10)
#월별 레코드 건수 조회하기
table(air$Month)
#오존수치별 레코드 건수 조회하기
table(air$Ozone)
table(is.na(air$Ozone)) #is.na : 결측값여부. 결측값 빈도수
# False : 정상데이터 갯수
# True :  결측데이터 갯수
table(!is.na(air$Ozone)) #is.na : 결측값여부. 결측값 빈도수
# False : 결측데이터 갯수
# True :  정상데이터 갯수

#엑셀파일 읽기
install.packages("xlsx") #엑셀파일을 위한 패키지 설정.
# JAVA_HOME 설치하기
#    브라우저에서 https://jdk.java.net/java-se-ri/17 페이지 열기
#    Windows 10 x64 Java Development Kit (sha256) 178 MB 다운받기
#     => openjdk-17+35_windows-x64_bin.zip 압축풀기
#     => 압축푼 파일의 jdk-17 절대 경로 복사하기 : D:\setup\jdk-17
#    설정 => 시스템 환경변수 => 시스템 부분에서 새로만들기 버튼 클릭
#    JAVA_HOME, D:\setup\jdk-17 => 설정
#    Path 선택=> 변경 => D:\setup\jdk-17\bin 저장 하고 나오기
#    RStudio 다시 실행하기

library(xlsx) #rJava 패키지 필요.
getwd()
setwd("D://R/data")
getwd()

air <- read.xlsx("airquality.xlsx",header=T,sheetIndex=1)
str(air)
#air$Ozone : 자료형이 char임.NA라는 문자열로 인식.
table(is.na(air$Ozone))
table(is.na(air$Solar.R))

#air$Ozone 데이터의 자료형을 숫자형으로 변경
air$Ozone <- as.numeric(air$Ozone) #NA 결측값을 변환.
air$Solar.R <- as.numeric(air$Solar.R)
str(air)

#air 데이터를 air.xlsx파일로 저장하기
write.xlsx(air,'air.xlsx',row.names=F)

####### apply 함수 :apply(데이터,행(1)/열(2),적용함수이름)
str(iris)
#iris 데이터에서 꽃받침,꽃잎의 가로,세로 의 평균출력하기
colMeans(iris[1:4])
rowMeans(iris[,1:4])
#iris[,1:4] : 모든행, 1~4번째 컬럼까지의 데이터
apply(iris[,1:4],1,mean) #행별 평균
apply(iris[,1:4],2,mean) #열별 평균

# 응시자 10의 점수 
s1 <- c(14,16,12,20,8,6,12,18,16,10)
s2 <- c(18,14,14,16,10,12,10,20,14,14)
s3 <- c(44,38,30,48,42,50,36,52,54,32)
score <- data.frame(s1,s2,s3)
score
#응시자별 과목별 총점 출력하기
total <- rowSums(score)
total <- apply(score,1,sum)
total

#total 데이터를 열로 추가하여, scoreset 데이터에 저장하기
scoreset <- cbind(score,total)
scoreset
#s1,s2 과목은 20점 만점, s3 과목은 60점 만점
#각각 과목이 40%이상 득점이 되고, 총합이 60점 이상인 경우 합격.
# scoreset 데이터에 합격, 불합격 여부 설정하기
result <- c()
for(i in 1:nrow(scoreset)) {
  if(scoreset[i,1] < 20 *0.4 | scoreset[i,2] < 20 *0.4 | scoreset[i,3] < 60 *0.4) {
    result[i] <- '불합격'
  } else if(scoreset[i,4] >= 60) {
    result[i] <- '합격'
  } else {
    result[i] <- '불합격'
  }
}
apply(scoreset[,1:4],2,range)
result
# result 데이터를 scoreset 데이터 추가하기
scoreset <- cbind(scoreset,result)
scoreset

########################
# which(조건) : 조건에 맞는 데이터의 위치 리턴
# which.max(데이터) : 데이터 중 가장 큰값의 위치
# which.min(데이터) : 데이터 중 가장 작은값의 위치
########################
score <- c(76,84,69,50,95,60,82,71,88,84)
# 성적이 69인 학생은 몇번째? 
which(score==69) # 3
# 성적이 84인 학생은 몇번째? 
which(score==84) # 2 10
# 성적이 85 이상인 학생은 몇번째? 
which(score>=85) # 5 9
# 성적이 가장 높은 학생은 몇번째? 
which.max(score) # 5
# 성적이 가장 낮은 학생은 몇번째? 
which.min(score) # 4

#성적이 60이하인 학생의 점수를 61점으로 상향하기
which(score<=60)
score[which(score<=60)] <- 61
score

#score 데이터에서 성적이 80이상인 점수를 조회하기
subset(score,score>=80) #84 95 82 88 84
score[which(score>=80)] #84 95 82 88 84

score<- c(60,40,95,80)
names(score) <- c('John','Jane','Tom','David')
score
#성적의 제일 좋은 사람의 이름 조회하기
names(score)[which.max(score)]
#Jane의 성적 조회하기
idx <- which(names(score)=='Jane')
idx
score[idx]
score[which(names(score)=='Jane')]

######## 언어 발달 상황 데이터 분석
install.packages('Stat2Data') #데이터들을 저장하고 있는 패키지
library(Stat2Data)
data()  #사용할수 있는 데이터를 조회.
data("ChildSpeaks") #ChildSpeaks 데이터 리턴
str(ChildSpeaks)
#child 컬럼 : 번호.
#age 컬럼 : 월령. 개월수 => 말을 시작한 월령
#Gesell 컬럼 : 언어 이해력 점수

#age 컬럼이 
# 9 미만 : 5등급, 
# 9개월 이상 14개월 미만 : 4등급
# 14개월 이상 20개월 미만 : 3등급
# 20개월 이상 26개월 미만 : 2등급
# 26 이상 : 1등급
# m1컬럼 추가
idx <- which(ChildSpeaks$Age < 9)
idx
ChildSpeaks[idx,'m1'] <- 5
ChildSpeaks
idx <- which(ChildSpeaks$Age >= 9 & ChildSpeaks$Age < 14)
ChildSpeaks[idx,'m1'] <- 4
idx <- which(ChildSpeaks$Age >= 14 & ChildSpeaks$Age < 20)
ChildSpeaks[idx,'m1'] <- 3
idx <- which(ChildSpeaks$Age >= 20 & ChildSpeaks$Age < 26)
ChildSpeaks[idx,'m1'] <- 2
idx <- which(ChildSpeaks$Age >= 26)
ChildSpeaks[idx,'m1'] <- 1
ChildSpeaks

#Gesell 컬럼의 값이 70 미만 : 1등급
#Gesell 컬럼의 값이 70 이상 90 미만 : 2등급
#Gesell 컬럼의 값이 90 이상 110 미만 : 3등급
#Gesell 컬럼의 값이 110 이상 130 미만 : 2등급
#Gesell 컬럼의 값이 130 이상  : 1등급
# m2 컬럼 생성하기
idx <- which(ChildSpeaks$Gesell < 70)
ChildSpeaks[idx,'m2'] <- 1  
idx <- which(ChildSpeaks$Gesell >= 70 & ChildSpeaks$Gesell < 90)
ChildSpeaks[idx,'m2'] <- 2  
idx <- which(ChildSpeaks$Gesell >= 90 & ChildSpeaks$Gesell < 110)
ChildSpeaks[idx,'m2'] <- 3  
idx <- which(ChildSpeaks$Gesell >= 110 & ChildSpeaks$Gesell < 130)
ChildSpeaks[idx,'m2'] <- 4  
idx <- which(ChildSpeaks$Gesell >= 130)
ChildSpeaks[idx,'m2'] <- 5  
ChildSpeaks

#total 컬럼 생성 : m1 + m2 컬럼의 합
ChildSpeaks$total <- ChildSpeaks$m1 + ChildSpeaks$m2
ChildSpeaks$total 

# total 값이 3 미만 : 매우느림
# total 값이 3 이상 5 미만 : 느림
# total 값이 5 이상 7 미만 : 보통
# total 값이 7 이상 9 미만 : 빠름
# total 값이 9 이상  : 매우빠름
# result 컬럼으로 생성하기
idx <- which(ChildSpeaks$total < 3)
ChildSpeaks[idx,"result"] <- "매우느림"
idx <- which(ChildSpeaks$total >= 3 & ChildSpeaks$total < 5)
ChildSpeaks[idx,"result"] <- "느림"
idx <- which(ChildSpeaks$total >= 5 & ChildSpeaks$total < 7)
ChildSpeaks[idx,"result"] <- "보통"
idx <- which(ChildSpeaks$total >= 7 & ChildSpeaks$total < 9)
ChildSpeaks[idx,"result"] <- "빠름"
idx <- which(ChildSpeaks$total >= 9)
ChildSpeaks[idx,"result"] <- "매우빠름"
ChildSpeaks
#total 값이 가장 높은 아기의 정보 조회하기
which.max(ChildSpeaks$total)
ChildSpeaks[which.max(ChildSpeaks$total),]

#########
#  막대그래프 : barplot
f <- c("WINTER","SUMMER","SPRING","SUMMER","SUMMER","FALL","FALL","SUMMER","SPRING","SPRING")
ds <- table(f)
ds
barplot(ds, main="favorite season")
#색상추가
barplot(ds, main="favorite season", col='blue')
barplot(ds, main="favorite season", col=c("blue","red","green","yellow"))
barplot(ds, main="favorite season", col=rainbow(4))

#x,y축 설명
barplot(ds, main="favorite season", col=rainbow(4),xlab="계절",ylab="빈도수")
#수평막대그래프
barplot(ds, main="favorite season", col=rainbow(4),xlab="계절",ylab="빈도수",horiz=TRUE)
#이름 변경하기
barplot(ds, main="favorite season", 
        col=rainbow(4),xlab="계절",ylab="빈도수",
        horiz=TRUE, names=c("F","SP","SU","W"),las=1)
#x축의 이름 표시 방향
# las=0 : 기본값.  축방향
# las=1 : 수평방향. 가로
# las=2 : 수직방향. 세로

#히스토그램 : hist() 자료의 분포를 시각화
head(cars)
str(cars)
dist <- cars[,2]
dist
hist(dist)
hist(dist,breaks=12) #breaks:구간 분리 갯수 
hist(dist,breaks=5)

h <- hist(dist, main="Histogram for 제동거리",
          xlab="제동거리",ylab="빈도수",
          border="blue",col="green",las=2,breaks=12)
h
h$breaks #구간 값
h$counts #y축의값. 빈도수값.
h$density #구간별 밀도값
h$mids    #구간의 중간값값 
h$xname   #데이터의 이름
h$equidist #그래프 간격이 일정한지 여부 
freq <- h$counts
freq
names(freq) <- h$breaks[-1] #첫번째 요소 제외
freq
#히스토그램에 문자데이터 출력하기
#text(x좌표, y좌표,표시할값,정렬방식식)
#adj=c(0.5,-0.5) ㅣ -1 ~ 1 사이값 => 글자가 출력될 위치 
#    0 : 오른쪽정렬 0.5:가운데정렬, 1:왼쪽정렬 
#    0 : 위쪽 0.5:가운데, 1:아래쪽 
text(h$mids,h$counts,labels=h$counts, adj=c(0.5,0.5))

## 다이아몬드 시세를 히스토그램으로 표시하기
data("Diamonds")
str(Diamonds)
Diamonds$PricePerCt  #캐럿당 가격
#캐럿당 가격을 히스토그램으로 출력하기
color <- rep('#a8dadc',9)
color[3]<-'blue'
hist(Diamonds$PricePerCt,main='캐럿당 가격 분포',
     xlab='캐럿당가격', ylab='빈도수', col=color)

## 하나의 화면에 여러개의 그래프 출력하기
# mfrow=c(2,2) : plot을 2행 2열로 분리하기. 4개의 그래프 출력
# mar=c(3,3,4,2) : margin. 여백 주기
#                  bottom,left,top, right
par(mfrow=c(2,2),mar=c(3,3,4,2))
#1. 히스토그램. 
hist(iris$Sepal.Length,main='Sepal.Length',col='orange')
#2. 막대그래프
barplot(table(mtcars$cyl),main='mtcars',col=c('red','green','blue'))
#3. 막대그래프
#rainbow 파렛트 : 색상을 모아놓은 객체
#rainbow(30)
barplot(table(mtcars$gear),main='mtcars',col=rainbow(3))
#4. 파이그래프
# topo.colors 파렛트 
#topo.colors(30)
#radius=0.8 : 반지름
#radius=2 : 반지름을 2배로로
pie(table(mtcars$cyl),main='mtcars',col=topo.colors(3),radius=0.8)
str(mtcars)

#### 3D 그래프.
f <- c('w','su','sp','su','su','f','f','su','sp','sp')
ds <- table(f) #도수분포.
ds
install.packages('plotrix') #
library(plotrix)
#labelcex=1 : 출력 글자의 크기 
#explode=0.1 : 부채꼴사이의 간격
pie3D(ds,main='선호계절', labels=names(ds),labelcex=1,explode=0,
      col=rainbow(4))

# plot : 선그래프
# plot(x축데이터,y축데이터)
# type="o" : 선의 형태 (l,b,s,o)
# lty=6 : 선의종류 .  1(실선),2(댓쉬선),3(점선)
# lwd=2 : 선의 굵기
month <- 1:12
late <- c(5,8,7,9,4,6,12,13,8,6,6,4)
plot(month,late,type="o",lty=3,lwd=1,xlab="Month",ylab="Late cnt")
# boxplot : 상자그래프
hist(cars$dist)
boxplot(cars$dist,main="제동거리")
str(cars)
# boxplot의 수치정보
boxplot.stats(cars$dist)
# stats : 2 26 36 56 93
#      2 : 최소값
#     26 : Q1. 1사분위값. 25%해당하는 값 
#     36 : Q2. 중간값. 50%해당하는 값 
#     56 : Q3. 3사분위값. 75%해당하는 값 
#     93 : 최대값. 특이값 제외.
# n  : 관측값의 갯수
# conf : 중간값에 대한 신뢰구간
# out  : 특이값
max(cars$dist)

#그룹이 있는 boxplot 
boxplot(iris$Petal.Length,
        main='꽃잎의 길이',
        col='green')

boxplot(Petal.Length~Species,data=iris,
        main='품종별 꽃잎의 길이',
        col=c('green','yellow','blue'))

boxplot(Petal.Width~Species,data=iris,
        main='품종별 꽃잎의 넓이',
        col=c('green','yellow','blue'))

boxplot(iris$Petal.Length~iris$Species,
        main='품종별 꽃잎의 길이',
        col=c('green','yellow','blue'))

#mtcars 데이터의 mpg값을 상자그래프로 출력하기
boxplot(mtcars$mpg)
boxplot.stats(mtcars$mpg)
#기어수(gear) 에 따른 자동차들의 연비 값을 상자그래프로 출력
#기어수의 값의 종류 출력하기
levels(factor(mtcars$gear))
str(mtcars)
boxplot(mtcars$mpg~mtcars$gear,
        main='기어별 연비', xlab="기어수",ylab='연비', col=rainbow(3))
#gear==4인 데이터의 연비를 상자 그래프 출력하기
boxplot(mtcars$mpg[which(mtcars$gear==4)],main='4기어의 연비',
        ylab='연비', col="blue")
boxplot.stats(mtcars$mpg[which(mtcars$gear==4)])

#am(변속기의 종류) 값에 따른 연비를 상자그래프로 출력하기
levels(factor(mtcars$am)) #0,1

boxplot(mtcars$mpg~mtcars$am,
        main='변속기종류별 연비', 
        xlab="변속기",ylab='연비', col=rainbow(2))

#중량(wt)이 평균이상인 그룹(high)과 미만인 그룹(low)으로 모델을 나눠
# grp 데이터 저장
# 엔진의힘(hp)의 분포 출력하기
str(mtcars)
grp <- rep('high',nrow(mtcars)) #벡터 생성. 
grp
grp[mtcars$wt < mean(mtcars$wt)] <- 'low'
grp
boxplot(mtcars$hp~grp)  #중량별 엔진의 힘 박스그래프로 출력

#중량(wt)이 평균이상인 그룹(high)과 미만인 그룹(low)으로 모델을 나눠
# 연비(mpg)의 분포 출력하기
boxplot(mtcars$mpg~grp)

# 1. mtcars 데이터셋에서 mpg, hp, wt 세 개의 열에 대한 각각의 평균을 구하려 한다. 
# apply() 함수를 사용하여 코드를 작성하시오.
str(mtcars)
apply(mtcars[c('mpg', 'hp', 'wt')], 2, mean)
apply(mtcars[c(1, 4, 6)], 2, mean)
colMeans(mtcars[c('mpg', 'hp', 'wt')])
colMeans(mtcars[c(1,4,6)])

# 2. R에 기본 내장된 USArrests 데이터셋은 1973년 미국 50개 주에서 발생한 강력 범죄에 대한 기록이
# 다. 구체적으로 각 주를 관측값으로 하여 각 열에 인구 10만명 당 살인(Murder), 폭행(Assault), 강간
# (Rape)에 대한 체포건수를 저장하고 있다.
# (1) 살인, 폭행, 강간 범죄에 대한 체포건수의 합을 각각 구하시오.
str(USArrests)
apply(USArrests[c('Murder', 'Assault', 'Rape')], 2, sum)
colSums(USArrests[c('Murder', 'Assault', 'Rape')])
# (2) 살인, 폭행, 강간 범죄에 대한 체포건수의 평균을 각각 구하시오.
apply(USArrests[c('Murder', 'Assault', 'Rape')], 2, mean)
colMeans(USArrests[c('Murder', 'Assault', 'Rape')])
# (3) 살인 범죄 체포가 가장 많이 발생한 주는 어디인지 구하시오.
max(USArrests$Murder)
subset(USArrests,USArrests$Murder==max(USArrests$Murder))
rownames(subset(USArrests,USArrests$Murder==max(USArrests$Murder)))
which.max(USArrests$Murder)
USArrests[which.max(USArrests$Murder),]
rownames(USArrests[which.max(USArrests$Murder),])
rownames(USArrests)[which.max(USArrests$Murder)]
USArrests[which.max(USArrests$Murder),]

# (4) 폭행 범죄 체포가 가장 적게 발생한 주의 살인 범죄 체포건수를 구하시오.
subset(USArrests,USArrests$Assault==min(USArrests$Assault))
subset(USArrests,USArrests$Assault==min(USArrests$Assault))[,1]
rownames(subset(USArrests,USArrests$Assault==min(USArrests$Assault))) #최소 발생 주의 이름
#whitch 함수
USArrests[which.min(USArrests$Assault),]
USArrests[which.min(USArrests$Assault),'Murder']
USArrests[which.min(USArrests$Assault),1]
USArrests$Murder[which.min(USArrests$Assault)]

# 3. R에 기본 내장된 sleep 데이터셋의 컬럼의 설명은 다음과 같다
#   extra : 수면 시간의 증가량
#   group : 사용한 약물의 종류
#   ID : 환자 식별 번호
# 
#   제목 : '수면증가량히스토그램', x축:증가량, y:빈도수, 막대수 4를 가진 
# 히스토그램을 작성하기
sleep$extra
h <- hist(sleep$extra,
          main = '수면증가량히스토그램',
          xlab = '증가량',ylab="빈도수",
          breaks = 4)
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))
h$counts
