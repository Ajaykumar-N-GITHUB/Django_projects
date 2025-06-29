from django.http import HttpResponse
from reportlab.lib.pagesizes import A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib import colors
import io
from customer.models import PurchaseDetail as PD, CustomerDetail as CD
from app1 import message_sender
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.enums import TA_CENTER

from app1.bill_calculator import bill_calc

def generate_pdf(info):
    data = PD.objects.get(customer_name_id = info['customer_name_id'])
    cus = CD.objects.get(id = info['customer_name_id'])

    items = data.items
    customer_name = cus.cust_name
    order_id = data.order_id
    item_total = data.item_total
    gst = data.gst
    tips = data.tips
    total_amount = data.total_amount


    buffer = io.BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=A4)
    elements = []

    styles = getSampleStyleSheet()
    centered_style = ParagraphStyle(
        name="Centered",
        parent=styles["Normal"],
        alignment=TA_CENTER
    )

    # Header
    elements.append(Paragraph("<b><font size=18>Just_Taste</font></b>", styles["Title"]))
    elements.append(Paragraph("123, MG Road, Bangalore - 560001", centered_style))
    elements.append(Spacer(1, 16))
    elements.append(Paragraph(f"<b><font size=14>Order ID: {order_id}</font></b>", styles["Normal"]))
    elements.append(Spacer(1, 16))

    # Table
    table_data = [["Item", "Quantity", "Price"]]
    for item in items:
        table_data.append([item["name"], str(item["quantity"]), str(item["price"])])

    table = Table(table_data, colWidths=[220, 140, 160], rowHeights=[30] * len(table_data))
    style = TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.darkblue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 16),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('BACKGROUND', (0, 1), (-1, -1), colors.lightgrey),
    ])
    table.setStyle(style)

    elements.append(table)
    elements.append(Spacer(1, 20))

    # Bill Summary
    elements.append(Paragraph("<b><font size=14>Bill Summary</font></b>", styles["Heading3"]))
    elements.append(Spacer(1, 12))
    summary_data = [
        ["Item Total", f"Rs:   {item_total}"],
        ["GST", f"Rs:   {gst}"],
        ["Tips/Donation", f"Rs:   {tips}"],
        ["Total Amount", f"Rs:   {total_amount}"],
    ]
    summary_table = Table(summary_data, colWidths=[300, 200], rowHeights=30)
    summary_table.setStyle(TableStyle([
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 14),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 6),
        ('TOPPADDING', (0, 0), (-1, -1), 6),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
    ]))
    elements.append(summary_table)

    
    # Custom centered footer style
    footer_style = ParagraphStyle(
    name="Footer",
    parent=styles["Normal"],
    alignment=TA_CENTER,
    fontName="Helvetica-Oblique",
    fontSize=14,
    textColor=colors.darkgreen,
    spaceBefore=30,
)

    # Footer text
    elements.append(Spacer(1, 30))  # Add vertical space
    elements.append(Paragraph(" Thank you! Visit Again !!! ", footer_style))

    doc.build(elements)

    buffer.seek(0)
    response = HttpResponse(buffer, content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="{customer_name}_bill.pdf"'
    mob_number = "+91" + cus.mob_num
    message = f"Hello {cus.cust_name}! Your order with ID {data.order_id} is confirmed. Total amount is Rs: {data.total_amount}. Thank you for choosing Just_Taste!"
    message_sender.send_sms(mob_number, message=message)
    # send_sms('+918248876435', 'Hello! Your order is confirmed.')

    return response
