from account.models import User
from rest_framework.response import Response
from django.contrib.auth import authenticate
from rest_framework import status
from django.contrib.auth.hashers import make_password, check_password

def do_signup(data):
    
    if User.objects.filter(user_name=data['user_name']).exists():
        return "User ID already exists. Please choose a different one"
    try:
        user_obj = User()
        user_obj.user_name = data['user_name']
        if not data['user_mobile'].isdigit():
            return "Mobile number must contain only digits."

        user_obj.user_mobile = data['user_mobile']
        user_obj.user_location = data['user_location']
        user_obj.user_dob = data['user_dob']
        user_obj.user_age = data['user_age']
        user_obj.user_email = data['user_email']
        user_obj.user_id = data['user_id']
        if data['user_passwd'] == data['check_passwd'] and len(data['user_passwd']) >= 8:
            hashed_password = make_password(data['user_passwd'])
            user_obj.user_passwd = hashed_password
            
        else:
            return "Please check the Password and Confirm Password are same and the length should be greater than or equal to 8"
        user_obj.save()
       
        return "success"
    
    except Exception as e:
        return str(e)

def do_login(data):
    try:
        user = User.objects.get(user_id=data['user_id'])
        if check_password(data['user_passwd'], user.user_passwd):
            return "success"
        else:
            return "please check the credentials"
    except User.DoesNotExist:
        return "User not found"
    except Exception as e:
        return str(e)

def reset_password(data):
    try:
        print(data)
        user = User.objects.get(user_id=data['user_id'])
        if data['new_password1'] == data['new_password2'] and len(data['new_password1']) >= 8:
            user.user_passwd = make_password(data['new_password1'])
            user.save()
            return True
        else:
            return Response({"message": "New password and confirm password do not match or are too short"}, status=status.HTTP_400_BAD_REQUEST)
    except User.DoesNotExist:
        return "User not found"

def do_logout():
    return "Logout Success"

