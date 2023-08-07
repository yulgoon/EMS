# -*- coding: utf-8 -*-
"""
Created on Tue Jul 18 09:05:13 2023

@author: GDJ
"""
#################################
# 이중분류 : 결과가 2개인 경우
import pandas as pd
url = \
"http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/"
red = pd.read_csv(url+'winequality-red.csv', sep=';') #red 와인 정보
white = pd.read_csv(url+'winequality-white.csv', sep=';') #white 와인 정보
red.info() #1599건
white.info() #4898건
#type 컬럼 추가
red["type"]=0
white["type"]=1

red.head()
white.head()

#red,white 데이터 합하여 wine 데이터 생성
wine = pd.concat([red,white])
wine.info()
wine.min()
wine.max()

#wine 데이터를 minmax 정규화하여 wine_norm 데이터에 저장
wine_norm = (wine-wine.min()) / (wine.max()-wine.min())
wine_norm.min()
wine_norm.max()
wine_norm["type"].head()
wine_norm["type"].tail()
#wine_norm 데이터를 섞어 wine_shuffle 데이터로 생성하기
import numpy as np
#sample(frac=1) : 임의로 표본추출
#       frac=1 : 100% =>  전체 데이터를 표본추출 
wine_shuffle = wine_norm.sample(frac=1)
wine_shuffle.head()
wine_shuffle["type"].head(10)
wine_shuffle["type"].tail(10)
wine_shuffle.info()
#pandas 데이터를 numpy의 배열로 저장
wine_np = wine_shuffle.to_numpy()
type(wine_np)
wine_np.shape

train_idx = int(len(wine_np)*0.8)  #훈련데이터의 갯수
train_idx
# 설명변수(독립변수),목표변수(종속변수)(정답)로 분리
#훈련데이터 분리
train_x,train_y = wine_np[:train_idx,:-1],wine_np[:train_idx,-1]
train_x.shape    #(5197, 12)
train_y.shape    #(5197,)
#테스트데이터 분리
test_x,test_y = wine_np[train_idx:,:-1],wine_np[train_idx:,-1]
test_x.shape #(1300, 12)
test_y.shape #(1300,)

#LABEL을 onehot 인코딩하기
import tensorflow as tf
train_y = tf.keras.utils.to_categorical(train_y,num_classes=2)
test_y = tf.keras.utils.to_categorical(test_y,num_classes=2)
train_y
test_y

#모델 생성.
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Dense
model = Sequential([
    Dense(units=48,activation='relu',input_shape=(12,)),
    Dense(units=24,activation='relu'),
    Dense(units=12,activation='relu'),
    Dense(units=2,activation='sigmoid')    #이중분류 사용. 
    ])
model.summary()
#binary_crossentropy : 이중분류에서 사용되는 손실함수
#                      레이블을 onehot 인코딩 필요
#                      활성화 함수는 보통 sigmoid를 사용함
model.compile(optimizer="adam", loss='binary_crossentropy',\
              metrics=['accuracy'])
#학습을 안한 상태에서 평가    
model.evaluate(test_x,test_y) #[0.7278726696968079, 0.2484615445137024]
#validation_split=0.25 : 훈련 데이터 중 25%를 검증 데이터로 사용     
history = model.fit(train_x,train_y,epochs=25,batch_size=32,\
                    validation_split=0.25)
#학습결과 시각화하기.
import matplotlib.pyplot as plt
plt.figure(figsize=(12, 4))
plt.subplot(1, 2, 1)
#'b-' : blue, - : 실선 =>  파랑색 실선
#'r--' : red, --: 점선 => 빨강색 점선
plt.plot(history.history['loss'], 'b-', label='loss')
plt.plot(history.history['val_loss'], 'r--', label='val_loss') 
plt.xlabel('Epoch')
plt.legend()
plt.subplot(1, 2, 2)
plt.plot(history.history['accuracy'], 'b-', label='accuracy') 
plt.plot(history.history['val_accuracy'], 'r--',\
         label='val_accuracy')
plt.xlabel('Epoch') 
plt.ylim(0.7, 1) #y축의 값의 범위 
plt.legend()  #범례 표시
plt.show()  
# 과적합 발생 안함.
#평가하기
model.evaluate(test_x,test_y) #[0.03613852709531784, 0.9923076629638672]
#예측 데이터
results = model.predict(test_x) 
results[:10]
np.argmax(results[:10],axis=-1) #예측 데이터 10개
test_y[:10]
np.argmax(test_y[:10],axis=-1)  #실제 데이터 10개
#혼동행렬 조회 
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(np.argmax(test_y,axis=-1),\
                      np.argmax(results,axis=-1))
cm  
import seaborn as sns
plt.figure(figsize = (7, 7))
sns.heatmap(cm, annot = True, fmt = 'd',cmap = 'Blues')
plt.xlabel('predicted label', fontsize = 15)
plt.ylabel('true label', fontsize = 15)
plt.xticks(range(2),['red','white'],rotation=45)
plt.yticks(range(2),['red','white'],rotation=0)
plt.show()

