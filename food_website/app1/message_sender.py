from twilio.rest import Client


account_sid = 'AC84c7994730881fabd2a4a5f6be896076'
auth_token = '2d4633efb5f7983adeebcf6db337f9a7'
twilio_number = '+19066282866'  


client = Client(account_sid, auth_token)

def send_sms(to_number, message):
    try:
        msg = client.messages.create(
            body=message,
            from_=twilio_number,
            to=to_number 
        )
        print(f"✅ SMS sent! SID: {msg.sid}")
    except Exception as e:
        print(f"❌ Failed to send SMS: {e}")