###### 산점도 : 두변수 사이의 관계파악에 사용되는 그래프
str(mtcars)
#mtcars$wt : 자동차 무게 데이터, x축
#mtcars$mpg : 자동차 연비 데이터, y축
#pch=19 : 점의 모양. 1~25
plot(mtcars$wt,mtcars$mpg, main='중량-연비 그래프',
     xlab='중량',ylab='연비(mpg)',
     col='red', pch=25)

#여러 변수들간의 산점도
vars <- c("mpg","disp","drat","wt")
target <- mtcars[vars]
plot(target,main="여러변수들간의 산점도",pch=20)

#그룹 정보가 있는 2개의 변수
str(iris)
iris2 <- iris[,3:4]
iris2
levels(iris$Species)
group <- as.numeric(iris$Species) #종류를 숫자형태 변경. 1,2,3
group
color <- c("red","green","blue")
plot(iris2,main="품종별꽃입의 길이와 넓이",pch=c(group),col=color[group])
#범례
#x="bottomright" : 범례가 그래프에서 출력되는 위치. 
legend(x="bottomright",legend=levels(iris$Species),col=color,pch=c(1:3))
legend(x="top",legend=levels(iris$Species),col=color,pch=c(1:3))
legend(x="topleft",legend=levels(iris$Species),col=color,pch=c(1:3))

# 자동차 선팅 데이터를 산점도로 표시
install.packages("DAAG")
library(DAAG)
str(tinting)
#it : 식별시간, csoa : 문자 인식 시간
plot(tinting$it,tinting$csoa)
#it : 식별시간, csoa : 문자 인식 시간, tint:선팅정도
tinting$tint
group <- as.numeric(tinting$tint)
group
plot(tinting$it,tinting$csoa,pch=c(group),col=color[group])
legend(x="bottomright",legend=levels(tinting$tint),
       col=color,pch=c(1:3))


#it : 식별시간, csoa : 문자 인식 시간, agegp:연령대
tinting$agegp
group <- as.numeric(tinting$agegp)
group
plot(tinting$it,tinting$csoa,pch=c(group),col=color[group])
legend(x='bottomright',legend=levels(tinting$agegp),
       col=color,pch=c(1:2))

###########################
# 
getwd()
setwd("d:/20230717/R/data")
ds <- read.csv("seoul_temp_2017.csv")
ds
boxplot(ds$avg_temp,col="green",ylim=c(-20,40),xlab='서울1년기온',
        ylab="평균기온")
summary(ds$avg_temp)
#월별 평균 온도
#aggregate(원본데이터,by=그룹데이터,적용함수)
ds$month
list(ds$month)
month.avg <- aggregate(ds$avg_temp,by=list(ds$month),mean)
month.avg <- month.avg[,2] #온도 평균 값 
month.avg
names(month.avg) <- 1:12
month.avg
#평균 기온을 내림차순 정렬시 순위 (높은 온도: 1)
ord <- rank(-month.avg) #내림차순 정렬하여 순위
ord #평균 온도가 높은 순서
heat.colors(12)
boxplot(avg_temp~month, data=ds,col=heat.colors(12)[ord],
        ylim=c(-20,40),ylab="기온",xlab="월",
        main="서울시 월별 기온 분포(2017)")
# 월별 오존 농동
airquality
str(airquality)
#월별 평균 오존 농도 계산.
month.avg <- aggregate(airquality$Ozone,
                       by=list(airquality$Month),mean)
