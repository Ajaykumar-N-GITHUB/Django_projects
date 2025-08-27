from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from django.shortcuts import render
from django.utils import timezone
from account.services import email_sender, signup_service, login_service, reset_password_service, get_worker_manager_service
from account.services import get_pending_records_service, approve_expense_service, reject_expense_service, get_all_records_service
from account.models import Customer, Worker
from account.auth_utils import role_required
from account.session_utils import set_user_session, clear_user_session, get_current_user_session, validate_user_permission, get_user_from_role_session

class Login(APIView):
    def get(self,request,format=None):
        return render(request, 'login.html')

    def post(self, request, format=None):
        print(request.data)
        
        user = Customer.objects.filter(user_id=request.data['user_id']).first()
        if user:
            # Set role-specific session for owner
            set_user_session(request, user.user_id, user.role, 'customer')
            res = login_service(request.data)
        else:
            worker = Worker.objects.filter(worker_id=request.data['user_id']).first()
            if worker:
                # Set role-specific session for worker/manager
                set_user_session(request, worker.worker_id, worker.worker_role, 'worker')
                res = login_service(request.data)
            else:
                return Response({"error": "User Not Found"}, status=status.HTTP_400_BAD_REQUEST)

        if res is True:
            # Return role information for frontend routing
            role = user.role if user else worker.worker_role
            return Response({
                "message": "Login successful",
                "role": role,
                "user_id": user.user_id if user else worker.worker_id
            }, status=status.HTTP_200_OK)
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
        # Get current user to determine which role session to clear
        current_user = get_current_user_session(request)
        if current_user:
            role = current_user.get('user_role')
            clear_user_session(request, role)
        
        # Optional: Clear all sessions if user wants to logout completely
        logout_all = request.GET.get('all', False)
        if logout_all:
            request.session.flush()
        
        return render(request, 'logout.html')

class Readme(APIView):
    def get(self, request):
        return render(request, 'readme.html')
    

class Manage(APIView):
    def get(self, request):
        # Check if user has owner permissions - be more explicit about owner session
        owner_session = get_user_from_role_session(request, 'owner')
        current_user = None
        
        if owner_session:
            current_user = owner_session
        else:
            # Fallback to general session validation
            if validate_user_permission(request, 'owner'):
                current_user = get_current_user_session(request)
        
        # If still no user found, redirect to login
        if not current_user:
            return render(request, 'login.html')
            
        context = {
            'owner_id': current_user.get('user_id')
        }
        return render(request, 'manage_users.html', context)

    def post(self, request):
        # Check if user has owner permissions - be more explicit about owner session
        owner_session = get_user_from_role_session(request, 'owner')
        current_user = None
        
        if owner_session:
            current_user = owner_session
        else:
            # Fallback to general session validation
            if validate_user_permission(request, 'owner'):
                current_user = get_current_user_session(request)
        
        # If still no user found, return error
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = get_worker_manager_service(data)
        return res
    
class Pendingrecord(APIView):
    def get(self, request):
        # Check if user has manager permissions
        if not validate_user_permission(request, 'manager'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        # Get the manager session specifically
        manager_session = get_user_from_role_session(request, 'manager')
        if not manager_session:
            return Response({"error": "Manager session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = {'user_id': manager_session.get('user_id')}
        res = get_pending_records_service(data)
        return res
    

class ApproveExpense(APIView):
    def post(self, request):
        print("Approving expense...")
        # Check if user has manager permissions
        if not validate_user_permission(request, 'manager'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        # Get the manager session specifically
        manager_session = get_user_from_role_session(request, 'manager')
        if not manager_session:
            return Response({"error": "Manager session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = manager_session.get('user_id')
        res = approve_expense_service(data)
        return res

class RejectExpense(APIView):
    def post(self, request):
        print("Rejecting expense...")
        # Check if user has manager permissions
        if not validate_user_permission(request, 'manager'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        # Get the manager session specifically
        manager_session = get_user_from_role_session(request, 'manager')
        if not manager_session:
            return Response({"error": "Manager session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = manager_session.get('user_id')
        res = reject_expense_service(data)
        return res

class AllRecords(APIView):
    def get(self, request):
        # Check if user has manager permissions
        if not validate_user_permission(request, 'manager'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        # Get the manager session specifically
        manager_session = get_user_from_role_session(request, 'manager')
        if not manager_session:
            return Response({"error": "Manager session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = {'user_id': manager_session.get('user_id')}
        res = get_all_records_service(data)
        return res