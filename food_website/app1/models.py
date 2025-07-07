from django.db import models
from account.models import User
# Create your models here.

from django.db import models


class FoodItem(models.Model):
    item_name = models.CharField(max_length=200, unique=True, blank=False)
    item_desc = models.CharField(max_length=200)
    item_price = models.IntegerField(blank=False,default=0)
    item_owner = models.ForeignKey(User, on_delete=models.CASCADE, related_name='food_items')
    item_owner_user_id = models.CharField(max_length=100, blank=False, default=None)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "food_details"


