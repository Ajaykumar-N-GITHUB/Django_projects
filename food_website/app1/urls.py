from django.urls import path
from app1.views import FoodOperation, BillGenerater, DisplayFood
urlpatterns = [
    path('add',FoodOperation.as_view()),
    path('display', DisplayFood.as_view()),
    path('download',BillGenerater.as_view()),
    
]