from django.db import models

# Create your models here.

from django.db import models


class Customer(models.Model):
    name = models.CharField(max_length=100, blank=False)
    email = models.EmailField(unique=True, blank=False)
    phone_number = models.CharField(max_length=15, unique=True, blank=False)
    address = models.TextField(blank=True)
    town = models.CharField(max_length=100, blank=True)
    state = models.CharField(max_length=100, blank=True)
    district = models.CharField(max_length=20, blank=True)
    farm_size = models.FloatField(blank=True, null=True)
    user_id = models.CharField(max_length=50, unique=True, blank=False,default=None)
    password = models.CharField(max_length=100, blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "customer_details"
