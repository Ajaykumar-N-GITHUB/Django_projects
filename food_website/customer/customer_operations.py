from app1 import bill_calculator

from customer.models import CustomerDetail
from rest_framework.response import Response
from rest_framework import status




def AddCustomer(data):
    cd = CustomerDetail()
    cd.cust_name = data['cust_name']
    cd.mob_num = data['mob_num']
    cd.dob = data['dob']
    cd.tip = data['tip']
    customer_tip = int(data['tip'])
    if customer_tip >=0:
        cd.tip = data['tip']
    else:
        return Response({"message": "Please enter Zero if you are not interested in tip"}, status=status.HTTP_404_NOT_FOUND)
    if len(data['food_items']) == 0:
        return Response({"message": "Please select at least one food item"}, status=status.HTTP_404_NOT_FOUND)
    cd.food_items = data['food_items']
    cd.save()
    res = bill_calculator.bill_calc(data)
    if res:
        return res




def ModifyCustomer(data):
    return None

def DeleteCustomer(data):
    pass