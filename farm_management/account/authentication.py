from account.models import Customer, Worker
from dashboard.models import AddRecord
from django.contrib.auth.hashers import make_password, check_password
from rest_framework.response import Response
from rest_framework import status
from dashboard.record_operations import send_reminder
from account.sendemail import alert_email, welcome_email


def signup_user(data):
    try:
        if Customer.objects.filter(user_id=data['user_id']).exists():
            return "User Id already exists. Please choose a different one"
        if Customer.objects.filter(email=data['email']).exists():
            return "Email already exists. Please choose a different one"
        if Customer.objects.filter(phone_number=data['phone_number']).exists():
            return "Phone number already exists. Please choose a different one"
        else:
            customer_obj = Customer()
            customer_obj.name = data['name']
            customer_obj.email = data['email']
            if data['phone_number'] and len(data['phone_number']) >= 10:
                customer_obj.phone_number = data['phone_number']
            else:
                return "Invalid phone number. Please provide a valid 10-digit phone number."
            customer_obj.address = data['address']
            customer_obj.town = data['town']
            customer_obj.state = data['state']
            customer_obj.district = data['district']
            customer_obj.farm_size = data['farm_size']
            # if data['user_id'].endswith('_owner'):
            customer_obj.user_id = data['user_id']
            # else:
            #    return "User ID must end with '_owner'"
            if data['password'] and len(data['password']) >= 8:
                hashed_password = make_password(data['password'])
                customer_obj.password = hashed_password
            else:
                return "Password must be at least 8 characters long"
            print("hello")
            customer_obj.save()
            
            # Skip email sending in production to avoid timeouts
            # You can enable this later with better email service
            return True
    except Exception as e:
        return str(e)   
    


def login_user(data):
    try:
        print(data)
        if Customer.objects.filter(user_id = data['user_id']).exists():
            user = Customer.objects.get(user_id = data['user_id'])
            if check_password(data['password'], user.password):
                return True
            else:
                return "Please check the credentials"
        else:
            print("I am here")
            user = Worker.objects.get(worker_id=data['user_id'])
            if data['password'] == user.worker_passwd:
                return True
            else:
                return "Please check the credentials"
    except Exception as e:
        print(e)
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
    except Exception as e:
        return "user Not Found, please Register Yourself"



def get_worker_manager(data):
    res = {
        "managers": [],
        "workers": [],
        "status": "",
        "message": ""
    }

    try:

        managers = Worker.objects.filter(owner_id=data['owner_id'], worker_role='manager').values('worker_name', 'worker_id', 'worker_passwd', 'created_at', 'phone_number')
        workers = Worker.objects.filter(owner_id=data['owner_id'], worker_role='worker').values('worker_name', 'worker_id', 'worker_passwd', 'created_at', 'phone_number')

        for manager in managers:
            res['managers'].append({
                "name": manager['worker_name'],
                "id": manager['worker_id'],
                "password": manager['worker_passwd'],
                "date_of_joining": manager['created_at'],
                "phone_number": manager['phone_number']
            })

        for worker in workers:
            res['workers'].append({
                "name": worker['worker_name'],
                "id": worker['worker_id'],
                "password": worker['worker_passwd'],
                "date_of_joining": worker['created_at'],
                "phone_number": worker['phone_number']
            })

            res["status"] = "success"
            res["message"] = "User data retrieved successfully"

        return Response(res)

    except Exception as e:
        print(e)
        res["status"] = "error"
        res["message"] = str(e)
        return Response(res)



def get_pending_records(data):
    print(data)
    res = {
        "expenses": [],
        "status": "",
        "message": ""
    }
    try:
        user_id = data.get('user_id')
        if not user_id:
            res["status"] = "error"
            res["message"] = "User ID is required"
            return Response(res)
        
        # Get the manager's owner
        manager = Worker.objects.filter(worker_id=user_id, worker_role='manager').first()
        if not manager:
            res["status"] = "error"
            res["message"] = "Manager not found"
            return Response(res)
        
        # Fetch pending records only for this manager's owner
        owner = manager.owner
        expenses = AddRecord.objects.filter(farm_owner=owner, status="pending").values()
        
        for expense in expenses:
            res["expenses"].append(expense)
            
        res["status"] = "success"
        res["message"] = "Pending expense data retrieved successfully"
        return Response(res)
    except Exception as e:
        print(f"Error in get_pending_records: {e}")
        res["status"] = "error"
        res["message"] = str(e)
        res["expenses"] = []
        return Response(res)

