install.packages('wordcloud')
library(KoNLP)
library(wordcloud)
library(RColorBrewer)
#1. KoNLP.zip 파일 다운받아 압축 풀기
#2. 압축된 KoNLP 폴더를 복사하기
.libPaths()
#3. C:\Program Files\R\R-4.3.1\library 경로에 KoNLP 붙여넣기
################################################################ 설치 실패

#JAVA package 필요(JAVA_HOME 환경변수 설정)
#엑셀파일 읽기
#install.packages("xlsx") #엑셀파일을 위한 패키지 설정.
# JAVA_HOME 설치하기
#    브라우저에서 https://jdk.java.net/java-se-ri/17 페이지 열기
#    Windows 10 x64 Java Development Kit (sha256) 178 MB 다운받기
#     => openjdk-17+35_windows-x64_bin.zip 압축풀기
#     => 압축푼 파일의 jdk-17 절대 경로 복사하기 : D:\setup\jdk-17
#    설정 => 시스템 환경변수 => 시스템 부분에서 새로만들기 버튼 클릭
#    JAVA_HOME, D:\setup\jdk-17 => 설정
#    Path 선택=> 변경 => D:\setup\jdk-17\bin 저장 하고 나오기
#    RStudio 다시 실행하기

install.packages('remotes')
library(remotes)
remotes::install_github('haven-jeon/KoNLP', upgrade='never', INSTALL_opts=c('--no-multiarch'), force = TRUE)
library(KoNLP)
install.packages('multilinguer')
library(multilinguer)
install_jdk()
install.packages(c('stringr','hash','tau','Sejong','RSQLite','devtools'), type='binary')
install.packages(('https://cran.r-project.org/src/contrib/Archive/KoNLP.KoNLP_0.80.2.tar.gz'))
#java.zip 파일의 내부 파일을 모두 복사하여 $JAVA_HOME_lib 폴더에 붙여넣기
library(KoNLP)
buildDictionary(ext_dic='woorimalsam') #'우리말씀' 한글사전 로딩 => 형태소 분석 사용 사전 e.g.) '아버지 가방에'(x), '가'는 조사로 인식해야 함('아버지가 방에'(o))

setwd('D:/R/data') #mis_document.txt를 읽기 위해 파일의 위치로 경로 설정
text <- readLines('mis_document.txt', encoding = 'UTF-8') #비정형 한글 문서 cf) csv => ,를 기준으로 정형 데이터
text
#apply: 벡터에서 함수 적용하는 함수
#sapply(문자열, 함수명, 옵션)
noun <- sapply(text, extractNoun, USE.NAMES = F) #text 데이터에서 명사 추출, USE.NAMES(헤더이름)은 F(없음)
noun
warnings()
noun2 <- unlist(noun) #추출된 명사 통합
noun2
wordcount <- table(noun2) #단어 빈도수 추출
wordcount

#단어의 빈도수에 맞추어 높은 순으로 정렬
temp <- sort(wordcount, decreasing = T)
temp #공백=40, '등'=27, '불법'=27, ...

temp <- sort(wordcount, decreasing = T)[1:10] #빈도수가 가장 높은 단어 10개만 가져오자
temp

#공백을 없애 보자
temp <- temp[-1]
temp

#막대그래프로 만들어 보자
barplot(temp, manes.arg=names(temp), col='lightblue', main='빈도수 높은 단어', ylab='단어 빈도수')

#wordcloud(단어구름)
library(RColorBrewer)
library(wordcloud)
pal2 <- brewer.pal(8, 'Dark2') #색상표
wordcloud(names(wordcount), #출력할 단어들
          freq = wordcount, #단어들의 빈도수
          scale = c(6,0.7), #빈도수에 맞는 폰트 크기 (0.7 ~ 6)
          min.freq = 5,     #최소 빈도수 => 적어도 빈도수가 5이상으로 설정
          random.order = F, #출력 위치 => 가장 빈도수 높은 단어들이 가운데에 위치하도록 설정
          rot.per = .1,     #90도 회전하는 단어의 비율
          colors = pal2)    #단어들의 색상 설정

#단어들을 추려보자 
noun2

#1. '들', '등', '것' 등 글자 수가 1개인 단어 제거
length(noun2)
noun2 <- noun2[nchar(noun2) > 1] #글자수 1개인 단어 제거
length(noun2)
wordcount <- table(noun2)
wordcount

