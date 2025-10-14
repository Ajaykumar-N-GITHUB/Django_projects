from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from django.shortcuts import render



class Login(APIView):
    def get(self,request,format=None):
        return render(request, 'login.html')
    

class Signup(APIView):
    def get(self, request, format=None):
        return render(request, 'signup.html')

