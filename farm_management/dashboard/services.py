from dashboard.record_operations import add_record, get_records,  \
profit_loss_calc, delete_record, set_reminder, pie_bar, future_expenses, report_download
from dashboard.models import Customer

def add_record_services(data):
    res = add_record(data)
    return res


def fetch_record_services(data):
    res = get_records(data)
    return res

def delete_record_services(data):
    res = delete_record(data)
    return res

def profit_loss_services(data):
    res = profit_loss_calc(data)
    return res

def set_reminder_services(data):
    res = set_reminder(data)
    return res

def pie_bar_services(data):
    res = pie_bar(data)
    return res

def future_expenses_services(data):
    res = future_expenses(data)
    return res

def report_download_services(data):
    res = report_download(data)
    return res