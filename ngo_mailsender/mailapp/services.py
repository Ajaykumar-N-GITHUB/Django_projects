
from mailapp.individual_mail import seperate_mail

def mail_service(request):
    res = seperate_mail(request)
    return res