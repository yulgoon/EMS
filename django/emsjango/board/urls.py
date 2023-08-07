# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 10:10:12 2023

@author: GDJ

/프로젝트폴더/board/urls.py 
"""
from django.urls import path
from . import views

urlpatterns = [
    path("write/", views.write),            #http://localhost:8000/board/write
    path("list/", views.list),              #http://localhost:8000/board/list
    path("info/<int:num>/", views.info),    #http://localhost:8000/board/info
    path("update/<int:num>/", views.update),  #http://localhost:8000/board/update
    path("delete/<int:num>/", views.delete),  #http://localhost:8000/board/delete
]
