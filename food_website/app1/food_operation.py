from rest_framework.response import Response
from app1.models import FoodItem
from account.models import User

def add_fooditem(data):

    try:
        food = FoodItem()

        food.item_name = data['item_name']
        food.item_desc = data['item_desc']
        food.item_price = data['item_price']
        food.item_owner_user_id = data['item_owner_id']
        user = User.objects.get(user_id = data['item_owner_id'])
        food.item_owner = user
        food.save()
        return "success"
    
    except Exception as e:
        return str(e)
    
# def display_fooditem():
#     items = FoodItem.objects.all()
#     data = [
#         {
#             "name": item.item_name,
#             "price": float(item.item_price),  # Convert Decimal to float
#             "description": item.item_desc
#         }
#         for item in items
#     ]
#     return data

    
    
    