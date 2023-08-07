# -*- coding: utf-8 -*-
"""
Created on Fri Jul 21 14:36:47 2023

@author: GD

 source: weather/weather.py
"""

import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

def fun_predict(day, p_we):
    if p_we == 'avg_temp':
        pr_y = '평균기온(℃)'
    elif p_we == 'max_temp':
        pr_y = '최고기온(℃)'
    elif p_we == 'min_temp':
        pr_y = '최저기온(℃)'

    df = pd.read_csv('D:/django/emsjango/file/weather/seoul.csv', encoding='cp949')
    # df.info()
    # df.head()

# 2023년 7월 21일 날짜 예측하기 => 7월 21일자만 모아서 선형회귀분석
# 연도 컬럼 생성
    df['연도'] = df['날짜'].apply(lambda x: x[:4])
    df0721 = df[df['날짜'].apply(lambda x: x[5:])==day]
    # df0721.info()
    # df0721
    # plt.plot(df0721[['평균기온(℃)']])
    # plt.show()

# 결측값을 가진 레코드 제거
    df0721.dropna(subset=['평균기온(℃)','최고기온(℃)','최저기온(℃)'], axis=0, inplace=True)
    # df0721.info()
    X=df0721[['연도']]
    y=df0721['최고기온(℃)']
    model = LinearRegression()
    model.fit(X,y)
    
    result = model.predict([[2023]])
    # print(result)
    return result