import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from rest_framework.response import Response
from rest_framework import status


def send_email(data):
    print("Sending email...")
    sender_email = "ajayjothika17@gmail.com"
    sender_password = "vqco nkjm crzr ymta" 
    receiver_email = "ajayjothika17@gmail.com"

   
    subject = "ARDSI WEB APP - Customer Support"
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
        server.starttls() 
        server.login(sender_email, sender_password)
        server.sendmail(sender_email, receiver_email, message.as_string())
        return Response({'message': "Email sent Successfully. Our IT team will get back to you soon!!!"}, status=status.HTTP_201_CREATED)

    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

    finally:
        server.quit()



