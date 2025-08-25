from django.urls import path
from account.views import Login, Signup,  About, Contact, Resetpassword, Logout, Readme

urlpatterns = [
    path('login',Login.as_view()),
    path('signup', Signup.as_view()),
    path('about', About.as_view()),
    path('contact', Contact.as_view()),
    path('resetpass', Resetpassword.as_view()),
    path('signout', Logout.as_view(), name='logout'),
    path('readme', Readme.as_view()),
    
    
]