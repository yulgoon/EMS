# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
'''
   인공신경망(ANN) 
    단위 : 퍼셉트론
    
    y = x1w1 + x2w2 + b
    x1,x2 : 입력값, 입력층
    y : 결과값.
    w : 가중치
    b : 편향.
'''
import numpy as np
def AND(x1,x2) :  #1,0
    x = np.array([x1,x2])  #입력값
    w = np.array([0.5,0.5]) #가중치
    b = -0.8                #편향
    tmp = np.sum(w*x) + b
    if tmp <= 0 :
        return 0
    else :
        return 1
    
for xs in [(0,0),(0,1),(1,0),(1,1)] :
   y=AND(xs[0],xs[1])  
   print(xs,"=>",y)

'''
   tensorflow 설치
   anaconda prompt 관리자모드로 실행
     pip install tensorflow  
   
'''
import tensorflow as tf
tf.__version__

#텐서플로를 이용하여 AND 구현하기
data = np.array([[0,0],[0,1],[1,0],[1,1]])
#label = np.array([[0],[0],[0],[1]])
label = np.array([[0],[1],[1],[1]])
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.optimizers import SGD
from tensorflow.keras.losses import mse
model = Sequential()  #딥러닝 모델 저장 객체
'''
Dense : 밀집층. 
   1  : 출력값의 갯수
   input_shape : 입력값의 갯수. 
   activation : 활성화 함수. 
        linear : 선형함수. a==y
        sigmoid : 0 ~ 1사이의 값 변경
        relu   : 양수인 경우 선형함수. 음수인 경우 0
        ....
'''
model.add(Dense(1,input_shape=(2,),activation='linear'))
'''
   compile :가중치를 찾는 방법 설정
   optimizer=SGD() : 경사하강법 알고리즘 설정 
   loss=mse : 손실함수. 평균제곱오차
              손실함수값이 적은 경우의 가중치와 편향 구함
   metrics=['acc'] : 평가 방법 지정.
        acc : 정확도
    
   좋은 모델이란 손실함수값이 적고, 정확도는 1에 가까운 가중치와
    편향의 값을 구하는 것     
'''
model.compile(optimizer=SGD(),loss=mse,metrics=['acc'])
'''
   학습하기
   data : 훈련데이터
   label :  정답
   epochs=300 : 300번 학습
   verbose=0 : 학습과정 상세 출력 생략
   verbose=1 : 기본값. 학습과정 상세 출력
   verbose=2 : 학습과정 상세 간략 출력
'''
model.fit(data,label,epochs=300,verbose=2)
# 평가하기
print(model.get_weights()) #가중치 값과 편향 값 출력
print(model.predict(data)) #예측하기
#평가하기 [손실함수값,정확도]
print(model.evaluate(data,label)) 
###############################################
#   mnist 데이터를 이용하여 숫자 학습하기
###############################################
from tensorflow.keras.datasets.mnist import load_data
(x_train,y_train),(x_test,y_test) = load_data(path="mnist.npz")
x_train.shape #(60000, 28, 28)
y_train.shape #(60000,)
x_test.shape  #(10000, 28, 28)
y_test.shape  # (10000,)
y_train[:5]
x_train[:5]
# 이미지 출력
import matplotlib.pyplot as plt
import numpy as np
for idx in range(3) :  #idx : 0 ~ 2
    img = x_train[idx,:] #0번이미지. img:2차원배열 (28,28)
    print(img.shape)
    label=y_train[idx]   #0번이미지 정답. 숫자
    plt.figure()
    plt.imshow(img) #imshow(img) : 이미지값으로 이미지 출력
    plt.title\
  ('%d-th data, label is %d' % (idx,label),fontsize=15)

#검증데이터 생성 : 학습 중간에 평가를 위한 데이터 
# test_size=0.3 : x_train,y_train 데이터중 30%를 검증데이터로 분리
#random_state=777 : seed값 설정. 데이터 복기를 위한 설정.
#                   검증데이터의 일관성을 위해 설정

