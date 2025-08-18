from django.urls import path
from customer.views import AddCustomer, UpdateCustomer, DeleteCustomer
urlpatterns = [
    path('add',AddCustomer.as_view(), name='add_customer'),
    path('update',UpdateCustomer.as_view()),
     path('delete',DeleteCustomer.as_view())

]