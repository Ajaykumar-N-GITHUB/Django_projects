from account.models import Customer
from django.contrib.auth.hashers import make_password, check_password
from rest_framework.response import Response
from rest_framework import status
from dashboard.record_operations import send_reminder



def signup_user(data):
    try:
        if Customer.objects.filter(user_id=data['user_id']).exists():
            return "User Id already exists. Please choose a different one"
        else:
            customer_obj = Customer()
            customer_obj.name = data['name']
            customer_obj.email = data['email']
            customer_obj.phone_number = data['phone_number']
            customer_obj.address = data['address']
            customer_obj.town = data['town']
            customer_obj.state = data['state']
            customer_obj.district = data['district']
            customer_obj.farm_size = data['farm_size']
            customer_obj.user_id = data['user_id']
            if data['password'] and len(data['password']) >= 8:
                hashed_password = make_password(data['password'])
                customer_obj.password = hashed_password
            else:
                return "Password must be at least 8 characters long"
            print("hello")
            customer_obj.save()
            return True
    except Exception as e:
        return str(e)   
    


def login_user(data):
    try:
        user = Customer.objects.get(user_id = data['user_id'])
        if check_password(data['password'], user.password):
            send_reminder(data['user_id'])
            return True
        else:
            return "Please check the credentials"
    except Customer.DoesNotExist:
        return "User not found"
    
def reset_password(data):
    try:
        user = Customer.objects.get(user_id=data['user_id'])
        if data['new_password'] == data['confirm_password'] and len(data['new_password']) >= 8:
            user.password = make_password(data['new_password'])
            user.save()
            return True
        else:
            return "New password and confirm password are too short pls assign a 8 character password"
    except user.DoesNotExist:
        return "User not found"
        