from dashboard.models import AddRecord
from account.models import Customer
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from rest_framework.response import Response
from rest_framework import status
from dashboard.models import Reminder
from datetime import datetime
from django.utils import timezone
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from io import BytesIO
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib import colors
from reportlab.platypus import (
    SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
)

def add_record(data):
    
    print("Received data:", data)
    user = Customer.objects.get(user_id=data['user_id'])
    try:
        record = AddRecord()
        record.farm_owner = user
        record.type = data['record_type']
        record.item_name = data['item_name']
        record.date = data['record_date']
        record.amount = data['amount']
        record.save()
    except Exception as e:
        print("Error while adding record:", e)
        return str(e)   

    return True

def get_records(data):
    try:
        user = Customer.objects.get(user_id=data['user_id'])
        records = AddRecord.objects.filter(farm_owner=user, type='Investment')

        
        items = []
        for r in records:
            items.append({
                    'id': r.id,
                    'item_name': r.item_name,
                    'amount': r.amount,
                    'date': r.date.strftime('%Y-%m-%d'),
                })
        return items
    except Exception as e:
        print("Error while fetching records:", e)
        return str(e)
    

def delete_record(data):
    try:
        user = AddRecord.objects.filter(id=data['id'], item_name=data['item_name'], amount=data['amount']).first()
        if user:
            user.delete()
            return True
        else:            
            return "Record not found"
    except Exception as e:
        return str(e)

       
    

def profit_loss_calc(data):
    try:
        user = Customer.objects.get(user_id=data['user_id'])
        records = AddRecord.objects.filter(farm_owner=user, type='Investment')
        total_investment = sum(record.amount for record in records)
        # print(total_investment)
        profit_records = AddRecord.objects.filter(farm_owner=user, type='Harvest')
        total_profit = sum(record.amount for record in profit_records)
        # print(total_profit)
        profit_loss = total_profit - total_investment
        # print(profit_loss)
        return {
            'total_investment': total_investment,
            'total_profit': total_profit,
            'profit_loss': profit_loss
        }
    except Exception as e:
        print("Error while calculating profit/loss:", e)
        return str(e)
    

def pie_bar(data):
    try:
        user = Customer.objects.get(user_id=data['user_id'])
        investment_records = AddRecord.objects.filter(farm_owner=user, type='Investment')
        total_investment = sum(record.amount for record in investment_records)

        harvest_records = AddRecord.objects.filter(farm_owner=user, type='Harvest')
        total_harvest = sum(record.amount for record in harvest_records)

        profit_loss = total_harvest - total_investment

        data= {
            'total_investment': total_investment,
            'total_profit': total_harvest,
            'profit_loss': profit_loss
        }
        return data

    except Exception as e:
        return str(e)



def set_reminder(data):

    try:
        dt_obj = datetime.strptime(data['datetime'], "%Y-%m-%dT%H:%M")
        user = Customer.objects.get(user_id=data['user_id'])
        reminder_date = dt_obj.date()
        reminder_time = dt_obj.time()
        print(type(reminder_date))
        reminder = Reminder()
        reminder.user = user
        reminder.message = data['message']
        reminder.date = reminder_date
        reminder.time = reminder_time
        reminder.save()
        return True
    except Exception as e:
        print("Error while setting reminder:", e)
        return str(e)


def send_reminder(user_id):
    try:
        print(user_id)
        user = Customer.objects.get(user_id=user_id)
        sender_email = "ajayjothika17@gmail.com"
        sender_password = "vqco nkjm crzr ymta"
        receiver_email = user.email
        subject = "Reminder from Farm Management"
        today_date = timezone.localtime(timezone.now()).date()
        print(today_date)
        reminder_messsage = Reminder.objects.filter(user=user, date = today_date).first().message
        message = f"Dear {user.name},\n\nThis is a reminder for your upcoming task: {reminder_messsage}.\n\nBest regards,\nFarm Management Team"
        body = message

    
        message = MIMEMultipart()
        message['From'] = sender_email
        message['To'] = receiver_email
        message['Subject'] = subject

        message.attach(MIMEText(body, 'plain'))
        
        reminder_date = Reminder.objects.filter(user=user, date = today_date).first().date
        try:
            if today_date == reminder_date:
                server = smtplib.SMTP('smtp.gmail.com', 587)
                server.starttls() 
                server.login(sender_email, sender_password)
                server.sendmail(sender_email, receiver_email, message.as_string())
                return True

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

        finally:
            server.quit()

    except Exception as e:
        print("Error while setting reminder:", e)
        return str(e)
    