def get_all_records(data):
    print(data)
    res = {
        "expenses": [],
        "status": "",
        "message": "",
        "daily_approval_count": 0
    }
    try:
        user_id = data.get('user_id')
        if not user_id:
            res["status"] = "error"
            res["message"] = "User ID is required"
            return Response(res)
        
        # Get the manager's owner
        manager = Worker.objects.filter(worker_id=user_id, worker_role='manager').first()
        if not manager:
            res["status"] = "error"
            res["message"] = "Manager not found"
            return Response(res)
        
        # Fetch records only for this manager's owner
        owner = manager.owner
        expenses = AddRecord.objects.filter(farm_owner=owner).values()
        
        for expense in expenses:
            res["expenses"].append(expense)
        
        # Get today's approval count for this user
        res["daily_approval_count"] = get_daily_approval_count(user_id)
            
        res["status"] = "success"
        res["message"] = "All expense data retrieved successfully"
        return Response(res)
    except Exception as e:
        print(f"Error in get_all_records: {e}")
        res["status"] = "error"
        res["message"] = str(e)
        res["expenses"] = []
        return Response(res)

def approve_expense(data):
    print(data)
    res = {}
    try:
        expense_id = data['expense_id']
        user_id = data.get('user_id')
        
        if not user_id:
            res["status"] = "error"
            res["message"] = "User ID is required"
            return Response(res)
        
        # Get the manager's owner
        manager = Worker.objects.filter(worker_id=user_id, worker_role='manager').first()
        if not manager:
            res["status"] = "error"
            res["message"] = "Manager not found"
            return Response(res)
        
        # Ensure the record belongs to this manager's owner
        record = AddRecord.objects.filter(id=expense_id, farm_owner=manager.owner).first()
        if not record:
            res["status"] = "error"
            res["message"] = "Record not found or access denied"
            return Response(res)
        
        record.status = "approved"
        record.save()
        
        # Increment daily approval count for this user
        new_count = increment_daily_approval_count(user_id)
        res["daily_approval_count"] = new_count
        
        res["status"] = "success"
        res["message"] = "Expense approved successfully"
        res["expense_id"] = expense_id
        return Response(res)
    except Exception as e:
        print(f"Error in approve_expense: {e}")
        res["status"] = "error"
        res["message"] = str(e)
        return Response(res)

def reject_expense(data):
    print(data)
    res = {}
    try:
        expense_id = data['expense_id']
        user_id = data.get('user_id')
        
        if not user_id:
            res["status"] = "error"
            res["message"] = "User ID is required"
            return Response(res)
        
        # Get the manager's owner
        manager = Worker.objects.filter(worker_id=user_id, worker_role='manager').first()
        if not manager:
            res["status"] = "error"
            res["message"] = "Manager not found"
            return Response(res)
        
        # Ensure the record belongs to this manager's owner
        record = AddRecord.objects.filter(id=expense_id, farm_owner=manager.owner).first()
        if not record:
            res["status"] = "error"
            res["message"] = "Record not found or access denied"
            return Response(res)
        
        record.status = "rejected"
        record.save()
        res["status"] = "success"
        res["message"] = "Expense rejected successfully"
        res["expense_id"] = expense_id
        return Response(res)
    except Exception as e:
        print(f"Error in reject_expense: {e}")
        res["status"] = "error"
        res["message"] = str(e)
        return Response(res)

def get_daily_approval_count(user_id):
    """Get today's approval count for a specific user"""
    from datetime import date
    today = date.today()
    
    try:
        # Count records approved today by this user
        # Assuming you have a field to track who approved and when
        # For now, we'll use a simple approach with session/temp storage
        from django.core.cache import cache
        cache_key = f"daily_approvals_{user_id}_{today}"
        count = cache.get(cache_key, 0)
        return count
    except Exception as e:
        print(e)
        return 0

def increment_daily_approval_count(user_id):
    """Increment today's approval count for a specific user"""
    from datetime import date
    from django.core.cache import cache
    
    today = date.today()
    cache_key = f"daily_approvals_{user_id}_{today}"
    
    try:
        current_count = cache.get(cache_key, 0)
        new_count = current_count + 1
        # Store for 24 hours (86400 seconds)
        cache.set(cache_key, new_count, 86400)
        return new_count
    except Exception as e:
        print(e)
        return 0
