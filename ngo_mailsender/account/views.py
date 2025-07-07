from django.shortcuts import render
from rest_framework.views import APIView
from account.services import email_sender_service, login_service, signup_service, reset_password_service
from account.models import UserDetails
from rest_framework.response import Response
from rest_framework import status




class AboutView(APIView):
    def get(self, request):
        return render(None, 'about.html')
    

class ContactView(APIView):
    def get(self, request):
        return render(request, 'contact.html')
    
    def post(self, request):
        res = email_sender_service(request.data)
        return res
    

class LoginView(APIView):
    def get(self, request):
        return render(request, 'login.html')
    
    def post(self, request, format=None):
        user = UserDetails.objects.filter(user_id=request.data['user_id']).first()
        if user:
            request.session['user_id'] = user.user_id
        res = login_service(request.data)

        if res is True:
            return Response({"message": "Login successful"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        

class LogoutView(APIView):
    def get(self, request):
        if 'user_id' in request.session:
            del request.session['user_id']
        return render(request, 'logout.html')
    

class SignupView(APIView):
    def get(self, request):
        return render(request, 'signup.html')
    
    def post(self, request, format=None):
        res = signup_service(request.data)
        print(res)
        if res is True:
            return Response({"message": "User Created successfully"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        




class ResetpasswordView(APIView):
    def get(self, request, format=None):
        return render(request, 'forget_password.html')

    def post(self, request, format=None):
        res = reset_password_service(request.data)
        if res is True:
            return Response({"message": "Password reset successfully"}, status=status.HTTP_200_OK)
        else:
            print(res)
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)



    