from account.sendemail import *
from account.authentication import signup_user, login_user, reset_password, get_worker_manager
from account.authentication import get_pending_records, approve_expense, reject_expense, get_all_records


def email_sender(data):
    res = send_support_request(data)
    return res

def reset_password_service(data):
    res = reset_password(data)
    return res


def signup_service(data):
    res = signup_user(data)
    return res

def login_service(data):
    res = login_user(data)
    return res

def get_worker_manager_service(data):
    res = get_worker_manager(data)
    return res

def get_pending_records_service(data):
    res = get_pending_records(data)
    return res


def approve_expense_service(data):
    res = approve_expense(data)
    return res

def reject_expense_service(data):
    res = reject_expense(data)
    return res

def get_all_records_service(data):
    res = get_all_records(data)
    return res