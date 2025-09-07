from pydoc import doc, text
from urllib import response
from dashboard.models import AddRecord, Attendance
from account.models import Customer, Worker
import smtplib
import joblib
import os
import re
from langdetect import detect
import spacy
from word2number import w2n
from django.conf import settings
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
from reportlab.platypus import Paragraph
from reportlab.lib.styles import getSampleStyleSheet

from django.utils.timezone import now, timedelta
from dashboard.models import AddRecord, TaskLog
import spacy
from pathlib import Path
import requests
import uuid
import json
import google.generativeai as genai


genai_apikey = os.environ.get("genai_key")
subscription_key = os.environ.get("azure_key")


nlp = spacy.load("en_core_web_sm")
model_path = os.path.join(settings.BASE_DIR, 'farm_management', 'rf_expense_model.pkl')
encoder_path = os.path.join(settings.BASE_DIR, 'farm_management', 'label_encoder.pkl')

endpoint = "https://api.cognitive.microsofttranslator.com/"



model = joblib.load(model_path)
label_encoder = joblib.load(encoder_path)

def add_record(data):
    
    print("Received data:", data)
    transcript_value = data.get('transcript')
    record = AddRecord()
    if transcript_value:
        worker = Worker.objects.get(worker_id=data['user_id'])
        if worker:
            data['owner_id'] = worker.owner.user_id
        else:
            return "Worker not found"
        
        user = Customer.objects.get(user_id=data['owner_id'])
    else:
        user = Customer.objects.get(user_id=data['user_id'])
        record.status = "approved"
    try:
        record.farm_owner = user
        record.worker_id = data['user_id']
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
        records = AddRecord.objects.filter(farm_owner=user, status='approved')

        items = []
        for r in records:
            items.append({
                    'id': r.id,
                    'item_name': r.item_name,
                    'type': r.type,
                    'amount': r.amount,
                    'date': r.date.strftime('%Y-%m-%d'),
                })
        return items
    except Exception as e:
        print("Error while fetching records:", e)
        return str(e)
    

def update_record(data):
    try:
        user = Customer.objects.get(user_id=data['user_id'])
        record = AddRecord.objects.filter(id=data['id'], farm_owner=user).first()
        if record:
            if 'item_name' in data:
                record.item_name = data['item_name']
            if 'amount' in data:
                record.amount = data['amount']
            if 'date' in data:
                record.date = data['date']
            record.save()
            return True
        else:
            return "Record not found"
    except Exception as e:
        print("Error while updating record:", e)
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


def add_attendance(data):
    try:
        print(data)
        user = Customer.objects.get(user_id=data['user_id'])
        
        # Check if worker exists
        try:
            worker = Worker.objects.get(worker_id=data['worker_id'], owner=user)
        except Worker.DoesNotExist:
            return {
                "success": False,
                "message": f"Worker with ID {data['worker_id']} not found for this user"
            }
        
        # Check if attendance already exists for this date and worker
        existing_attendance = Attendance.objects.filter(
            worker=worker,
            date=data['date']
        ).first()
        
        if existing_attendance:
            # Update existing record
            existing_attendance.status = data['status']
            if 'remarks' in data and data['remarks']:
                existing_attendance.remarks = data['remarks']
            existing_attendance.save()
            return {
                "success": True,
                "message": "Attendance record updated successfully",
                "data": {
                    "id": existing_attendance.id,
                    "worker_id": worker.worker_id,
                    "worker_name": worker.worker_name,
                    "date": data['date'],
                    "status": data['status']
                }
            }
        
        # Create new attendance record
        attendance = Attendance()
        attendance.worker = worker
        attendance.date = data['date']
        attendance.status = data['status']
        if 'remarks' in data and data['remarks']:
            attendance.remarks = data['remarks']
        attendance.save()
        
        return {
            "success": True,
            "message": "Attendance added successfully",
            "data": {
                "id": attendance.id,
                "worker_id": worker.worker_id,
                "worker_name": worker.worker_name,
                "date": data['date'],
                "status": data['status']
            }
        }
    except Exception as e:
        print("Error while adding attendance:", e)
        return {
            "success": False,
            "message": str(e)
        }

