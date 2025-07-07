from account.sendemail import send_email
from account.authentication import signup_user, login_user, reset_password


def email_sender(data):
    res = send_email(data)
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