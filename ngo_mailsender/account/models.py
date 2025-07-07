from django.db import models

# Create your models here.


class UserDetails(models.Model):
    name = models.CharField(max_length=100, blank=False, default=None)
    email = models.EmailField(max_length=100, blank=False, default=None)
    phone = models.CharField(max_length=15,blank=False, default=None)
    user_id = models.CharField(max_length=50, unique=True, blank=False, default=None)
    password = models.CharField(max_length=128, blank=False, default=None)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)    

    class Meta:
        db_table = "user_details"

class MailDetails(models.Model):
    name = models.CharField(max_length=100, blank=False, default=None)
    email = models.EmailField(max_length=100, blank=False, default=None)
    created_at = models.DateTimeField(auto_now_add=True)    
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "mail_details"