def get_attendance(data):
    print("DEBUG get_attendance - Input data:")
    print(data)
    try:
        user = Customer.objects.get(user_id=data['user_id'])
        
        # Base query
        query = Attendance.objects.filter(worker__owner=user)
        
        # Apply date filters - default to current month if not specified
        if 'date' in data and data['date']:
            # If exact date is provided, filter by that date
            query = query.filter(date=data['date'])
        elif 'start_date' in data and data['start_date'] and 'end_date' in data and data['end_date']:
            # If start and end dates are provided, filter by date range
            query = query.filter(date__gte=data['start_date'], date__lte=data['end_date'])
        elif 'month' in data and data['month'] and 'year' in data and data['year']:
            # If month and year are provided, filter by month
            query = query.filter(date__month=data['month'], date__year=data['year'])
        elif 'year' in data and data['year']:
            # If only year is provided, filter by year
            query = query.filter(date__year=data['year'])
        else:
            # Default: current month
            today = datetime.now()
            query = query.filter(date__month=today.month, date__year=today.year)
            
        # Filter by worker if specified
        if 'worker_id' in data and data['worker_id']:
            query = query.filter(worker__worker_id=data['worker_id'])
            
        # Filter by status if specified
        if 'status' in data and data['status']:
            query = query.filter(status=data['status'])
        
        # Apply sorting - newest first by default
        query = query.order_by('-date')
        
        # Apply pagination
        page = int(data.get('page', 1))
        page_size = int(data.get('page_size', 7))  # Default to 7 records per page

        # Calculate pagination
        total_records = query.count()
        total_pages = (total_records + page_size - 1) // page_size  # Ceiling division
        
        # Get records for current page
        start = (page - 1) * page_size
        end = start + page_size
        attendance_records = query.select_related('worker')[start:end]
        
        items = []
        for r in attendance_records:
            items.append({
                'id': r.id,
                'worker_id': r.worker.worker_id,
                'worker_name': r.worker.worker_name,
                'date': r.date.strftime('%Y-%m-%d'),
                'status': r.status,
                'remarks': r.remarks if hasattr(r, 'remarks') else None
            })
            
        # Calculate summary statistics (for current page only)
        present_count = sum(1 for r in items if r['status'] == 'Present')
        absent_count = sum(1 for r in items if r['status'] == 'Absent')
        leave_count = sum(1 for r in items if r['status'] == 'Leave')
        
        # Calculate summary for all matching records (not just current page)
        all_present = query.filter(status='Present').count()
        all_absent = query.filter(status='Absent').count() 
        all_leave = query.filter(status='Leave').count()
        
        return {
            'success': True,
            'message': 'Attendance records fetched successfully',
            'attendance': items,
            'pagination': {
                'current_page': page,
                'total_pages': total_pages,
                'page_size': page_size,
                'total_records': total_records
            },
            'summary': {
                'present': present_count,
                'absent': absent_count,
                'leave': leave_count,
                'total': len(items)
            },
            'overall_summary': {
                'present': all_present,
                'absent': all_absent,
                'leave': all_leave,
                'total': total_records
            }
        }
    except Exception as e:
        print("Error while fetching attendance records:", e)
        return {
            'success': False,
            'message': str(e),
            'attendance': []
        }


def add_worker(data):
    print(f"DEBUG add_worker - Input data: {data}")

    try:
        if Worker.objects.filter(worker_id=data['worker_id']).exists():
            return "Worker Id already exists. Please choose a different one"
        if Worker.objects.filter(phone_number=data['worker_phone_number']).exists():
            return "Phone number already exists. Please choose a different one"
        else:
            print(f"DEBUG add_worker - Looking for Customer with user_id: {data['user_id']}")
            
            # Check if the user exists in Customer table
            try:
                user = Customer.objects.get(user_id=data['user_id'])
                print(f"DEBUG add_worker - Found Customer: {user.user_id}, role: {user.role}")
            except Customer.DoesNotExist:
                print(f"DEBUG add_worker - Customer with user_id '{data['user_id']}' does not exist")
                # Let's check what customers actually exist
                all_customers = Customer.objects.all().values('user_id', 'role', 'name')
                print(f"DEBUG add_worker - Available customers: {list(all_customers)}")
                return f"Customer with user_id '{data['user_id']}' does not exist. Available customers: {[c['user_id'] for c in all_customers]}"
            
            worker = Worker()
            worker.worker_name = data['worker_name']
            worker.worker_role = data['worker_role']
            worker.worker_id = data['worker_id']
            worker.worker_passwd = data['worker_passwd']
            if data['worker_phone_number'] and len(data['worker_phone_number']) >= 10:
                worker.phone_number = data['worker_phone_number']
            else:
                return "Invalid phone number. Please provide a valid 10-digit phone number."
            worker.owner = user
            worker.save()
            print(f"DEBUG add_worker - Worker saved successfully: {worker.worker_id}")
            return True
    except Exception as e:
        print("Error while adding worker:", e)
        return str(e)


