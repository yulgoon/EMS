# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 10:10:12 2023

@author: GDJ

/프로젝트폴더/urls.py 
"""
from django.urls import path
from . import views

urlpatterns = [
    path("", views.index),  #http://localhost:8000/
]
