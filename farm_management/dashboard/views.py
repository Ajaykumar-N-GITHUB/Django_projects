from django.shortcuts import render
from rest_framework.views import APIView
from dashboard.liveweather import get_weather
from dashboard.services import add_record_services, fetch_record_services, profit_loss_services, delete_record_services, worker_dashboard_services
from dashboard.services import set_reminder_services, pie_bar_services, future_expenses_services, report_download_services, update_record_services
from dashboard.services import add_worker_services, remove_worker_services, worker_long_input_services, log_download_services
from rest_framework.response import Response
from rest_framework import status
from account.models import Customer, Worker
from account.auth_utils import role_required, get_user_role
from account.session_utils import get_current_user_session, validate_user_permission, get_user_context, get_user_from_role_session

def get_safe_current_user(request, required_role=None):
    """
    Safely get current user with fallback to role-specific session
    """
    current_user = get_current_user_session(request)
    
    # If current_user is None and we have a required role, try role-specific session
    if current_user is None and required_role:
        current_user = get_user_from_role_session(request, required_role)
    
    return current_user

# Create your views here.

class Dashboard(APIView):
    
    def get(self, request):
        # Get role parameter from URL if provided
        role_param = request.GET.get('role')
        user_id_param = request.GET.get('user_id')
        
        # Get current user context
        current_user = get_current_user_session(request)
        
        # If no user is logged in and no parameters provided, redirect to login
        if not current_user and not (role_param and user_id_param):
            return render(request, 'login.html')
        
        # Use URL parameters if available, otherwise use session data
        if role_param and user_id_param:
            # Validate that the user exists and has the correct role
            if role_param == 'owner':
                customer = Customer.objects.filter(user_id=user_id_param, role='owner').first()
                if not customer:
                    return render(request, 'login.html')
                user_id = user_id_param
                user_role = 'owner'
            elif role_param in ['manager', 'worker']:
                worker = Worker.objects.filter(worker_id=user_id_param, worker_role=role_param).first()
                if not worker:
                    return render(request, 'login.html')
                user_id = user_id_param
                user_role = role_param
            else:
                return render(request, 'login.html')
        else:
            # Use session data
            user_id = current_user.get('user_id')
            user_role = current_user.get('user_role')
        
        # Route based on user role
        if user_role == 'owner':
            weather_data = get_weather(user_id)
            context = {
                'user_name': user_id,
                'user_role': user_role,
                'weather_data': weather_data
            }
            return render(request, 'dashboard.html', context)
        
        elif user_role == 'manager':
            context = {
                'user_name': user_id,
                'user_role': user_role
            }
            return render(request, 'manager.html', context)
        
        elif user_role == 'worker':
            context = {
                'user_name': user_id,
                'user_role': user_role
            }
            return render(request, 'worker_dashboard.html', context)
        
        # If no valid role found, redirect to login
        return render(request, 'login.html')



class AddRecordView(APIView):
    
    def post(self, request):
        # Check if user has owner permissions
        if not validate_user_permission(request, 'owner'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        current_user = get_user_from_role_session(request, 'owner')
        if current_user is None:
            return Response({"error": "Owner session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = add_record_services(data)
        if res is True:
            return Response("message: Record added successfully",status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        

class GetRecordView(APIView):

    def get(self, request):
        current_user = get_safe_current_user(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = fetch_record_services(data)
        if res:
           return Response({
                    "message": "Records fetched successfully",
                    "items": res
                }, status=status.HTTP_200_OK)

        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)

class UpdateRecordView(APIView):

    def put(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = update_record_services(data)
        if res is True:
            return Response({"message": "Record updated successfully"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)


class RemoveRecordView(APIView):

    def delete(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = delete_record_services(data)
        if res is True:
            return Response({"message": "Record deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)


class ProfitLossView(APIView):

    def post(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = profit_loss_services(data)
        
        if res:
            return Response({
                "message": "Profit and loss calculated successfully",
                "data": res
            }, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        

class SetReminderView(APIView):

    def post(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = set_reminder_services(data)
        
        if res is True:
            return Response({"message": "Reminder set successfully"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        


class PieBarView(APIView):

    def get(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = pie_bar_services(data)
        if res:
            return Response({
                "data": res
            }, status=status.HTTP_200_OK)

        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        


class FutureExpensesView(APIView):

    def get(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = future_expenses_services(data)
        if res:
           return Response({
                    "message": "Records fetched successfully",
                    "items": res
                }, status=status.HTTP_200_OK)

        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        



class ReportDownloadView(APIView):

    def post(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = report_download_services(data)
        if res:
            return res
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        


class WorkerDashboardView(APIView):

    def post(self, request):
        current_user = get_safe_current_user(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = worker_dashboard_services(data)
        if res is True:
            return Response({"message": res}, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        

class AddWorkerView(APIView):

    def post(self, request):
        # Check if user has owner permissions
        if not validate_user_permission(request, 'owner'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        # Get owner session directly - don't use the general session
        current_user = get_user_from_role_session(request, 'owner')
        if current_user is None:
            return Response({"error": "Owner session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        # Debug logging
        print(f"DEBUG AddWorker - Original request.data: {request.data}")
        print(f"DEBUG AddWorker - current_user (owner): {current_user}")
        print(f"DEBUG AddWorker - user_id from owner session: {current_user.get('user_id')}")
        
        # Create new data dict and FORCE the user_id to be the owner's ID
        data = {}
        data['worker_name'] = request.data.get('worker_name')
        data['worker_id'] = request.data.get('worker_id') 
        data['worker_passwd'] = request.data.get('worker_passwd')
        data['worker_phone_number'] = request.data.get('worker_phone_number')
        data['worker_role'] = request.data.get('worker_role')
        data['user_id'] = current_user.get('user_id')  # FORCE this to be owner's ID
        
        print(f"DEBUG AddWorker - Final data being sent to service: {data}")
        
        res = add_worker_services(data)
        if res is True:
            return Response({"message": "✅ Worker added successfully"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)

class RemoveWorkerView(APIView):

    def post(self, request):
        # Check if user has owner permissions
        if not validate_user_permission(request, 'owner'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        print(request.data)
        current_user = get_user_from_role_session(request, 'owner')
        if current_user is None:
            return Response({"error": "Owner session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        print(data)
        res = remove_worker_services(data)
        if res is True:
            print("success")
            return Response({"message": "Worker removed successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        

class WorkerLongInputView(APIView):

    def post(self, request):
        # Check if user has worker permissions
        if not validate_user_permission(request, 'worker'):
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        current_user = get_user_from_role_session(request, 'worker')
        if current_user is None:
            return Response({"error": "Worker session not found"}, status=status.HTTP_401_UNAUTHORIZED)
            
        print(current_user.get('user_id'))
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        print(data)
        res = worker_long_input_services(data)
        if res is True:
            return Response({"message": "Long input processed successfully"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)

class LogDownloadView(APIView):

    def post(self, request):
        current_user = get_current_user_session(request)
        if not current_user:
            return Response({"error": "Authentication required"}, status=status.HTTP_401_UNAUTHORIZED)
            
        data = request.data.copy()
        data['user_id'] = current_user.get('user_id')
        res = log_download_services(data)
        print(res)
        if res.status_code == 200:
            return res
        if res.status_code == 404:
            return Response({"error": "No logs found for this worker"}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)