def remove_worker(data):

    try:
        user = Customer.objects.get(user_id=data['user_id'])
        # print(data)
        worker = Worker.objects.filter(worker_id=data['worker_id'], owner=user).first()
        # print(worker)
        if worker:
            worker.delete()
            return True
        else:
            return "Worker not found"
    except Exception as e:
        print("Error while removing worker:", e)
        return str(e)


def get_workers(data):
    all_workers = Worker.objects.filter(owner__user_id=data['user_id'], worker_role='worker')

    res = {
        "success": True,
        "workers": [
            {"id": worker.worker_id, "name": worker.worker_name}
            for worker in all_workers
        ]
    }
    return res



def profit_loss_calc(data):
    try:
        user = Customer.objects.get(user_id=data['user_id'])
        records = AddRecord.objects.filter(farm_owner=user, type='Investment', status='approved')
        total_investment = sum(record.amount for record in records)
        # print(total_investment)
        profit_records = AddRecord.objects.filter(farm_owner=user, type='Harvest', status='approved')
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
        investment_records = AddRecord.objects.filter(farm_owner=user, type='Investment', status='approved')
        total_investment = sum(record.amount for record in investment_records)

        harvest_records = AddRecord.objects.filter(farm_owner=user, type='Harvest', status='approved')
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

def send_reminder():
    try:
        sender_email = "ajayjothika17@gmail.com"
        sender_password = "herp ioyd scad tvgl"
        subject = "Reminder from Farm Management"
        today_date = timezone.localtime(timezone.now()).date()

        # ✅ Get all reminders for today - LIMIT to prevent memory issues
        reminders_today = Reminder.objects.filter(date=today_date)[:5]  # Max 5 reminders

        if not reminders_today.exists():
            # print("No reminders for today")
            return "No reminders"

        # ✅ Setup SMTP connection once with timeout
        server = None
        try:
            server = smtplib.SMTP('smtp.gmail.com', 587, timeout=30)
            server.starttls()
            server.login(sender_email, sender_password)

            for reminder in reminders_today:
                try:
                    user = reminder.user  # assuming Reminder has a ForeignKey to Customer
                    receiver_email = user.email
                    reminder_message = reminder.message

                    # Email body
                    body = f"""
                    Dear {user.name},

                    This is a reminder for your upcoming task: {reminder_message}.

                    Best regards,
                    Farm Management Team
                    """

                    msg = MIMEMultipart()
                    msg['From'] = sender_email
                    msg['To'] = receiver_email
                    msg['Subject'] = subject
                    msg.attach(MIMEText(body, 'plain'))

                    print(f"Sending reminder email to {receiver_email}...")
                    server.sendmail(sender_email, receiver_email, msg.as_string())
                    print(f"Reminder email sent to {receiver_email}")

                except Exception as e:
                    print(f"Failed to send email to {receiver_email}: {e}")
                    continue  # Continue with next reminder

        except Exception as e:
            print(f"SMTP connection error: {e}")
            return f"SMTP error: {str(e)}"
        finally:
            # Always close connection to free memory
            if server:
                try:
                    server.quit()
                except:
                    pass

        return True

    except Exception as e:
        print("Error while sending reminders:", e)
        return str(e)

    except Exception as e:
        print("Error while sending reminders:", e)
        return str(e)
    

