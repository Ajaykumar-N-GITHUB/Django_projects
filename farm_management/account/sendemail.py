import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from rest_framework.response import Response
from rest_framework import status
from account.models import Customer


def send_email(data):
    print("Sending email...")
    sender_email = "ajayjothika17@gmail.com"
    sender_password = "herp ioyd scad tvgl" 
    receiver_email = "ajayjothika17@gmail.com"

   
    subject = "Farm Management - Customer Support"
    body = data['message'] + "\n\n" + \
           "Name: " + data['name'] + "\n" + \
           "Sender Email: " + data['email'] + "\n" 

    
    message = MIMEMultipart()
    message['From'] = sender_email
    message['To'] = receiver_email
    message['Subject'] = subject

    message.attach(MIMEText(body, 'plain'))

    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)
        # server.set_debuglevel(1)
        server.starttls() 
        server.login(sender_email, sender_password)
        server.sendmail(sender_email, receiver_email, message.as_string())
        return Response({'message': "Email sent Successfully. Our IT team will get back to you soon!!!"}, status=status.HTTP_201_CREATED)

    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

    finally:
        server.quit()



def welcome_email(data):
    print("Sending Welcome email...")
    print(data)
    sender_email = "ajayjothika17@gmail.com"
    sender_password = "herp ioyd scad tvgl"
    cust = Customer.objects.get(user_id=data['user_id'])
    receiver_email = cust.email

    subject = "Farm Management - Welcome"
    body = "Dear " + cust.name + ",\n\n" + \
           "Welcome to Farm Management! We're glad to have you on board." + "\n\n" + \
           "Regards" + "\n" + \
           "Farm Management Team"

    message = MIMEMultipart()
    message['From'] = sender_email
    message['To'] = receiver_email
    message['Subject'] = subject

    message.attach(MIMEText(body, 'plain'))

    server = None
    try:
        # Add timeout to prevent hanging
        server = smtplib.SMTP('smtp.gmail.com', 587, timeout=30)
        server.starttls() 
        server.login(sender_email, sender_password)
        server.sendmail(sender_email, receiver_email, message.as_string())
        return True

    except Exception as e:
        print(f"Email error: {e}")
        return False

    finally:
        # Always close connection to free memory
        if server:
            try:
                server.quit()
            except:
                pass

def alert_email(data):
    print("Sending Alert email...")
    print(data)
    cust = Customer.objects.get(user_id=data['user_id'])
    sender_email = "ajayjothika17@gmail.com"
    sender_password = "herp ioyd scad tvgl" 
    receiver_email = cust.email

    subject = "Farm Management - Customer Support"
    body = "Dear " + cust.name + ",\n\n" + \
           "Alert!!: There is a login alert from your account" + "\n" + \
           "If this was not you, please contact support immediately." + "\n\n" + \
           "Regards" + "\n" + \
           "Farm Management Team"

    message = MIMEMultipart()
    message['From'] = sender_email
    message['To'] = receiver_email
    message['Subject'] = subject

    message.attach(MIMEText(body, 'plain'))

    server = None
    try:
        # Add timeout to prevent hanging
        server = smtplib.SMTP('smtp.gmail.com', 587, timeout=30)
        server.starttls() 
        server.login(sender_email, sender_password)
        server.sendmail(sender_email, receiver_email, message.as_string())
        return True

    except Exception as e:
        print(f"Alert email error: {e}")
        return False

    finally:
        # Always close connection to free memory
        if server:
            try:
                server.quit()
            except:
                pass
