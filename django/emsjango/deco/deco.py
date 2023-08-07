# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 15:24:09 2023

@author: GDJ

deco/deco.py 
"""
from django.shortcuts import render

def loginIdchk(func) :
    def check(request, id) :
        try :
            login = request.session["login"]
        except :
            context = {"msg":"로그인하세요","url":"../../login/"}
            return render(request,"alert.html",context)
        else :
            if login != id and login != "admin" :
               return render(request,"alert.html",
                             {"msg":"본인만 거래 가능합니다.","url":"../../main/"})
        return func(request,id)
    return check

def adminChk(func) :
    def check(request) :
        try :
            login = request.session["login"]
        except :
            context = {"msg":"로그인하세요","url":"../login/"}
            return render(request,"alert.html",context)
        else :
            if login != "admin" :
               return render(request,"alert.html",
                             {"msg":"관리자만 가능합니다.","url":"../main/"})
        return func(request)
    return check

def loginchk(func):
    def check(request):
        try :
            login = request.session["login"]
        except :
            context = {"msg":"로그인하세요","url":"../login/"}
            return render(request,"alert.html",context)
        return func(request)
    return check