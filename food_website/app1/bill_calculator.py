from customer.models import CustomerDetail as CD, PurchaseDetail
from app1 import constants as CS
from app1.models import FoodItem as FD
import random
from rest_framework.response import Response
from rest_framework import status


used_order_ids = set()

bill_dict = dict()


def generate_unique_order_id():
    if len(used_order_ids) >= 900000:
        raise Exception("All 6-digit order IDs are used!")

    while True:
        order_id = random.randint(100000, 999999)
        if order_id not in used_order_ids:
            used_order_ids.add(order_id)
            return order_id


def get_items(food_items):
    food_list = list()
    for item, quantity in food_items.items(): 
        food_dict = dict()
        food_dict['name'] = item
        food_dict['quantity'] = quantity
        item = FD.objects.get(item_name = item)
        food_dict['price'] = item.item_price * quantity
        food_list.append(food_dict)
    return food_list


def item_total(items):
    total = 0
    for item in items:
        total += item['price']
    return total


def get_gst(data):
    gst = 0
    for item in data:
        if item == "Bun Butter Jam":
            gst += CS.BUN_BUTTER_JAM
        elif item == "Grilled Sandwhich":
            gst += CS.GRILLED_SANDWHICH
        elif item == "French Fires":
            gst += CS.FRENCH_FRIES
        elif item == "Oreo Milkshake":
            gst += CS.OREO_MILKSHAKE
        elif item == "chocolatey Milkshake":
            gst += CS.CHOCOLATEY_MILKSHAKE
        elif item == "Mango Milkshake":
            gst += CS.MANGO_MILK_SHAKE
        
    return gst
    

def bill_calc(data):

    customer = CD.objects.filter(cust_name=data['cust_name']).latest('created')

    bill_dict['customer_name'] = data['cust_name']
    bill_dict['order_id'] = generate_unique_order_id()
    bill_dict['tips_and_donation'] = customer.tip
    bill_dict['items'] = get_items(customer.food_items)
    bill_dict['item_total'] = item_total(bill_dict['items'])
    bill_dict['GST'] = get_gst(customer.food_items)
    bill_dict['total_amount'] = bill_dict['item_total'] + bill_dict['GST'] + bill_dict['tips_and_donation']


    pd = PurchaseDetail()

    customer = CD.objects.filter(cust_name = bill_dict['customer_name']).latest('created')
    pd.customer_name = customer
    pd.order_id = bill_dict['order_id']
    pd.tips = bill_dict['tips_and_donation']
    pd.items = bill_dict['items']
    pd.item_total = bill_dict['item_total']
    pd.gst = bill_dict['GST']
    pd.total_amount = bill_dict['total_amount']

    pd.save()
    return Response({'customer_id': customer.id}, status=status.HTTP_201_CREATED)