month.avg #결과가 NA임 => 결측값과 연산시 결과는 결측값.
#airquality 에서 결측값을 제거하기.
complete.cases(airquality) #TRUE:결측값없음, FALSE:결측값있음
ds <- airquality[complete.cases(airquality),]
str(ds)
month.avg <- aggregate(ds$Ozone,by=list(ds$Month),mean)
month.avg
month.avg <- month.avg[,2] #평균값만 벡터 데이터로 저장
unique(ds$Month) #ds$Month 데이터의 내용을 중복없이 한개만 조회
names(month.avg) <- unique(ds$Month)
month.avg
#오존 농도의 순위를 내림차순으로 정렬하여 순위값 조회
ord <- rank(-month.avg)
ord
# 오존 농도를 월별 박스그래프로 작성
boxplot(Ozone~Month, data=ds, col=heat.colors(5)[ord],
            ylim=c(0,170),ylab="오존농도",xlab="월",
            main='월별 오존농도')

#ggplot 패키지를 위한 시각화
install.packages("ggplot2")
library(ggplot2)
# geom_histogram : 히스토그램 그래프 출력
# 꽃잎의 길이를 히스토그램으로 출력
ggplot(iris,aes(x=Petal.Length)) + geom_histogram()
# 데이터 간격
ggplot(iris,aes(x=Petal.Length)) + geom_histogram(binwidth = 0.5)
#품종 정보로 꽃받침의 폭을 히스토그램으로 출력
#position='dodge' : 막대를 품종별로 분리
ggplot(iris,aes(x=Sepal.Width, fill=Species,color=Species)) +
  geom_histogram(binwidth = 0.5,position='dodge') +
  theme(legend.position = 'top') #범례의 위치 
ggplot(iris,aes(x=Sepal.Width, fill=Species,color=Species)) +
  geom_histogram(binwidth = 0.5) +
  theme(legend.position = 'top')

#geom_point() : 산점도 그래프 작성
ggplot(data=iris,aes(x=Petal.Length, y=Petal.Width)) +
  geom_point(size=2)  #size=2 : 점의 크기

#품종별로 다른 색상 지정하기
ggplot(data=iris,aes(x=Petal.Length, y=Petal.Width,color=Species)) +
  geom_point(size=2)  #size=2 : 점의 크기
#title 지정하기
ggplot(data=iris,aes(x=Petal.Length, y=Petal.Width,color=Species)) +
  geom_point(size=2) +
  ggtitle("iris 꽃잎의 길이와 폭") +
  theme(plot.title=element_text(size=20,face="bold",colour="steelblue"))

#geom_boxplot : 상자 그래프
ggplot(data=iris,aes(y=Petal.Length)) +
  geom_boxplot(fill='yellow')

#품종별 꽃잎의 길이를 상자 그래프로 출력하기
ggplot(data=iris,aes(x=Species,y=Petal.Length,fill=Species)) +
  geom_boxplot()

#geom_line() : 선그래프
airmiles   #1937 ~ 1960년 까지 항공기 승객들의 이동거리 통계
str(airmiles)
year <- 1937:1960
cnt <- as.vector(airmiles)
df <- data.frame(year,cnt)
df
ggplot(data=df,aes(x=year,y=cnt)) + geom_line(col="red")

#geom_bar() : 막대그래프
#airquality 데이터
# Ozone : 오존양
# Solar.R : 일조량
# Wind : 풍속
# Temp : 기온
# Month : 월
# Day : 일
# 월별 평균기온을 막대그래프로 출력하기
#1. 월별 평균기온
airquality$Temp
df <- aggregate(airquality$Temp, by=list(airquality$Month),mean)
df <- aggregate(airquality$Temp, by=list(month=airquality$Month),mean)
df
month
#막대그래프 작성
#stat="identity" : 데이터기반으로 출력. 필수 입력
ggplot(df,aes(x=month,y=x)) + 
  geom_bar(stat="identity", width=0.9,fill="green")

ggplot(df,aes(x=month,y=x)) + 
  geom_bar(stat="identity", width=0.9)

#월별 오존 농도를 상자그래프로 작성하기
#결측값의 존재를 경고.
#그룹된 해당하는 데이터는 factor형이어야함
ggplot(data=airquality,
     aes(x=factor(Month),y=Ozone,fill=factor(Month))) +
     geom_boxplot()

