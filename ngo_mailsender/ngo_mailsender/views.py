from django.shortcuts import render


def HomeView(request):
    return render(request, '/Users/ajaykumar-n/Documents/DJANGO/Django_projects/ngo_mailsender/webApp/home.html')


