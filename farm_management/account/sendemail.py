from django.core.mail import send_mail
from django.conf import settings

def send_support_request(data):
    print(data)
    subject = "Farm Management Support"
    message = data['message']
    from_email = settings.DEFAULT_FROM_EMAIL
    recipient_list = [data['email']]

    send_mail(subject, message, from_email, recipient_list, fail_silently=False)


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