#결측값 제거
df <- airquality[complete.cases(airquality),]
df
ggplot(data=df,
       aes(x=factor(Month),y=Ozone,fill=factor(Month))) +
  geom_boxplot()

df
#기온과 오존 농도를 산점도 출력하기
ggplot(data=df, aes(x=Temp, y=Ozone)) +
  geom_point(size=3,color='orange')
ggplot(data=df, aes(x=Temp, y=Ozone,colour="orange")) +
  geom_point(size=3)

#7월의 일별 오존 농도를 선그래프로 출력하기
# 7월의 데이터만 df7에 저장하기
#df7=df[which(df$Month==7),]
#df7 <- subset(df, Month==7)
df7=df[df$Month==7,]
df7
str(df7)
unique(df7$Month)
unique(df7$Day)
ggplot(data=df7,aes(x=Day,y=Ozone)) + 
  geom_line(col="red")
ggplot(data=subset(df, Month==7),aes(x=Day,y=Ozone)) + 
  geom_line(col="red")
ggplot(data=df[df$Month==7,],aes(x=Day,y=Ozone)) + 
  geom_line(col="red")

#carData 패키지에 UN98 데이터셋 분석
install.packages("carData")
library(carData)
summary(UN98)
str(UN98)
#region : 대륙
#tfr : 출산율
unique(UN98$region)
unique(UN98$tfr)
#대륙별 평균출산율을 막대그래프로 출력하기
#대륙,출산율 컬럼만을 가진 df 데이터를 생성하기
df <- UN98[c('region','tfr')]
df
str(df)
#df 데이터에서 결측값 제거하기
df <- df[complete.cases(df),]
df
str(df)
#대륙별 출산율 평균 구하기
df <- aggregate(df$tfr,by=list(region=df$region),mean)
df
#df 데이터를 막대그래프로 출력하기
ggplot(data=df,aes(x=region,y=x)) +
  geom_bar(stat="identity",width=0.7,fill=rainbow(5))

str(UN98)
#남성교육수준:educationMale
#여성교육수준:educationFeMale
#남성의 교육수준과 남성의 교육 수준을 산점도 출력하기
#대륙별로 다른 색상으로 처리한다.
df <- UN98[c('region',"educationMale","educationFemale")]
str(df)
#df 데이터에서 결측값 제거
df <- df[complete.cases(df),]
str(df)
ggplot(data=df,
  aes(x=educationMale,y=educationFemale,color=region)) +
  geom_point(size=2)

install.packages("treemap")
library(treemap) 		# treemap 패키지 불러오기
data(GNI2014)
head(GNI2014)
str(GNI2014)
treemap(GNI2014,                      # 데이터셋
        index=c('continent','iso3'),
        vSize='population',   #사각형의 크기. 인구수.
        vColor='GNI',         #색상. 국민총생산.
        type='value',
        title="World's GNI"
)

st <- data.frame(state.x77)
str(st)
head(st)
# 주의 이름을 stname 컬럼으로 추가하기
st <- data.frame(st,stname=rownames(st))
str(st)

# st 데이터셋을 이용하여 나무지도 출력하기
treemap(st, index=c('stname'),
        vSize='Area',vColor='Income', type='value',
        title='USA area and income')

######### 방사형 그래프 #########
install.packages("fmsb")
library(fmsb)
score <- c(80,60,95,85,40)
maxscore <- rep(100,5)
minscore <- rep(0,5)
df <- rbind(maxscore,minscore,score)
df
df <- data.frame(df)
colnames(df) <- c("국어","영어","수학","물리","음악")
df
radarchart(df) #방사형 그래프
#rgb(0.2,0.5,0.5,0.3) : red(0.2),green(0.5),blue(0.5),
#                       투명도(1:불투명,0:투명) 
radarchart(df,
           pcol='dark green',  #다각형의 윤곽선
           pfcol=rgb(0.2,0.5,0.5,0.3), #다각형 내부의 색 
           cglcol="grey", #거미줄의 색
           cglwd=0.8,    #거미줄의 두께
           axistype=4,   
           seg=4,        #거미줄 구간의 갯수
           axislabcol="grey", #글자색지정
           caxislabels = seq(0,100,25)) #글자의 값

