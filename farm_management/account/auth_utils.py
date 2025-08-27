from functools import wraps
from django.shortcuts import render, redirect
from django.http import JsonResponse
from account.models import Customer, Worker
from rest_framework import status

def role_required(allowed_roles):
    """
    Decorator to check if user has required role.
    allowed_roles: list of roles like ['owner'], ['manager'], ['worker'], ['manager', 'worker']
    """
    def decorator(view_func):
        @wraps(view_func)
        def wrapper(self, request, *args, **kwargs):
            user_id = request.session.get('user_id')
            
            # If no user is logged in
            if not user_id:
                if hasattr(request, 'content_type') and 'application/json' in str(request.content_type):
                    return JsonResponse({"error": "Authentication required"}, status=401)
                return render(request, 'login.html')
            
            user_role = None
            
            # Check if user is a Customer (Owner)
            customer = Customer.objects.filter(user_id=user_id).first()
            if customer:
                user_role = customer.role
            else:
                # Check if user is a Worker
                worker = Worker.objects.filter(worker_id=user_id).first()
                if worker:
                    user_role = worker.worker_role
            
            # If user doesn't exist in either table
            if not user_role:
                if hasattr(request, 'content_type') and 'application/json' in str(request.content_type):
                    return JsonResponse({"error": "Invalid user"}, status=401)
                return render(request, 'login.html')
            
            # Check if user has required role
            if user_role not in allowed_roles:
                if hasattr(request, 'content_type') and 'application/json' in str(request.content_type):
                    return JsonResponse({"error": "Insufficient permissions"}, status=403)
                return render(request, 'login.html')
            
            return view_func(self, request, *args, **kwargs)
        return wrapper
    return decorator

def get_user_role(user_id):
    """
    Helper function to get user role
    """
    if Customer.objects.filter(user_id=user_id).exists():
        user = Customer.objects.get(user_id=user_id)
        return user.role
    elif Worker.objects.filter(worker_id=user_id).exists():
        worker = Worker.objects.get(worker_id=user_id)
        return worker.worker_role
    return None

def is_authenticated(request):
    """
    Check if user is authenticated
    """
    return request.session.get('user_id') is not None
