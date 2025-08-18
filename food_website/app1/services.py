from app1.food_operation import add_fooditem
from app1.bill_generator import generate_pdf

def add_food(data):
    res = add_fooditem(data)
    return res


# def display_food():
#     res = display_fooditem()
#     return res

def bill_download(data):
    res = generate_pdf(data)
    return res