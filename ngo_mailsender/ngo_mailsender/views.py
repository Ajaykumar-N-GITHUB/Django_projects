from django.shortcuts import render
from rest_framework.views import APIView
from django.contrib.auth import logout
from django.contrib import messages



def HomeView(request):
    return render(request, 'home.html')


