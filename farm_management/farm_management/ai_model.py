import pandas as pd
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
import joblib

# Load CSV
def load_and_train_model():
    # Load data
    df = pd.read_csv('/Users/ajaykumar-n/Documents/DJANGO/Django_projects/farm_management/farm_management/farm_data_10000_entries.csv')
    df['month'] = pd.to_datetime(df['date']).dt.month

    # Encode item_name
    le = LabelEncoder()
    df['item_encoded'] = le.fit_transform(df['item_name'])

    X = df[['item_encoded', 'month']]
    y = df['amount']

    # Train-test split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

    # Train model
    model = RandomForestRegressor()
    model.fit(X_train, y_train)

    # Save model and encoder
    joblib.dump(model, 'rf_expense_model.pkl')
    joblib.dump(le, 'label_encoder.pkl')
