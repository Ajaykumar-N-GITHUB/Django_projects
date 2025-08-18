from django.shortcuts import render
from rest_framework.views import APIView
from mailapp.services import mail_service
from rest_framework.response import Response
from rest_framework import status
# Create your views here.


class DisplayView(APIView):

    def get(self, request):
        return render(request, 'display.html')

    def post(self, request):
        res = mail_service(request)
        if res is True:
            return Response({"message": "Mail Sent Successfuly"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": res}, status=status.HTTP_400_BAD_REQUEST)