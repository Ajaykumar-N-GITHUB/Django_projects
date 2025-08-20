from pydoc import text
from urllib import response
from dashboard.models import AddRecord
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
from dashboard.models import AddRecord
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
    if transcript_value:
        worker = Worker.objects.get(worker_id=data['user_id'])
        if worker:
            data['owner_id'] = worker.owner.user_id
        else:
            return "Worker not found"
        
        user = Customer.objects.get(user_id=data['owner_id'])
    else:
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



def add_worker(data):

    try:
        if Worker.objects.filter(worker_id=data['worker_id']).exists():
            return "Worker Id already exists. Please choose a different one"
        else:
            user = Customer.objects.get(user_id=data['user_id'])
            worker = Worker()
            worker.worker_id = data['worker_id']
            worker.worker_passwd = data['worker_passwd']
            if data['worker_phone_number'] and len(data['worker_phone_number']) >= 10:
                worker.phone_number = data['worker_phone_number']
            else:
                return "Invalid phone number. Please provide a valid 10-digit phone number."
            worker.owner = user
            worker.save()
            return True
    except Exception as e:
        print("Error while adding worker:", e)
        return str(e)


def remove_worker(data):

    try:
        user = Customer.objects.get(user_id=data['user_id'])
        print(data)
        worker = Worker.objects.filter(worker_id=data['worker_id'], owner=user).first()
        print(worker)
        if worker:
            worker.delete()
            return True
        else:
            return "Worker not found"
    except Exception as e:
        print("Error while removing worker:", e)
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
        sender_password = "herp ioyd scad tvgl"
        receiver_email = user.email
        print(receiver_email)
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

        if today_date == reminder_date:
            try:
                print("Sending reminder email...")
                server = smtplib.SMTP('smtp.gmail.com', 587)
                # server.set_debuglevel(1)
                server.starttls() 
                server.login(sender_email, sender_password)
                server.sendmail(sender_email, receiver_email, message.as_string())
                print("Reminder email sent successfully")
                return True

            except Exception as e:
                return str(e)

            finally:
                server.quit()

    except Exception as e:
        print("Error while setting reminder:", e)
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
            type='Investment'
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
    Classify each sentence as:
    - "Investment": Money spent on farming (buying seeds, fertilizer, wages for labor, maintenance, planting, etc.), Money spent on labor costs while harvesting.
    - "Harvest": Money earned or activities related to selling crops, fruits, livestock, etc.
    - "Other": If it does not fit either category.

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

    Input: "{sentence}"
    Output:
    """
    response = model.generate_content(prompt)
    raw_text = response.text.strip()

    clean_text = raw_text.replace("```json", "").replace("```", "").strip()

    try:
        data = json.loads(clean_text)
    except json.JSONDecodeError:
        return "Given input is not valid"

    return data

   

def worker_dashboard(data):
    count = True
    sentence_en = ''
    print("Received DATA:", data)
    if data['language'] == 'ta-IN':
        sentence_en = detect_and_translate(data['transcript'])
    else:
        sentence_en = data['transcript']
    print("Translated sentence:", sentence_en)

    detected_type = detect_type(sentence_en)

    print("Detected type:", detected_type)

    if detected_type == "classification: other" or detected_type == "other":
        count = False
        return "This sentence does not fit into Investment or Harvest categories."
    if detected_type == 'investment' or detected_type == "classification: investment":
        data['record_type'] = 'Investment'
    elif detected_type == 'harvest' or detected_type == "classification: harvest":
        data['record_type'] = 'Harvest'

    detected_item_and_amount = detect_item_amount(sentence_en)
    print("Detected item and amount:", detected_item_and_amount)
    # Detected item and amount: {'item': 'paddy', 'activity': 'cultivating', 'price': 10000}
    if detected_item_and_amount['item'] is None or detected_item_and_amount['price'] is None:
        count = False
        return "Could not detect item or amount from the sentence."
    
    else:
        data['item_name'] = detected_item_and_amount['item'] + " " + detected_item_and_amount['activity']
        data['amount'] = detected_item_and_amount['price']
    print("Detected item and amount:", detected_item_and_amount)

    if count:
        data['record_date'] = datetime.now().strftime('%Y-%m-%d')
        res = add_record(data)

        if res is not True:
            return "Error occurred while adding record."
    else:
        return "Could not process the record due to missing item or amount information."

    return True
    