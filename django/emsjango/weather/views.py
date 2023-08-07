from django.shortcuts import render
from .models import Weather
from datetime import datetime, timedelta
from .weather import fun_predict
import numpy as np

# Create your views here.

def index(request):
    for i in range(0,8):
        day = datetime.today() + timedelta(i)
        day = day.strftime('%m-%d')
        day_avg = fun_predict(day, 'avg_temp')
        day_min = fun_predict(day, 'min_temp')
        day_max = fun_predict(day, 'max_temp')
        
        w = Weather(no = str(i), today = (datetime.today() + timedelta(i)).strftime('%Y-%m-%d'),\
                    max_temp = np.round(day_max,1), min_temp = np.round(day_min,1), avg_temp = np.round(day_avg,1))
        w.save()
    weather_list = Weather.objects.all()
    return render(request, 'weather/index.html', {'list':weather_list})