from django.urls import path
from account.views import AboutView, ContactView, LoginView, SignupView, LogoutView, ResetpasswordView

urlpatterns = [
    path('about', AboutView.as_view()),
    path('contact', ContactView.as_view()),
    path('login', LoginView.as_view(), name='login'),
    path('signup',SignupView.as_view(), name='signup'),
    path('signout', LogoutView.as_view(), name='logout'),
    path('resetpass', ResetpasswordView.as_view()),
   
]