def report_download(data):
    report_type = data.get('type')
    user_id = data.get('user_id')

    if not report_type or not user_id:
        return HttpResponse("Missing type or user_id", status=400)

    today = datetime.now()
    user = Customer.objects.get(user_id=user_id)
    queryset = AddRecord.objects.filter(farm_owner=user, status='approved')

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



def detect_and_translate(text):
    
    location = "southeastasia"

    text_to_translate = text

    path = '/translate'
    constructed_url = endpoint + path

    params = {
        'api-version': '3.0',
        'from': 'ta', 
        'to': ['en']
    }

    headers = {
        'Ocp-Apim-Subscription-Key': subscription_key,
        'Ocp-Apim-Subscription-Region': location,
        'Content-type': 'application/json',
        'X-ClientTraceId': str(uuid.uuid4())
    }

    body = [{
        'text': text_to_translate
    }]

    response = requests.post(constructed_url, params=params, headers=headers, json=body)
    result = response.json()

    return (result[0]['translations'][0]['text'])


def future_expenses(data):
    try:
        sentences = []
        
        # Fetch investment items
        item_list = AddRecord.objects.filter(
            farm_owner_id=data['user_id'], 
            type='Investment', status='approved'
        ).values('item_name')

        for i in item_list:
            sentences.append(i['item_name'])

        genai.configure(api_key=genai_apikey)
        model = genai.GenerativeModel("models/gemini-1.5-flash")

        prompt = f"""
        You are an assistant that extracts structured farming expenses. 
        The input is a list of investment activities. 
        Analyze deeply and give FUTURE EXPENSE predictions for each activity. 

        Always return ONLY valid JSON.  
        Format:
        [
            {{
                "investment": "<string>",
                "amount": <number>,
                "reason": "<string>"
            }}
        ]

        Rules:
        - "investment" = the activity/item (e.g., "cow bought", "paddy planting").
        - "amount" = numeric value only (strip ₹, Rs, INR, commas, k, lakhs).
        - "amount" = estimate average future expense (maintenance, feeding, labor, etc.), 
          NOT purchase cost.
        - "reason" = explain briefly why this expense is expected.
        - No text outside JSON.

        Input:
        {sentences}

        JSON:
        """

        response = model.generate_content(prompt)
        raw_text = response.text.strip()

        # print(raw_text)

        clean_text = raw_text.replace("```json", "").replace("```", "").strip()

        try:
            parsed = json.loads(clean_text)

            if isinstance(parsed, dict):
                parsed = [parsed]

            return parsed
        except json.JSONDecodeError:
            print("JSON decode failed. Returning raw:", clean_text)
            return "Given input is not valid"

    except Exception as e:
        print("Error occurred while processing future expenses:", e)
        return "Error occurred while processing future expenses"


def detect_type(sentence):

    genai.configure(api_key=genai_apikey)

    model = genai.GenerativeModel("models/gemini-1.5-flash")

    prompt = f"""
    You are a classifier for agricultural sentences.
    Analyze this sentence with your trained set of data and give the proper result. Check whether it will come under Investment, Harvest, or Other and finalize your classification.
    return output should be a string "Investment" or "Harvest" or "Other"
    Classify each sentence as:
    - "Investment": Money spent on farming (buying seeds, fertilizer, wages for labor, maintenance, planting, etc.), Money spent on labor costs while harvesting.
    - "Harvest": Money earned or activities related to selling crops, fruits, livestock, selling milk, etc.
    - "Other": If it does not fit either category or if you are unsure.

    Examples:
    "Bought 3 bags of fertilizer for 1200 rupees" → Investment
   
    "Paid 500 for mango saplings" → Investment
    "Spent 2500 on tractor repair" → Investment
    "Sold 200 kg of rice for 15,000 rupees" → Harvest
    "Harvested sugarcane and sold for 25,000 rupees" → Harvest
    "Weeding the paddy field and paying 5,000 in wages" → Investment

    Sentence: "{sentence}"
    Classification:
    """
    response = model.generate_content(prompt)
    return response.text.strip().lower()