#WVS : 국민들의 종교, 학위 데이터
library(carData)
WVS
str(WVS)
#국가별로 종교가 있다고 응답한 사람의 비율 구하기
#religion
WVS$religion
#응답한 국가의 인원수 조회하기
unique(WVS$country)
pop <- table(WVS$country)
pop
#국가별 종교가 있는 응답자를 조회하여 tmp 변수에 저장
tmp <- WVS[WVS$religion == 'yes',]
tmp
tmp <- subset(WVS,religion=='yes')
tmp
str(tmp)
#국가별 종교가 있는 응답자 수
rel <- table(tmp$country)
rel
stat <- rel/pop
stat
#방사형그래프로 출력하기
maxstat <- rep(1,4)
minstat <- rep(0,4)
ds <- rbind(maxstat,minstat,stat)
ds
df <- data.frame(ds)
df
radarchart(df)
radarchart(df,
           pcol='dark green',  #다각형의 윤곽선
           pfcol=rgb(0.2,0.5,0.5,0.3), #다각형 내부의 색 
           plwd=1,     #다각형 윤관선 두께
           cglcol="grey", #거미줄의 색
           cglwd=0.8,    #거미줄의 두께
           axistype=4,   
           seg=5,        #거미줄 구간의 갯수
           axislabcol="grey", #글자색지정
           caxislabels = seq(0,1,0.2),
           title="국가별 종교인 비율") #글자의 값

###################################################
# 데이터 전처리 : 결측값
# 벡터 데이터의 결측값
z <- c(1,2,3,NA,5,NA,8)
z
#1. 결측값의 갯수 출력하기
is.na(z)   #결측값인 경우 TRUE
!is.na(z)   #정상값인 경우 TRUE
sum(is.na(z))  #결측값의 갯수
sum(!is.na(z))  #정상값의 갯수
#1. 결측값의 다른 값으로 치환. NA->0
z1 <- z
z1[is.na(z)] = 0
z1
z
#2. 결측값을 제거.
z2 <- na.omit(z) #z데이터에서 결측값을 제거.
z2 <- as.vector(z2) #z2 객체를 벡터객체로 변환
z2 <- as.vector(na.omit(z))
z2

#매트릭스나 데이터프레임의 결측값 처리
x <- iris
x
x[1,2] <- NA
x[1,3] <- NA
x[2,3] <- NA
x[3,4] <- NA
head(x)

#x 데이터의 결측값을 갯수 조회하기
#열별 결측값의 갯수
#ncol(x) : x데이터의 컬럼의 갯수. 변수의 갯수
#sum(na) : na 테이터중 TRUE인 갯수
for(i in 1:ncol(x)) {
  na <- is.na(x[,i]) #컬럼중 NA값:TRUE, 정상값:FALSE
  cat(colnames(x)[i],'\t',sum(na),'\n')
}
is.na(x[,2]) #2번째 컬럼의 결측값 조회
#apply 함수를 이용하기
cnt_na <- function(y) { #y : x데이터의 컬럼의 값
  return (sum(is.na(y)))
}
na.cnt <- apply(x,2,cnt_na) #apply(데이터,2(열),적용함수)
na.cnt

#colSums 함수이용하기
na.cnt <- colSums(is.na(x))
na.cnt

#행별 결측값의 갯수 조회하기
na.cnt <- rowSums(is.na(x))  #행별 결측값의 갯수
na.cnt

na.cnt <- sum(rowSums(is.na(x)) > 0) #결측값을 가지고 있는 행의 갯수
na.cnt

#x 데이터에서 전체 결측값의 갯수
sum(is.na(x))

