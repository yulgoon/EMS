from django.db import models

# Create your models here.

class Weather(models.Model):
    no = models.CharField(max_length=20, primary_key=True)
    today = models.DateField()
    max_temp = models.FloatField()
    min_temp = models.FloatField()
    avg_temp = models.FloatField()