def detect_item_amount(sentence):

    genai.configure(api_key=genai_apikey)

    model = genai.GenerativeModel("models/gemini-1.5-flash")

    prompt = f"""
    You are an assistant for a farm management system. 
    Extract the agricultural item, the activity, and the price from the following text. 
    Return only JSON with keys: item, activity, price.

    Example:
    Input: "yesterday groundnut field has been weeded and wage is 2500"
    Output: {{"item": "groundnut", "activity": "weeding", "price": 2500}}
    Input: "Bought 3 bags of fertilizer for 1200 rupees"
    Output: {{"item": "fertilizer", "activity": "buying", "price": 1200}}
    Input: "Paid 500 for mango saplings"
    Output: {{"item": "mango", "activity": "buying", "price": 500}}
    Input: "Spent 2500 on tractor repair"
    Output: {{"item": "tractor", "activity": "repairing", "price": 2500}}
    Input: "Today 10 people came to work as labourers. Salary 10,000"
    Output: {{"item": "labour", "activity": "working", "price": 10000}}
    Input: "Sold 200 kg of rice for 15,000 rupees"
    Output: {{"item": "rice", "activity": "selling", "price": 15000}}
    Input: "Harvested sugarcane and sold for 25,000 rupees"
    Output: {{"item": "sugarcane", "activity": "harvesting", "price": 25000}}
    Input: "Invested 5000 in new irrigation system"
    Output: {{"item": "irrigation system", "activity": "investment", "price": 5000}}
    Input: "Bought 10 liters of diesel for 800 rupees"
    Output: {{"item": "diesel", "activity": "buying", "price": 800}}
    Input: "Irrigated the paddy field and spent 2000"
    Output: {{"item": "paddy", "activity": "irrigating", "price": 2000}}
    Input: "Bought cow fodder for 1500 rupees"
    Output: {{"item": "cow fodder", "activity": "buying", "price": 1500}}

    Input: "{sentence}"
    Output:
    """
    response = model.generate_content(prompt)
    raw_text = response.text.strip()

    clean_text = raw_text.replace("```json", "").replace("```", "").strip()
    # print(clean_text)

    try:
        data = json.loads(clean_text)
    except json.JSONDecodeError:
        return "Given input is not valid"

    return data

   

def worker_dashboard(data):
    count = True
    sentence_en = ''
    # print("Received DATA:", data)
    if data['language'] == 'ta-IN':
        sentence_en = detect_and_translate(data['transcript'])
    else:
        sentence_en = data['transcript']
    # print("Translated sentence:", sentence_en)

    detected_type = detect_type(sentence_en)

    # print("Detected type:", detected_type)

    if detected_type == "classification: other" or detected_type == "other":
        count = False
        return "This sentence does not fit into Investment or Harvest categories."
    if detected_type == 'investment' or detected_type == "classification: investment":
        data['record_type'] = 'Investment'
    if detected_type == 'harvest' or detected_type == "classification: harvest":
        data['record_type'] = 'Harvest'

    detected_item_and_amount = detect_item_amount(sentence_en)
    # print("Detected item and amount:", detected_item_and_amount)
    # Detected item and amount: {'item': 'paddy', 'activity': 'cultivating', 'price': 10000}
    if detected_item_and_amount['item'] is None or detected_item_and_amount['price'] is None:
        count = False
        return "Could not detect item or amount from the sentence."
    
    else:
        data['item_name'] = detected_item_and_amount['item'] + " " + detected_item_and_amount['activity']
        data['amount'] = detected_item_and_amount['price']
    # print("Detected item and amount:", detected_item_and_amount)

    if count:
        data['record_date'] = datetime.now().strftime('%Y-%m-%d')
        # print(data)
        res = add_record(data)

        if res is not True:
            return "Error occurred while adding record."
    else:
        return "Could not process the record due to missing item or amount information."

    return True