from sklearn.model_selection import train_test_split
x_train,x_val,y_train,y_val = train_test_split\
    (x_train,y_train,test_size=0.3, random_state=777)  
x_train.shape  #(42000, 28, 28) #훈련데이터
x_val.shape    #(18000, 28, 28) #검증데이터
x_test.shape   #(10000, 28, 28) #테스트데이터

# 레이블 전처리 : one-hot 인코딩 하기 
from tensorflow.keras.utils import to_categorical
y_train=to_categorical(y_train)
y_train[:10]
y_val=to_categorical(y_val)
y_test=to_categorical(y_test)
# 데이터 정규화
'''
    MinMax normalization : X = (x-min)/(max-min)
    Robust normalization : X = (x-중간값)/3분위값-1분위값
    Standardization      : X =x-평균값/표준편차
''' 
#MinMax normalization 정규화 하기
#현재데이터 : 최소값:0, 최대값:255
x_train = (x_train.reshape(42000,28*28))/255
x_val = (x_val.reshape(18000,28*28))/255
x_test = (x_test.reshape(10000,28*28))/255
x_train.shape #(42000, 784)
x_val.shape   #(18000, 784)
x_test.shape  #(10000, 784)
x_train[0]
#모델구성하기 
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
model = Sequential()  #모델 생성
'''
1층 :
    64 : 출력노드 갯수
    activation="relu" : 활성화 함수 
    input_shape=(784,) : 입력노드의 갯수 
2층 :  
    32 : 출력노드 갯수
    activation="relu" : 활성화 함수 
    입력값 갯수: 1층의 출력노드 갯수. 64개
3층 :  
    10 : 출력노드 갯수 => 결과값
    activation="softmax" : 활성화 함수 
    입력값 갯수: 2층의 출력노드 갯수. 32개
'''
model.add(Dense(64,activation="relu",input_shape=(784,)))
model.add(Dense(32,activation="relu"))
model.add(Dense(10,activation="softmax"))

model.summary()
'''
Param #  : 가중치,편향의 갯수 : 52650
1층 :  (784 + 1) * 64  = 50240
2층 :  (64 + 1) * 32  = 2080
3층 :  (32 + 1) * 10  = 330
'''
model.compile(optimizer="adam", loss="categorical_crossentropy",
             metrics=['acc'])
'''
optimizer="adam" : 경사하강법 알고리즘. 
loss="categorical_crossentropy" : 손실함수
     mse : 평균제곱오차
     categorical_crossentropy : 다중분류에서 사용되는 손실함수 
       다중분류 : 출력값이 여러개인 경우 10개의 출력값이므로 다중분류임
       레이블이 반드시 one-hot 인코딩 되어야 함
       활성화 함수 : 보통 softmax와 사용됨. 반드시는 아님
     binary_crossentropy : 이진분류에서 사용되는 손실함수
       이진분류 : 출력값이 2개인 경우
       활성화 함수 : 보통 sigmode와 사용됨.
 metrics=['acc'] : 평가지표. 정확도    
'''
#학습하기
history=model.fit(x_train,y_train,epochs=30,batch_size=127,
                  validation_data=(x_val,y_val)) 
'''
epochs=30 : 30 번학습
batch_size=127 : 데이터를 127개로 분리. 기본값:32
        42000/127 = 330.7086614173228 => 331이 데이터를 학습
validation_data=(x_val,y_val) : 검증 데이터 설정         
history : 학습과정을 저장하고 있는 데이터
'''
history.history["loss"] #학습데이터 손실함수값
len(history.history["loss"]) #30
history.history["val_loss"] #검증데이터 손실함수값
len(history.history["val_loss"]) #30
history.history["acc"] #학습데이터 정확도
history.history["val_acc"] #검증데이터 정확도

