from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from django.shortcuts import render
from account.services import email_sender, signup_service, login_service, reset_password_service
from account.models import Customer, Worker

class Login(APIView):
    def get(self,request,format=None):
        return render(request, 'login.html')

    def post(self, request, format=None):
        print(request.data)
        user = Customer.objects.filter(user_id=request.data['user_id']).first()
        if user:
            request.session['user_id'] = user.user_id
        else:
            worker = Worker.objects.filter(worker_id=request.data['user_id']).first()
            if worker:
                request.session['user_id'] = worker.worker_id
            else:
                return Response({"error": "User Not Found"}, status=status.HTTP_400_BAD_REQUEST)

        res = login_service(request.data)
        if res is True:
            return Response({"message": "Login successful"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
    

class Signup(APIView):
    def get(self, request, format=None):
        return render(request, 'signup.html')

    def post(self, request, format=None):
        res = signup_service(request.data)
        if res is True:
            return Response({"message": "User Created successfully"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)


class Resetpassword(APIView):
    def get(self, request, format=None):
        return render(request, 'forget_password.html')

    def post(self, request, format=None):
        res = reset_password_service(request.data)
        if res is True:
            return Response({"message": "Password reset successfully"}, status=status.HTTP_200_OK)
        else:
            print(res)
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)


class About(APIView):
    def get(self, request):
        return render(request, 'aboutus.html')


class Contact(APIView):
    def get(self, request):
        return render(request, 'contact.html')
    
    def post(self, request):
        res = email_sender(request.data)
        return res
    
class Logout(APIView):
    def get(self, request):
        if 'user_id' in request.session:
            del request.session['user_id']
        return render(request, 'logout.html')