def add_long_input(data):
    # print(data)

    genai.configure(api_key=genai_apikey)


    # Choose model that supports audio
    model = genai.GenerativeModel("models/gemini-1.5-flash")

    # Get the uploaded audio file (InMemoryUploadedFile)
    audio_file = data["audio"]  # because QueryDict gives a list

    # Read bytes from uploaded file
    audio_bytes = audio_file.read()

    # Reset file pointer if you want to use the file later
    audio_file.seek(0)

    # Send audio + instruction
    response = model.generate_content([
        {"mime_type": audio_file.content_type, "data": audio_bytes},
        "Transcribe this Tamil audio to text in Tamil. Then translate it into English."
        "if audio is in hindi then convert it to english"
        "if it is in english then keep it as it is"
        "Give only the English sentence as output in the response i dont want any other text only english converted summary"
    ])
    # print("Transcription and Translation:", response.text)

    tasklog = TaskLog()
    worker = Worker.objects.get(worker_id=data['user_id'])
    customer = Customer.objects.get(user_id=worker.owner.user_id)
    # print("Customer ID:", customer.user_id)
    tasklog.worker_id = data['user_id']
    tasklog.user = customer
    tasklog.action = response.text
    tasklog.date = datetime.now().date()
    tasklog.save()

    # print("---- RAW RESPONSE ----")
    # print(response.text)
    return True


def log_download(data):
    try:
        # print(data)
        # print("Logging download activity...")
        # print("User ID:", data["user_id"])
        # print("Download Timestamp:", datetime.now())
        worker_id = data['worker_id']
        report_type = data["report_type"]
        user_id = data["user_id"]
        print("micky")
            # Base queryset
        
        logs = TaskLog.objects.filter(worker_id=worker_id)
        empty_logs = not logs.exists()
        if empty_logs:
            print("No logs found for this worker")
            return HttpResponse("No logs found for this worker", content_type="text/plain", status=404)
            # Date filters
        today = now().date()
        if report_type == "today":
            logs = logs.filter(created_at__date=today)

        elif report_type == "week":
            start_week = today - timedelta(days=7)
            logs = logs.filter(created_at__date__gte=start_week)

        elif report_type == "month":
            start_month = today.replace(day=1)
            logs = logs.filter(created_at__date__gte=start_month)

        elif report_type == "year":
            start_year = today.replace(month=1, day=1)
            logs = logs.filter(created_at__date__gte=start_year)

        # If no logs found
        if not logs.exists():
            response = HttpResponse("No logs found for given criteria.", content_type="text/plain")
            response.status_code = 404
            return response

        # ---- Generate PDF ----
        response = HttpResponse(content_type="application/pdf")
        response['Content-Disposition'] = f'attachment; filename="report_{worker_id}_{report_type}.pdf"'

        doc = SimpleDocTemplate(response, pagesize=A4)
        styles = getSampleStyleSheet()
        elements = []


    # Greeting for the owner
        greeting = Paragraph(f"Hello {user_id}, here is the report for <b>{worker_id}</b>", styles['Heading2'])
        elements.append(greeting)
        elements.append(Spacer(1, 12))

        # Report title
        elements.append(Paragraph(f"Report Type: {report_type.capitalize()}", styles['Normal']))
        elements.append(Paragraph(f"Generated On: {now().strftime('%Y-%m-%d %H:%M')}", styles['Normal']))
        elements.append(Spacer(1, 20))

        styles = getSampleStyleSheet()   
        normal_style = styles["Normal"]

        data = [["Worker ID", "Date", "Work"]]
        for log in logs:
            data.append([
            log.worker_id,
            log.created_at.strftime("%Y-%m-%d"),
            Paragraph(log.action, normal_style)   # ✅ Wrap text
            ])

        # Create table with larger work column
        table = Table(data, colWidths=[100, 100, 300])
        table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#4CAF50")),
        ("TEXTCOLOR", (0, 0), (-1, 0), colors.whitesmoke),
        ("ALIGN", (0, 0), (-1, -1), "CENTER"),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),  # ✅ Align text at top
        ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
        ("BOTTOMPADDING", (0, 0), (-1, 0), 12),
        ("BACKGROUND", (0, 1), (-1, -1), colors.beige),
        ("GRID", (0, 0), (-1, -1), 1, colors.black),
        ]))
        elements.append(table)
        doc.build(elements)


        return response
    
    except Exception as e:
        print("Error occurred while logging download:", e)
        response = HttpResponse("Error occurred while logging download.", content_type="text/plain")
        response.status_code = 500
        return response