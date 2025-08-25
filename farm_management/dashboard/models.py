from django.db import models
from account.models import Customer
# Create your models here.


class AddRecord(models.Model):

    type = models.CharField(max_length=50, blank=False)
    item_name = models.CharField(max_length=100, blank=False)
    farm_owner = models.ForeignKey(
    Customer,
    on_delete=models.CASCADE,
    related_name='customer_details',
    to_field='user_id',
    db_column='farm_owner_id'
)

    amount = models.FloatField(blank=False)
    date = models.DateField(blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "item_list"


class Reminder(models.Model):
    user = models.ForeignKey(
        Customer, 
        on_delete=models.CASCADE, 
        related_name='reminder_user',
        to_field='user_id',
        db_column='owner_id',
        default=None, 
        blank=False)
    message = models.TextField(blank=False)
    date = models.DateField(blank=False)
    time = models.TimeField(blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "reminder_list"



class TaskLog(models.Model):
    worker_id = models.CharField(max_length=100, blank=False, default=None)
    user = models.ForeignKey(
        Customer,
        on_delete=models.CASCADE,
        related_name='task_logs',
        to_field='user_id',
        db_column='user_id',
        default=None,
        blank=False
    )
    action = models.CharField(max_length=100000, blank=False)
    date = models.DateField(blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    

    class Meta:
        db_table = "task_logs"
