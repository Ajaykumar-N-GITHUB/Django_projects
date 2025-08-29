from rest_framework import status
from account.models import Customer
from django.core.mail import EmailMessage
from django.core.mail import send_mail



def send_support_request(data):
    print("Sending support email...")
    print(data)
    email = EmailMessage(
        subject=f"Support request from {data['name']}",
        body=data['message'],
        from_email=data['email'], 
        to=["ajayjothika17@gmail.com"],
    )
    email.send()



# def send_alert_email(data):
#     cust = Customer.objects.get(user_id=data['user_id'])
#     receiver_email = cust.email
#     subject = "Login Alert"
#     message = f"Hi {data['name']},\n\nA login was detected to your account."
#     send_mail(subject, message, None, [receiver_email])


# def send_reminder_email(user, reminder_message):
#     subject = "Farm Reminder"
#     message = f"Hi {user.name},\n\nThis is a reminder: {reminder_message}"
#     send_mail(subject, message, None, [user.email])



# def send_welcome_email(data):
#     cust = Customer.objects.get(user_id=data['user_id'])
#     receiver_email = cust.email
#     subject = "Welcome to Farm Management!"
#     message = f"Hi {data['name']},\n\nThank you for signing up."
#     send_mail(subject, message, None, [receiver_email])

