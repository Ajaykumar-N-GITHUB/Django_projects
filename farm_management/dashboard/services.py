from dashboard.record_operations import add_record, get_records, update_record, \
profit_loss_calc, delete_record, set_reminder, pie_bar, future_expenses, report_download, worker_dashboard, \
add_worker, remove_worker, add_long_input, log_download
from dashboard.models import Customer



def add_record_services(data):
    res = add_record(data)
    return res

def fetch_record_services(data):
    res = get_records(data)
    return res

def update_record_services(data):
    res = update_record(data)
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

def worker_dashboard_services(data):
    res = worker_dashboard(data)
    return res

def add_worker_services(data):
    res = add_worker(data)
    return res

def remove_worker_services(data):
    res = remove_worker(data)
    return res

def worker_long_input_services(data):
    res  = add_long_input(data)
    return res

def log_download_services(data):
    res = log_download(data)
    return res