from sklearn.metrics import classification_report
classification_report\
  (np.argmax(test_y, axis = -1), np.argmax(results, axis = -1))

from sklearn.metrics import accuracy_score,\
     precision_score, recall_score, f1_score
print("정확도(accuracy): %.3f" %  \
   accuracy_score(np.argmax(test_y, axis = -1), np.argmax(results, axis = -1)))
print("정밀도(Precision) : %.3f" % \
   precision_score(np.argmax(test_y, axis = -1), np.argmax(results, axis = -1)))
print("재현율(Recall) : %.3f" % \
      recall_score(np.argmax(test_y, axis = -1), np.argmax(results, axis = -1)))
print("F1-score : %.3f" % \
      f1_score(np.argmax(test_y, axis = -1), np.argmax(results, axis = -1)))
cm
'''
    예측  0(N)  1(P)
실제  
   0(N) [317,   6],
   1(P) [  4, 973]
   
 TN : 실제:0, 예측:0  =>317
 FP : 실제:0, 예측:1  =>6
 FN : 실제:1, 예측:0  =>4
 TP : 실제:1, 예측:1  =>973

 실제와 같은 예측 : TN,TP 
 실제와 다른 예측 : FN,FP 
 
 정확도 :  정답갯수/전체데이터갯수 => (TP+TN)/(TP+TN+FP+FN)
         =>  1290/1300 =>0.9923076923076923
 정밀도 : 예측한 중 실제P인갯수/P로 예측한 전체갯수 =>    TP/(TP+FP)    
         =>  973/(973+6) =>0.9938712972420838
 재현율 :  P로 예측한 갯수/실제전체P인 갯수  => TP/(TP+FN)      
         => 973/(973+4) =>0.9959058341862845
 F1-score(조화평균) : 2* ((정밀도*재현율)/(정밀도+재현율))       
         => 2 * ( 0.9898022233536822/1.989777131428368) =>0.9948875255623723
'''
####################################
#  이미지 데이터 분석
####################################
import tensorflow as tf
import matplotlib.pyplot as plt
image_path = tf.keras.utils.get_file('cat.jpg', 'http://bit.ly/33U6mH9') 
image = plt.imread(image_path) #배열로 저장된 이미지 데이터
image.shape
titles = ['RGB', 'Red', 'Green', 'Blue']
from numpy import array, zeros_like

def channel(image,color) : #원본이미지, -1 ~ 2
    if color not in (0,1,2) : return image
    c = image[...,color] #3개중 color값의 데이터
    #c.shape : (241,320)
    z = zeros_like(c) #zeros_like : c형태와 같은 배열생성. 0으로 초기화
    #transpose(1,2,0) :배열의 차원을 변경 . 
    #(c,z,z).shape : (3,241,320)  => (241,320,0)
    return array([(c,z,z),(z,c,z),(z,z,c)][color]).transpose(1,2,0)

colors = range(-1,3) #-1 ~ 2 사이의 정수값 저장
fig,axes = plt.subplots(1,4,figsize=(13,3))
objs = zip(axes,titles,colors)
for ax,title,color in objs :
    ax.imshow(channel(image,color)) #이미지 출력
    ax.set_title(title)
    ax.set_xticks(()) #x축 표시안함
    ax.set_yticks(()) #y축 표시안함
plt.show()    
'''
   Django 설치하기 
   1. anaconda prompt 실행
      - pip install Django => 장고 설치
      - python -m django --version => 장고버전 확인
      - 장고 소스를 저장을 위한 폴더 생성 : D:\20230717\django
        cd D:\20230717\django => 현재 폴더 변경
        d: => 드라이브가 다른 경우만
      - 장고 프로젝트 생성
         django-admin startproject emsjango =>프로젝트 폴더
      - 현재 폴더를 프로젝트 폴더로 이동
         cd emsjango
      - application 생성
        python manage.py startapp member
   2. 파일 탐색기 실행     
      - templates 폴더 생성 : D:\20230717\django\emsjango\templates
   3. spyder 의 폴더를 D:\20230717\django\emsjango\ 변경   
      emsjango 폴더의 settings.py 파일 수정하기
      - INSTALLED_APPS = [,"member"] => member 인식하도록 설정
      - TEMPLATES = [
          {
              "BACKEND": "django.template.backends.django.DjangoTemplates",
              "DIRS": [BASE_DIR/'templates'], => 수정
      - LANGUAGE_CODE = "ko-kr"   => 수정
        TIME_ZONE = "Asia/Seoul"
        
   4. anaconda prompt 실행 => 프로젝트 폴더로 이동
      python manage.py migrate => database 설정
      python manage.py runserver => 장고서버 실행. port:8000
      
'''



