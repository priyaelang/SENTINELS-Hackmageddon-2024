from flask import Flask, render_template, request, redirect, url_for, session, jsonify
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import IsolationForest
from sklearn.preprocessing import StandardScaler

app = Flask(__name__)
app.secret_key = 'f3d918f11a5a3bcf0ef52ff71b40228e'  # Change this to something secure

# Path to your CSV file
file_path = 'C:/Users/sania/Documents/crowd/kanpur_selected_5000.csv'

def run_ml_model():
    # Load the weather data CSV file
    weather_data = pd.read_csv(file_path)

    # Selecting relevant features: temperature, wind speed, humidity, precipitation
    selected_features = weather_data[['tempC', 'windspeedKmph', 'humidity', 'precipMM']]

    # Feature Scaling
    scaler = StandardScaler()
    scaled_features = scaler.fit_transform(selected_features)

    # Splitting the data into training (80%) and testing (20%) sets
    X_train, X_test = train_test_split(scaled_features, test_size=0.2, random_state=42)

    # Using Isolation Forest to detect anomalies
    model = IsolationForest(contamination=0.05, random_state=42)
    model.fit(X_train)

    # Predicting on the test set
    predictions = model.predict(X_test)

    # Identifying abnormal changes (where prediction == -1)
    anomaly_indices = predictions == -1
    anomalous_data_scaled = X_test[anomaly_indices]

    # Inverse transforming the scaled anomalous data back to original scale
    anomalous_data_original = scaler.inverse_transform(anomalous_data_scaled)

    # Convert the anomalous data back to a DataFrame with original feature names
    anomalous_data_df = pd.DataFrame(anomalous_data_original, columns=['temperature', 'wind_speed', 'humidity', 'precipitation'])

    # Function to generate alerts based on conditions
    def generate_alert(row):
        temp = row['temperature']
        humidity = row['humidity']
        precip = row['precipitation']
        wind_speed = row['wind_speed']

        if temp > 35 and humidity < 30:
            return "Alert: Dry Heat - High temperature and low humidity detected."
        elif temp > 35 and precip > 10:
            return "Alert: Hot with Rain - High temperature and significant precipitation detected."
        elif humidity > 80 and precip > 10:
            return "Alert: High Humidity with Rain - High humidity and precipitation detected."
        elif wind_speed > 20:
            return "Alert: Windy Conditions - High wind speed detected."
        elif temp < 5 and precip > 10:
            return "Alert: Cold and Rainy - Low temperature with precipitation detected."
        elif temp < 5 and wind_speed > 20:
            return "Alert: Cold and Windy - Low temperature with high wind speed detected."
        else:
            return None  # No alert if the condition is normal

    # Apply the alert function to the anomalous data
    anomalous_data_df['alert'] = anomalous_data_df.apply(generate_alert, axis=1)

    # Filter out rows where the alert is None (i.e., normal conditions)
    anomalous_data_df = anomalous_data_df[anomalous_data_df['alert'].notnull()]

    return anomalous_data_df['alert'].tolist()

@app.route('/')
def index():
    return render_template('login.html')

@app.route('/dashboard')
def dashboard():
    # After login, run the ML model and pass the alerts to the dashboard
    alerts = run_ml_model()
    return render_template('dashboard.html', alerts=alerts)

@app.route('/login', methods=['POST'])
def login():
    email = request.form['email']
    password = request.form['password']

    # Assuming successful login
    session['logged_in'] = True
    return redirect(url_for('dashboard'))

if __name__ == '__main__':
    app.run(debug=True)

