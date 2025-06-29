from account.authentication import do_signup,do_logout,do_login, reset_password


def user_signup(data):
    res = do_signup(data)
    return res

def user_login(data):
    res = do_login(data)
    return res


def forget_passwd(data):
    res = reset_password(data)
    return res

def user_logout():
    res = do_logout()
    return res