#결과 시각화 하기
import matplotlib.pyplot as plt
his_dict = history.history #dict 형
#손실함수 그래프
loss = his_dict['loss'] 
val_loss = his_dict['val_loss'] 
epochs = range(1, len(loss) + 1) #1~30
fig = plt.figure(figsize = (10, 5)) #가로:10, 세로:5 크기
ax1 = fig.add_subplot(1, 2, 1) #1행2열 1번째 그래프
ax1.plot(epochs, loss, color = 'blue', label = 'train_loss')
ax1.plot(epochs, val_loss, color = 'orange', label = 'val_loss')
ax1.set_title('train and val loss')
ax1.set_xlabel('epochs')
ax1.set_ylabel('loss')
ax1.legend() #범례표시
#정확도 그래프
acc = his_dict['acc'] #훈련데이터의 정확도
val_acc = his_dict['val_acc'] #검증데이터의 정확도
ax2 = fig.add_subplot(1, 2, 2) #1행2열 2번째 
ax2.plot(epochs, acc, color = 'blue', label = 'train_acc')
ax2.plot(epochs, val_acc, color = 'orange', label = 'val_acc')
ax2.set_title('train and val acc')
ax2.set_xlabel('epochs')
ax2.set_ylabel('acc')
ax2.legend() 
plt.show()
'''
 과적합현상이 발생됨 : 훈련을 너무 많이함.
                      훈련을 해도 검증 데이터의 평가 지수가 개선이 안됨
                      => 모델 검증이 필요
'''
#모델 평가
#[0.14397986233234406, 0.9688000082969666]
model.evaluate(x_test,y_test)
#예측하기
results = model.predict(x_test)
results[:10]
#np.argmax :데이터 중 가장 큰값의 인덱스 리턴
# results : 데이터
# axis=1  : 행 중 가장 큰값의 인덱스 
np.argmax(results,axis=1)
np.argmax(y_test,axis=1)

#이미지 출력
arg_results = np.argmax(results,axis=1)
plt.figure(figsize=(6,6))
for idx in range(16) : 
    plt.subplot(4, 4, idx+1) 
    plt.axis('off') 
    plt.imshow(x_test[idx].reshape(28, 28))
    plt.title('Pred:%d,lab:%d' % \
(arg_results[idx],np.argmax(y_test[idx],axis=-1)),fontsize=15)
plt.tight_layout()
plt.show()

#혼동 행렬(confusion_matrix) 조회
from sklearn.metrics import \
    classification_report,confusion_matrix
cm=confusion_matrix(np.argmax(y_test,axis=-1),\
                    np.argmax(results,axis=-1))
cm
#전체 평가 지표
classification_report(np.argmax(y_test,axis=-1),\
                    np.argmax(results,axis=-1))
#혼동 행렬을 heatmap으로 시각화 하기
#heatmap으로 출력하기
import seaborn as sns
plt.figure(figsize=(7,7))
sns.heatmap(cm,annot=True,fmt='d',cmap='Blues')
plt.xlabel('predicted label',fontsize=15)
plt.ylabel('true label',fontsize=15)
plt.show()

#################################
# 이진분류 : 분류의 종류가 2종류인 경우
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
model.compile(optimizer="adam", loss='binary_crossentropy',\
              metrics=['accuracy'])
history = model.fit(train_x,train_y,epochs=25,batch_size=32,\
                    validation_split=0.25)
#학습결과 시각화하기.
import matplotlib.pyplot as plt
plt.figure(figsize=(12, 4))
plt.subplot(1, 2, 1)
plt.plot(history.history['loss'], 'b-', label='loss')
plt.plot(history.history['val_loss'], 'r--', label='val_loss') 
plt.xlabel('Epoch')
plt.legend()
plt.subplot(1, 2, 2)
plt.plot(history.history['accuracy'], 'b-', label='accuracy') 
plt.plot(history.history['val_accuracy'], 'r--',\
         label='val_accuracy')
plt.xlabel('Epoch') 
plt.ylim(0.7, 1) 
plt.legend()
plt.show()  
#평가하기
model.evaluate(test_x,test_y)
results = model.predict(test_x)
np.argmax(results[:10],axis=-1)
np.argmax(test_y[:10],axis=-1)
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