#2. 의미없는 단어 제거(문자)
#    gsub = replace
noun2 <- gsub('들이', '', noun2) #'들이'라는 단어 제거('들이'라는 단어를 없앰, but 자리는 그대로 남아 있기 때문에 별도 처리 필요)
noun2 <- gsub('경우', '', noun2) #'경우'라는 단어 제거
noun2 <- gsub('첫째', '', noun2) #'첫째'라는 단어 제거
#noun2 <- gsub("(--)'로", '', noun2)
#noun2 <- gsub('(野蠻)', '', noun2)
#noun2 <- gsub("(정보통신망법", '', noun2)
#noun2 <- gsub('(HSI)', '', noun2)
#noun2 <- gsub('(', '', noun2)
noun2 <- noun2[nchar(noun2) > 1] #글자 수가 1개 이하인 단어를 모두 제거

#3. 의미없는 단어 제거(숫자): 정규식 사용
noun2 <- gsub('[0-9]', '', noun2)
noun2 <- noun2[nchar(noun2) > 1] #글자 수가 1개 이하인 단어를 모두 제거
noun2

temp <- sort(wordcount, decreasing = T)
temp
#length(temp)


wordcloud(c(letters, LETTERS, 0:9), seq(1,1000, len=62))
#letters: 소문자 목록
#LETTERSL: 대문자 목록
#0:9: 0~9까지의 숫자
#c(letters, LETTERS, 0:9): 26+26+10 => 62가지 문자
#seq(1,1000,len=62): 1~1000까지의 숫자 62개로 나눔

#library(RColorBrewer)
palete <- brewer.pal(9, 'Set1')
palete
wordcloud(c(letters, LETTERS, 0:9), seq(1,1000, len=62), colors=palete)

#지도 시각화
install.packages('ggiraphExtra') #실제 지도 관련 패키지
install.packages('mapproj')      #'ggiraphExtra' 패키지가 사용하기 위해 필요한 패키지
library(ggiraphExtra)

#미국 주별 강력 범죄율
str(USArrests)
head(USArrests)
#USArrests 데이터의 주 이름은 행의 이름으로 설정되어 있는데 이것을 하나의 컬럼 데이터(state)로 변경해 보자
library(tibble)
crime <- rownames_to_column(USArrests, var='state') #crime이라는 data.frame에 USArrests 데이터의 주 이름을 state column으로 변경하여 저장
crime
library(ggplot2)
states_map <- map_data('state')
head(states_map)
nrow(states_map) #15537
#states_map 데이터의 정보와 crime 데이터의 위치 정보 일치 => crime 데이터의 첫 글자를 small letter로 변경해야 함
#tolower():소문자로 변경(전체 글자)
crime$state <- tolower(crime$state)
crime$state

#지도를 표시해 보자
ggChoropleth(data=crime,        #지도에 표시할 데이터
             aes(fill=Murder,   #표시할 컬럼값
                 map_id=state), #지역을 표시할 컬럼값(변수)
             map=states_map)    #지도 데이터, 위도 경도값

ggChoropleth(data=crime,        #지도에 표시할 데이터
             aes(fill=Murder,   #표시할 컬럼값
                 map_id=state), #지역을 표시할 컬럼값(변수)
             map=states_map,    #지도 데이터, 위도 경도값
             interactive = T)    

#한국 지도에서 표현해보자! => 미국 데이터와 마찬가지로 2가지 데이터 필요
install.packages('devtools')
devtools::install_github('cardiomoon/kormaps2014')
library(kormaps2014)
korpop1
str(korpop1)
head(korpop1)
ds <- korpop1
ds

library(dplyr)
library(ggiraphExtra)
library(mapproj)
library(ggplot2)

kormap1
str(kormap1)
#rename(바꿀이름=원래이름)
ds <- rename(ds, pop=총인구_명, name=행정구역별_읍면동)
str(ds)
ds
ggChoropleth(data = ds,
             aes(fill = pop,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)

#################################################################################
#시도별 결핵환자수를 지도로 표시하기
library(kormaps2014)  #한국 지도표기를 위한 패키지
library(ggiraphExtra) #지도 표기를 위한 패키지
library(ggplot2)
tbc #tbc$NewPts: 결핵환자 수

ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name1),
             map = kormap1,
             interactive = T)

#################################################################################
#인터렉티브 그래프 구현
install.packages('plotly')
library(plotly)
library(ggplot2)
mpg #자동차에 대한 데이터
#displ: 배기량
#hwy: (고속도로) 연비
#drv: 구동 방식, f=전륜, r=후륜, 4=4wd
ggplot(data = mpg,
       aes(x=displ,
           y=hwy,
           col=drv))+geom_point()

p <- ggplot(data = mpg,
            aes(x=displ,
                y=hwy,
                col=drv))+
  geom_point()
ggplotly(p)


str(diamonds)
p <- ggplot(data = diamonds,
            aes(x=cut,
                fill=clarity))+
          geom_bar(position = 'dodge')
