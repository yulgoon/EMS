from django.db import models

# Create your models here.
# model 부분 소스 : member/models.py
# anaconda prompt 실행. 프로젝트 폴더로 이동
# python manage.py makemigrations
# python manage.py migrate

class Member(models.Model):
    id=models.CharField(max_length=20,primary_key=True)
    pw=models.CharField(max_length=20)
    name=models.CharField(max_length=20)    
    gender=models.IntegerField(default=0)
    tel=models.CharField(max_length=20)
    email=models.CharField(max_length=100)
    picture=models.CharField(max_length=200)
    
    def __str__(self) :
        return self.id + ":" + self.name + ":" + self.pw