def future_expenses(data):
    try:
        record_list = []
        user = Customer.objects.get(user_id=data['user_id'])
        records = AddRecord.objects.filter(farm_owner=user, type='Investment')
        for record in records:
            if record.item_name in['crop', 'rice', 'maize', 'wheat', 'millets','pulses','Sugarcane','groundnut','cotton','coconut','tea','coffee','rubber','fruit','vegetable']:
                record_list.append({
                    'investment': record.item_name,
                    'amount': 1500,
                    'reason': "Pesticide"
                })
                record_list.append({
                    'investment': record.item_name,
                    'amount': 1000,
                    'reason': "Human wages"
                })
            elif record.item_name in ['poultry', 'cow', 'goat', 'sheep', 'pig','horse','duck','turkey','fish','hen','cows','goats','buffalo','buffaloes']:
                record_list.append({
                    'investment': record.item_name,
                    'amount': 1000,
                    'reason': "Feed"
                })
                record_list.append({
                    'investment': record.item_name,
                    'amount': 250,
                    'reason': "Healthcare"
                })
            elif record.item_name in ['tractor', 'plough', 'harvester', 'irrigation system', 'sprayer','fertilizer spreader','seed drill']:
                record_list.append({
                    'investment': record.item_name,
                    'amount': 2000,
                    'reason': "Maintenance"
                })
            
        return record_list
        
    except Exception as e:
        print("Error while calculating future expenses:", e)
        return str(e)
    


def report_download(data):
    report_type = data.get('type')
    user_id = data.get('user_id')

    if not report_type or not user_id:
        return HttpResponse("Missing type or user_id", status=400)

    today = datetime.now()
    user = Customer.objects.get(user_id=user_id)
    queryset = AddRecord.objects.filter(farm_owner=user)

    if report_type == 'month':
        queryset = queryset.filter(date__year=today.year, date__month=today.month)
        title = f"Monthly Report - {today.strftime('%B %Y')}"
    elif report_type == 'year':
        queryset = queryset.filter(date__year=today.year)
        title = f"Yearly Report - {today.year}"
    else:
        return HttpResponse("Invalid report type", status=400)

    # PDF Setup
    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=A4, rightMargin=40, leftMargin=40, topMargin=60, bottomMargin=40)
    styles = getSampleStyleSheet()
    elements = []

    # Title and intro
    title_style = ParagraphStyle(name="Title", fontSize=20, alignment=1, textColor=colors.HexColor('#2e8b57'), spaceAfter=10)
    subtitle_style = ParagraphStyle(name="Subtitle", fontSize=14, alignment=1, textColor=colors.black, spaceAfter=20)
    footer_style = ParagraphStyle(name="Footer", fontSize=11, alignment=1, textColor=colors.HexColor('#2e8b57'))

    elements.append(Paragraph("Farm Financial Report", title_style))
    elements.append(Spacer(1, 25))
    elements.append(Paragraph(title, subtitle_style))
    elements.append(Paragraph(f"Welcome <b>{user.user_id}</b>, here is your summarized farm report.", styles['Normal']))
    elements.append(Spacer(1, 25))

    # Table content -1 
    profit_loss = profit_loss_calc(data)
    data_table = [["Type", "Item", "Amount (Rs.)", "Date"]]

    summary_data = [
    ['Metric', 'Amount (Rs.)'],
    ['Total Investment', f"Rs. {profit_loss.get('total_investment', 0):,.2f}"],
    ['Total Profit(Harvest)', f"Rs. {profit_loss.get('total_profit', 0):,.2f}"],
    ['Net Profit/Loss', f"Rs. {profit_loss.get('profit_loss', 0):,.2f}"]
]

    summary_table = Table(summary_data, colWidths=[200, 200])
    summary_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#2e8b57')),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica-Bold'),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTSIZE', (0, 0), (-1, -1), 11),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 8),
        ('BACKGROUND', (0, 1), (-1, -1), colors.whitesmoke),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
    ]))
    elements.append(summary_table)
    elements.append(Spacer(1, 30))


    # Table content -2
    data_table = [["Type", "Item", "Amount (Rs.)", "Date"]]
    for record in queryset:
        data_table.append([
            record.type,
            record.item_name,
            f"Rs. {record.amount}",
            record.date.strftime("%Y-%m-%d")
        ])

    # Table styling
    table = Table(data_table, colWidths=[80, 150, 120, 120])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#2e8b57')),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica-Bold'),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('BACKGROUND', (0, 1), (-1, -1), colors.whitesmoke),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.whitesmoke, colors.lightgrey]),
    ]))

    elements.append(table)
    elements.append(Spacer(1, 30))
    elements.append(Paragraph("Thank you for using the Farm Management System ", footer_style))
    elements.append(Spacer(1, 50))
    elements.append(Paragraph("Generated on " + today.strftime("%B %d, %Y %H:%M"), styles['Normal']))

    # Build PDF
    doc.build(elements)
    buffer.seek(0)
    return HttpResponse(buffer, content_type='application/pdf')

