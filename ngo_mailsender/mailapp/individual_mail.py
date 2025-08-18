import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
from rest_framework.response import Response
from rest_framework import status
from account.models import MailDetails

def seperate_mail(request):
    try:
        uploaded_files = request.FILES.getlist('files')
        
        file_names = [file.name for file in uploaded_files]

        for file in file_names:
            if not file.endswith('.pdf'):
                file_names.remove(file)


        names = []
        emails = []

        for filename in file_names:
            # Remove the .pdf extension
            base = filename.replace('.pdf', '')

            # Split by underscore
            parts = base.split('_')

            # Find the part that contains '@' — that's the email
            for i, part in enumerate(parts):
                if '@' in part:
                    email = part
                    name_parts = parts[:i]  # Everything before the email is name
                    break

            name = ' '.join(name_parts)  # Join the name with space for readability

            # Add to respective lists
            names.append(name)
            emails.append(email)

        res = call_mail(names, emails, request)

        # print("Names:", names)
        # print("Emails:", emails)



        return res

    except FileNotFoundError:
        print("Directory not found. Please check the path.")
    except Exception as e:
       print(str(e))
    



def call_mail(names, emails, request):
    try:
        data = request.POST  # use POST, not request.data in standard Django
        file_list = request.FILES.getlist('files')
       

        for file in file_list:
            if not file.name.endswith('.pdf'):
                file_list.remove(file)


        for name, email, uploaded_file in zip(names, emails, file_list):
            sender_email = "ajayjothika17@gmail.com"
            sender_password = "vqco nkjm crzr ymta"
            receiver_email = email

            mail =MailDetails()

            mail.name = name
            mail.email = email
            mail.save()

            subject = data["subject"]
            body = "Dear " + name + ",\n\n" + \
                "Greetings from ARDSI-Coimbatore Chapter!\n\n" + \
                "Thank you for joining us for the interactive session on " + \
                data['session_name'] + "\n\n" + \
                data['chief_guest'] + "\n\n" + \
                "We appreciate your active participation and hope you found the session insightful and enriching.\n\n" + \
                "Please find attached your certificate of participation for the session facilitated by " + data['chief_guest'] + "\n\n" + \
                "📌 Stay connected with us for upcoming workshops and events:\n\n" + \
                "🔗 LinkedIn: https://www.linkedin.com/company/alzheimer-s-related-disorders-society-of-india-coimbatore-chapter/posts/\n" + \
                "📸 Instagram: https://www.instagram.com/ardsi_cc?igsh=MWg2a2F4cXptdDk1bQ==\n" + \
                "For any queries, feel free to write to us at: ardsicoimbatorechapter@gmail.com\n\n" + \
                "Warm regards,\n" + \
                "Team ARDSI-Coimbatore Chapter\n" + \
                "🌐 https://ardsicc.com/\n" + \
                "📩 ardsicoimbatorechapter@gmail.com\n"

            message = MIMEMultipart()
            message['From'] = sender_email
            message['To'] = receiver_email
            message['Subject'] = subject
            message.attach(MIMEText(body, 'plain'))

            # Attach the file from request
            file_data = uploaded_file.read()
            file_name = uploaded_file.name
            part = MIMEApplication(file_data, Name=file_name)
            part['Content-Disposition'] = f'attachment; filename="{uploaded_file.name}"'
            message.attach(part)

            try:
                server = smtplib.SMTP('smtp.gmail.com', 587)
                server.starttls()
                server.login(sender_email, sender_password)
                server.sendmail(sender_email, receiver_email, message.as_string())

            except Exception as e:
                # return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
                print(str(e))

            finally:
                server.quit()

        return True

    except Exception as e:
        print(str(e))