ggplotly(p)

getwd() #"D:/R/data"
ranicafe <- read.csv('cafedata.csv')
ranicafe
str(ranicafe)
ranicafe$Coffees #판매한 수량

min(ranicafe$Coffees) #최소판매 수량
max(ranicafe$Coffees) #최대판매 수량
sort(ranicafe$Coffees)[1] # 최소 판매 수량
sort(ranicafe$Coffees, decreasing = T)[1] #최대판매 수량

#최빈값: 가장 많이 팔린 수량(가장 빈도수가 높은 수량)
rc = ranicafe$Coffees
wordcount <- table(rc)
wordcount #4잔이 4번으로 가장 많이 팔린 수량, 27잔과 31잔이 3번으로 그 다음
names(wordcount)[which.max(wordcount)]

#평균, 중앙값
mean(rc) #평균값, 21.51064
sum(rc)/nrow(ranicafe)
sum(rc)
length(rc)
median(rc) #중앙값, 23

#median()의 원리
m <- (length(rc)+1) %/% 2 #(47+1) / 2 =24
m
#요소의 갯수가 홀수: 정렬한 데이터의 가운데 값
rc.srt <- sort(rc) #정렬
rc.srt
rc.srt[24]
rc.srt[m] #중앙값

#요소의 갯수가 짝수: 정령한 데이터의 가운데 값이 2개, 가운데 값 2개의 평균
a <- c(1,2,3,4)
median(a)

#표준편차: 가운데 수(mean)와 다른 수의 차이의 제곱의 합의 제곱근
height <- c(164, 166, 168, 170, 172, 174, 176)

#평균
height.m <- mean(height)
height.m
height.dev <- (height - height.m) #평균값과의 차이
height.dev
height.dev <- height.dev^2 #제곱하여 음수 제거
height.dev
sum(height.dev) #차이의 제곱의 합
sum(height.dev)/6
mean(height.dev) #분산: 편차 제곱의 평균
sqrt(mean(height.dev)) #표준편차 #sqrt():제곱근 함수
#R 함수를 이용한 분산, 표준편차
var(height)
s <- sum(height.dev) / (length(height) - 1)
sd(height)
sqrt(s)

#사분위수: 25, 50, 75, 100%에 해당하는 값
qs <- quantile(rc) #1/4분위: 12, 2/4분위: 23, 3/4분위: 30, 4/4분위: 48
qs
print(qs[4] - qs[2]) #박스그래프의 상자의 높이, 3분위수 - 1분위수
IQR(rc)              #박스그래프의 상자의 높이,3분위수 - 1분위수

#################################################################################
#공기 오염 측정 데이터 분석하기
getwd()
file <- c('airkorea/2015년1분기.csv','airkorea/2015년2분기.csv','airkorea/2015년3분기.csv','airkorea/2015년4분기.csv',
          'airkorea/2016년 1분기.csv','airkorea/2016년 2분기.csv','airkorea/2016년 3분기.csv','airkorea/2016년 4분기.csv')
file

ds <- NULL #ds 데이터의 내용은 아무것도 없음
for(f in file){
  print(f)
  tmp <- read.csv(f, header=T, fileEncoding='CP949')
  ds <- rbind(ds, tmp)
}

ds
nrow(ds)
str(ds)
#ds$ 지역

#측정소 지역을 조회하자
unique(ds$지역)
str(unique(ds$지역))

names(ds) #ds 데이터의 컬럼명 // 변수명, 데이터 구분명
#측정소코드 => loc로 컬럼명 변경, 측정일시 => mdate로 컬럼명 변경
ds <- rename(ds, loc=측정소코드, mdate=측정일시)
ds
names(ds)

#대기오염 요소
#SO2: 아황산가스
#CO: 일산화탄소
#O3: 오존
#NO2: 이산화질소
#PM10: 미세먼지 10um 이하
#PM25: 초미세먼지 2.5um 이하

#해당 열(SO2)의 결측값 갯수 조회: SO2
sum(is.na(ds[5])) #SO2컬럼의 결측값 갯수, 266360
#해당 열의 결측값 비율: SO2
sum(is.na(ds[5])) / nrow(ds) #SO2컬럼의 결측값 비율, 0.04760648(약 5%)

#CO
sum(is.na(ds[6])) #272901
sum(is.na(ds[6])) / nrow(ds) #0.04877555

#O3
sum(is.na(ds[7])) #253541
sum(is.na(ds[7])) / nrow(ds) #0.04531534

#NO2
sum(is.na(ds[8])) #213350
sum(is.na(ds[8])) / nrow(ds) #0.03813201\

#PM10
sum(is.na(ds[9])) #436812
sum(is.na(ds[9])) / nrow(ds) #0.07807133

