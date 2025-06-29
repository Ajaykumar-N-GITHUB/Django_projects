from django.urls import path,include
from account.views import Login,Logout,Signup,ForgetPasswd

urlpatterns = [
    # path('',views.view1,name='appview'),
    path('login',Login.as_view()),
    path('logout',Logout.as_view()),
    path('signup',Signup.as_view()),
    path('forgot-password',ForgetPasswd.as_view()),
]