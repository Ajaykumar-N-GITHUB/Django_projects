from django.urls import path
from mailapp.views import DisplayView

urlpatterns = [
    path('display', DisplayView().as_view()),
    
]