from django.urls import path
from account.views import Login, Signup,  About, Contact, Resetpassword, Logout, Readme, Manage
from account.views import Pendingrecord, ApproveExpense, RejectExpense, AllRecords

urlpatterns = [
    path('login',Login.as_view()),
    path('signup', Signup.as_view()),
    path('about', About.as_view()),
    path('contact', Contact.as_view()),
    path('resetpass', Resetpassword.as_view()),
    path('signout', Logout.as_view(), name='logout'),
    path('readme', Readme.as_view()),
    path('manage', Manage.as_view()),
    path('fetch_pending_records', Pendingrecord.as_view()),
    path('fetch_all_records', AllRecords.as_view()),
    path('approve-expense', ApproveExpense.as_view()),
    path('reject-expense', RejectExpense.as_view()),
]
