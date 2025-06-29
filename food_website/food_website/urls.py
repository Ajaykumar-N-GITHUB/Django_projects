"""
URL configuration for food_website project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from food_website.views import home
urlpatterns = [
    path('admin/', admin.site.urls),
    path('',home,name='appview'),
    path('menu/',include('app1.urls')),
    path('user/',include('account.urls')),
    path('bill/',include('app1.urls')),
    path('customer/',include('customer.urls')),
]
