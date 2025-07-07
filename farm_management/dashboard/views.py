from django.shortcuts import render
from rest_framework.views import APIView
from dashboard.liveweather import get_weather
from dashboard.services import add_record_services, fetch_record_services, profit_loss_services, delete_record_services
from dashboard.services import set_reminder_services, pie_bar_services, future_expenses_services, report_download_services
from rest_framework.response import Response
from rest_framework import status
# Create your views here.

class Dashboard(APIView):
    
    def get(self, request):
        user_id = request.session.get('user_id')
        weather_data = get_weather(user_id)
        context = {
            'user_name': user_id,
            'weather_data': weather_data
            }
        return render(request, 'dashboard.html', context)
   


class AddRecordView(APIView):
    
    def post(self, request):
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
        res = add_record_services(data)
        if res is True:
            return Response("message: Record added successfully",status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        

class GetRecordView(APIView):

    def get(self, request):
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
        res = fetch_record_services(data)
        if res:
           return Response({
                    "message": "Records fetched successfully",
                    "items": res
                }, status=status.HTTP_200_OK)

        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)


class RemoveRecordView(APIView):

    def delete(self, request):
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
        res = delete_record_services(data)
        if res is True:
            return Response({"message": "Record deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)


class ProfitLossView(APIView):

    def post(self, request):
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
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
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
        res = set_reminder_services(data)
        
        if res is True:
            return Response({"message": "Reminder set successfully"}, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        


class PieBarView(APIView):

    def get(self, request):
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
        res = pie_bar_services(data)
        if res:
            return Response({
                "data": res
            }, status=status.HTTP_200_OK)

        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        


class FutureExpensesView(APIView):

    def get(self, request):
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
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
        user_id = request.session.get('user_id')
        data = request.data.copy()
        data['user_id'] = user_id
        res = report_download_services(data)
        if res:
            return res
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)
        