#x 데이터의 결측값을 0으로 치환하기
x[is.na(x)] <- 0
head(x)

x <- iris
x[1,2] <- NA  #정상데이터를 결측값으로 치환
x[1,3] <- NA
x[2,3] <- NA
x[3,4] <- NA
head(x)

#x 데이터에서 결측값을 가진 행만 y 데이터에 저장
# complete.cases() : NA값이 포함된 행은 제외하고 정상적인 데이터만 리턴 
complete.cases(x) #NA 포함된 행:FALSE, NA가 없는 행:TRUE 
y<-x[complete.cases(x),] #정상데이터만으로 이루어진 행만 y에 저장
y
y<-x[!complete.cases(x),] #NA 데이터를 포함하는 행만 y에 저장
y

#결측값을 제거하기
y<-x[complete.cases(x),] #결측값을 가진 행을 제외한 데이터만 리턴

# UN 데이터 분석하기
library(carData)
str(UN)
#1. 열별로 NA값의 갯수 출력하기
for(i in 1:ncol(UN)) {
  cat(colnames(UN)[i],'\t',sum(is.na(UN[,i])),'\n')
}
apply(UN,2,cnt_na)
colSums(is.na(UN))
#2. lifeExpF(여성수명)의 평균 조회하기
#na.rm=T : NA제외
mean(UN$lifeExpF)  #결과는 NA. 결측값이 존재하면 결과는 NA
mean(UN$lifeExpF,na.rm=T)
mean((UN$lifeExpF[!is.na(UN$lifeExpF)]))

#3. 아시아지역(region:지역)의 출산율(fertility)의 평균 조회하기
mean(UN[UN$region=='Asia',"fertility"],na.rm=T)

#아시아지역만 tmp 데이터 저장
tmp <- subset(UN,region=='Asia')
tmp <- UN[UN$region=='Asia',]
tmp 
mean(tmp$fertility,na.rm=T)
mean(subset(UN,region=='Asia')$fertility,na.rm=T)
mean(UN[UN$region=='Asia',]$fertility,na.rm=T)

#도시지역(pctUrban) 평균과 영아사망율(infantMortality) 평균 조회하기
mean(UN$pctUrban,na.rm=T) #도시지역 평균
mean(UN$infantMortality,na.rm=T) #영아사망율 평균
cat(mean(UN$pctUrban,na.rm=T),mean(UN$infantMortality,na.rm=T))
avg2 <- union(mean(UN$pctUrban,na.rm=T),mean(UN$infantMortality,na.rm=T))
avg2
colMeans(UN[c("pctUrban","infantMortality")],na.rm=T)
tmp <- UN[,c("pctUrban","infantMortality")]
tmp
colMeans(tmp,na.rm=T)  #평균 = 합/갯수. NA : 값은 없음. 자리수 존재.
colMeans(tmp[complete.cases(tmp),]) #평균값 달라질 수 있음. 레코드가 없어짐 
#############################################
library(carData)
CES11  #2011년도 캐나다 선거 통계 데이터
nrow(CES11)
#abortion(낙태금지)에 대한 찬성/반대 비율 조회하기
unique(CES11$abortion)
table(CES11$abortion)/nrow(CES11)
#abortion(낙태금지)에 대한 성별(gender)별 찬성/반대 비율 조회하기
table(CES11$abortion[CES11$gender=='Female'])
table(CES11$abortion[CES11$gender=='Male'])

table(CES11$abortion[CES11$gender=='Female'])/nrow(CES11[CES11$gender=='Female',])
table(CES11$abortion[CES11$gender=='Male'])/nrow(CES11[CES11$gender=='Male',])

