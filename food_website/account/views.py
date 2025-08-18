from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from account.services import user_signup,user_logout,user_login, forget_passwd
# Create your views here.
class Signup(APIView):
    def get(self, request, format=None):
        return render(request, 'signup.html')

    def post(self, request,format=None):
        res = user_signup(request.data)
        if res == "success":
            return Response({"message": "User created successfully"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
class Login(APIView):
    def get(self, request, format=None):
        return render(request, 'login.html')

    def post(self, request, format=None):
        res = user_login(request.data)
        if res == 'success':
            return Response({"message": "User logged in successfully"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_401_UNAUTHORIZED)
    
class Logout(APIView):
    def post(request, format=None):
        res = user_logout()
        return Response(res)
    

class ForgetPasswd(APIView):
    def get(self, request, format=None):
        return render(request, 'forget_passwd.html')

    def post(self, request, format=None):
        res = forget_passwd(request.data)
        return res