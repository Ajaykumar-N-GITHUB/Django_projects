import requests
from account.models import Customer
def get_weather(user_id):
    customer = Customer.objects.filter(user_id=user_id).first()
    api_key = "184b5028aad344a4b0151932250207"
    base_url = f"http://api.weatherapi.com/v1/current.json?key={api_key}&q={customer.district}&aqi=no"
    print(base_url)
    # Build the complete API URL
    params = {
        'q': customer.district,
        'appid': api_key,
        'units': 'metric'  # To get temperature in Celsius
    }

    # Make the GET request
    response = requests.get(base_url, params=params)
    
    if response.status_code == 200:
        data = response.json()
        weather_data = {
            'Location': data['location']['name'],
            'Temp': data['current']['temp_c'],
            'Humidity': data['current']['humidity'],
            'Wind': data['current']['wind_mph'],
            'Condition': data['current']['condition']['text'],
            'Cloud': data['current']['cloud']
            
        }
        return weather_data
    else:
        return {"error": f"Failed to retrieve data: {response.status_code}, {response.text}"}






