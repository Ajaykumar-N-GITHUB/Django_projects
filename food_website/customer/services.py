from customer.customer_operations import AddCustomer, ModifyCustomer, DeleteCustomer

def insert_customer(data):
    res = AddCustomer(data)
    return res

def modify_customer(data):
    res, cust_info = ModifyCustomer(data)
    return res, cust_info

def remove_customer(data):
    res = DeleteCustomer(data)
    return res