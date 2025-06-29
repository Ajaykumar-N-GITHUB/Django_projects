from django.db import models

# Create your models here.

class User(models.Model):
    user_name = models.CharField(max_length=200, blank=False)
    user_mobile = models.CharField(max_length=15, blank=False)
    user_location = models.CharField(max_length=200, blank=False)
    user_dob = models.DateField()
    user_age = models.IntegerField(blank=False)
    user_email = models.EmailField(blank=False)
    user_id = models.CharField(max_length=20, blank=False,unique=True)
    user_passwd = models.CharField(max_length=290, blank=False,unique=True)

    class Meta:
        db_table = 'user_detail'