#aggregate 함수를 이용하기
agg <- aggregate(CES11$abortion,by=list(성별=CES11$gender),FUN=table)
agg
ncol(agg)
agg2 <- agg[,2]
agg2
sum(agg2[1,]) #여성의 인원수
sum(agg2[2,]) #남성의 인원수
agg2[1,] <- agg2[1,]/sum(agg2[1,])
agg2[2,] <- agg2[2,]/sum(agg2[2,])
agg2
rownames(agg2) <- agg[,1]
agg2
#낙태금지(abortion)에 도시지역(urban),비도시지역(rural) 의 찬성/반대 비율 조회하기\
unique(CES11$urban)
agg <- aggregate(CES11$abortion,by=list(지역=CES11$urban),FUN=table)
agg
ncol(agg)
agg2 <- agg[,2]
agg2
agg2[1,] <- agg2[1,]/sum(agg2[1,]) #  NO/YES rural인원수/rural인원수
agg2[2,] <- agg2[2,]/sum(agg2[2,]) #  NO/YES urban인원수/urban인원수
rownames(agg2) <- agg[,1]
agg2







########################## 문제######################
### 1. 호주의 사회복지 서비스와 만족도 분석  ===
str(socsupport)
# (1). 연령별 비율을 3차원 파이그래프로 출력하기
unique(socsupport$age)
library(plotrix)  
pie3D()
# (2). 정서적지원제도(emotional)분포를  호주와 아닌지역(country)으로 구분하여
#   상자그래프로 작성하기


# (3). 정서적지원제도(emotional)분포를성별(gender)으로 구분하여
#   상자그래프로 작성하기


# (4). 정서적지원제도(emotional)분포를 연령대별(age)으로 구분하여
#   상자그래프로 작성하기


# 5. 정서적지원제도(emotional) 만족도 물질적 지원제도(tangiblesat),연령대(age)
# 에 대해 산점도를 작성하되 성별에 따라 점의 모양과 색을 다르게 처리하기

########################## 문제######################
###  호주의 사회복지 서비스와 만족도 분석  ===
str(socsupport)
# 1. 연령별 비율을 3차원 파이그래프로 출력하기
library(plotrix)
ds <- table(socsupport$age)
ds
pie3D(ds, main='연령 분포',
      labels=names(ds), 
      height=0.2,     # 파이 높이
      labelcex=0.7,    #글자크기
      explode=0.1,     #파이간격
      col=rainbow(length(ds)))
legend(x='top',legend=names(ds), 
       fill=rainbow(length(ds)),cex=0.7)

# 2. 정서적지원제도(emotional)분포를 호주와 아닌지역(country)으로 구분하여
#   상자그래프로 작성하기
socsupport$emotional
boxplot(socsupport$emotional~socsupport$country,
        main='정서적 지원 제도 비교',col=rainbow(2))

ggplot(data=socsupport,
    aes(x=factor(country),y=emotional,fill=factor(country))) +
  geom_boxplot()


# 3. 정서적지원제도(emotional)분포를 
#    성별(gender)으로 구분하여
#   상자그래프로 작성하기

boxplot(socsupport$emotional~socsupport$gender,
        main='정서적 지원 제도 비교',col=rainbow(2))

ggplot(data=socsupport,
   aes(x=factor(gender),y=emotional,fill=factor(gender))) +
  geom_boxplot()


# 4. 정서적지원제도(emotional)분포를 
#    연령대별(age)으로 구분하여
#   상자그래프로 작성하기
unique(socsupport$age)
str(socsupport)
boxplot(socsupport$emotional~socsupport$age,
        main='정서적 지원 제도 비교',col=rainbow(5))
ggplot(data=socsupport,
         aes(x=factor(age),y=emotional,fill=factor(age))) +
    geom_boxplot()
  
# 5. 정서적지원제도(emotional) 만족도 물질적 지원제도(tangiblesat),연령대(age)
# 에 대해 산점도를 작성하되 성별에 따라 점의 모양과 색을 다르게 처리하기

group <- as.numeric(socsupport$gender)
group
data <- socsupport[,c('emotional','tangiblesat','age')]
data
color <- c('red','blue') #여:red, 남:blue
plot(data,pch=group,col=color[group])

