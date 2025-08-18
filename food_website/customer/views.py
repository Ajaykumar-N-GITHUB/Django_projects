from django.shortcuts import render
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from customer.services import insert_customer, modify_customer, remove_customer
# Create your views here.


class AddCustomer(APIView):

    def post(self, request, format=None):
        res = insert_customer(request.data)
        return res
        
        
    def get(self, request, format=None):
        return render(request, '/Users/ajaykumar-n/Documents/DJANGO/Django_projects/food_website/webApp/order.html')
        
class UpdateCustomer(APIView):

    def post(self, request, format=None):
        res ,cust_info= modify_customer(request.data)
        if res == "success":
            return Response({f"message": "Customer Details Updated Successfully"}, status=status.HTTP_200_OK)
        else:
            return Response(res, status=status.HTTP_400_BAD_REQUEST)
        
class DeleteCustomer(APIView):

    def post(self, request, format=None):
        res = remove_customer(request.data)
        if res == "success":
            return Response({"message": "Customer removed successfully"})
        else:
            return Response(res, status=status.HTTP_400_BAD_REQUEST)
        