from django.db import models
from jsonfield import JSONField
# Create your models here.


class CustomerDetail(models.Model):
    cust_name = models.CharField(max_length=150, blank=False)
    mob_num = models.CharField(max_length=15, blank=False, default=None)
    dob = models.DateField(blank=False)
    food_items = models.JSONField(default={})
    tip = models.IntegerField(max_length=4, blank=True, default=0)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        db_table='customer_detail'


class PurchaseDetail(models.Model):
    customer_name = models.ForeignKey(CustomerDetail, on_delete=models.CASCADE)
    order_id = models.IntegerField(max_length=10, unique=True)
    items = models.JSONField(default={})
    item_total = models.IntegerField(max_length=5)
    gst = models.IntegerField(max_length=5)
    tips = models.IntegerField(max_length=5)
    total_amount = models.IntegerField(max_length=5)

    class Meta:
        db_table = 'purchase_detail'









    # data = {
    # "customer_name": "Arjun",
    # "order_id": 213243,
    # "items": [
    #     {"name": "item1", "quantity": 1, "price": 19},
    #     {"name": "item2", "quantity": 2, "price": 23},
    #     {"name": "item3", "quantity": 1, "price": 12},
    #     {"name": "item4", "quantity": 1, "price": 34},
    # ],
    # "item_total": 678,
    # "GST" : 54,
    # "tips_and_donation": 50,
    # "total_amount": 789
    # }