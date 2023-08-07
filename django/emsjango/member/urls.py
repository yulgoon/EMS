# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 10:10:12 2023

@author: GDJ

/프로젝트폴더/member/urls.py 
"""
from django.urls import path
from . import views

urlpatterns = [
    path("join/",views.join),    #http://localhost:8000/member/join
    path("login/",views.login),  #http://localhost:8000/member/login
    path("main/",views.main),    #http://localhost:8000/member/main
    path("logout/",views.logout),#http://localhost:8000/member/main
    path("info/<str:id>/",views.info),#http://localhost:8000/member/info/hongkd/=>우아한url
    path("list/",views.list),    #http://localhost:8000/member/list
    path("picture/",views.picture),    #http://localhost:8000/member/picture
    path("update/<str:id>/",views.update),    #http://localhost:8000/member/update/hongkd/
    path("delete/<str:id>/",views.delete),   #http://localhost:8000/member/delete
    path("password/",views.password),   #http://localhost:8000/member/delete
]
