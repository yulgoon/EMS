from django.db import models

# board/models.py
# Create your models here.
# python manage.py makemigrations
# python manage.py migrate

class Board(models.Model):
    num = models.AutoField(primary_key=True) # 값이 등록이 안 되면 자동으로 값이 증가, 자료형은 무조건 정수형
    name = models.CharField(max_length=30)
    pw = models.CharField(max_length=20)
    title = models.CharField(max_length=200)
    content = models.CharField(max_length=2000)
    regdate = models.DateTimeField(null=True)
    readcnt = models.IntegerField(default=0)
    file1 = models.CharField(max_length=300)
    
    def __str__(self):
        return str(self.num) + ":" + self.title
    