#PM25
sum(is.na(ds[10])) #3232418
sum(is.na(ds[10])) / nrow(ds) #0.5777295

for(i in 5:10){
  cat(names(ds)[i], sum(is.na(ds[i])),
      sum(is.na(ds[i]))/nrow(ds), '\n')
}

#PM25 컬럼의 결측값 비율이 0.5777295 정도 => 결측값이 너무 많음
#PM25 컬럼은 제외하자
ds <- ds[,-10]
str(ds)

#mdate 컬럼으로 연, 월, 시 정보 추가
#ds$year 컬럼 추가: mdate 컬럼에서 연도 부분만 추출해서 저장  
#ds$month 컬럼 추가: mdate 컬럼에서 월 부분만 추출해서 저장
#ds$hour 컬럼 추가: madate 컬럼에서 시간 부분만 추출해서 저장

#1. mdate 컬럼의 자료형을 문자열 형태로 mdate 값에 저장
mdate <- as.character(ds$mdate)
#mdate
ds$year <- as.numeric(substr(mdate, 1, 4))
#head(ds$year)
ds$month <- as.numeric(substr(mdate, 5, 6))
ds$hour <- as.numeric(substr(mdate, 9, 10))
str(ds)

#서울 지역 측정소 번호만 가져오자
unique(ds$loc)
tmp <- subset(ds, subset = loc==111123)
tmp
unique(tmp$측정소명)
ds$locname[ds$loc==111123] <- '서울'
ds$locname[ds$loc==336111] <- '목포'
ds$locname[ds$loc==632132] <- '강릉'
str(ds)

#지역별(locname) 별, 미세먼지(PM10)의 분포도를 박스그래프로 작성해보자
boxplot(PM10~locname, data=ds, main='미세먼지 농도 분포', ylim=c(1,100))

#결측값을 제거하자: 결측값이 있는 행은 제외시키자
ds <- ds[complete.cases(ds),]
nrow(ds) #46848, locname의 '서울', '목포', '강릉'을 제외하고 모두 NA값이라서 왕창 다 날아감

#연도별, 지역별 PM10 농도의 평균을 구해보자
#aggregate(): group by
tmp.year <- aggregate(ds$PM10,
                      by=list(year=ds$year, loc=ds$locname), FUN='mean')
tmp.year

#library(ggiraphExtra)
library(ggplot2)
ggplot(tmp.year, aes(x=year, y=x, colour=loc, group=loc), interactive=T)+geom_line()+geom_point(size=2, shape=19, alpha=0.5)+ #shape: 1~25, alpha: 투명도(0~1)
  ggtitle('연도별 PM10 농도변화')+ylab('농도')
#################################################################################
setwd('D:/R/data')
folder='airkorea'
files <- list.files(path=folder,
                    pattern='csv$', full.names=TRUE)
files
ds <- NULL
for(f in files){
  print(f)
  tmp <- read.csv(f, header=T, fileEncoding = 'CP949')
  ds <- rbind(ds, tmp)
}
str(ds)
#PM25 column 제외
ds <- ds[,-10]
#결측값 데이터가 없는 행만 저장하자
ds <- ds[complete.cases(ds),]
str(ds)

#각 오염물질 간의 상관관계를 알아보자

#1. 각 오염물질(5종) 산점도 출력
#plot(ds, 5:9) #실패 => 시간이 너무 많이 걸림
#전수조사를 해야할 필요는 없으니 sampling을 할 필요가 있음
#샘플로 상관관계를 조사하자

#2. sampling
set.seed(1234)
#sample(데이터갯수, 샘플데이터갯수)
#sample(nrow(ds), 5000)
sample <- ds[sample(nrow(ds), 5000), 5:9]
str(sample)

#3. 산점도를 그려보자
plot(sample)

#4. 상관계수를 찾아보자: A, B 상관계수 => A변수가 1만큼 이동할 때, B변수가 0.8 이동한다면, 두 변수 간 0.8의 상관계수를 가진다.
#상관계수: -1 ~ 1 // 0일 때, 완전히 상관 없다.
cor(sample)

#미세먼지의 최고값, 최저값 구하기
#최고값을 가진 ds 데이터의 행의 값, 최저값을 가진 ds 데이터의 행의 값 조회하기
min(ds$PM10) #0
max(ds$PM10) #1238
str(sample)

#인덱스 조회
which.min(ds$PM10) #313373번 행
which.max(ds$PM10) #158773번 행
ds[313373,]
ds[which.max(ds$PM10),] #최대값을 가진 데이터 정보
ds[158773,]
ds[which.min(ds$PM10),] #최소값을 가진 데이터 정보
