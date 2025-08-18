from django.shortcuts import render
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from app1.services import add_food, bill_download
from app1.models import FoodItem
# Create your views here.


class FoodOperation(APIView):

    def post(self, request, format=None):
        res = add_food(request.data)
        if res == "success":
            return Response({"message": "Item added successfully"}, status=status.HTTP_201_CREATED)
        else:
            return Response(res, status=status.HTTP_400_BAD_REQUEST)
        

class DisplayFood(APIView):
    def get(self, request, format=None):
        food_items = FoodItem.objects.all()
        return render(request, 'menu_display.html', {'items': food_items})
        

class BillGenerater(APIView):
    def post(self, request, format=None):
        res = bill_download(request.data)
        return res


