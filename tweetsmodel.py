import json
import firebase_admin
from firebase_admin import credentials, db

# Initialize Firebase app with credentials
cred = credentials.Certificate("C:/Users/sania/Documents/hackmegdon_/crowd-app-ffaa4-firebase-adminsdk-tx5bo-2e7410cf38.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://crowd-app-ffaa4-default-rtdb.firebaseio.com/'
})

# Keywords related to crowd management
keywords = ['crowd', 'incident', 'danger', 'threat', 'hazard', 'emergency', 'control', 'management']

# Reference to the tweets in the Firebase Realtime Database
tweets_ref = db.reference('tweets')

# Fetch all tweets from the database
tweets_data = tweets_ref.get()

# Ensure tweets_data is a list
if isinstance(tweets_data, list):
    tweets = tweets_data
else:
    print("Unexpected data format. Expected a list.")
    tweets = []

# Filter tweets based on incidents
relevant_tweets = []
for tweet in tweets:
    incident_text = tweet.get('incident', '').lower()
    if incident_text:  # Check if there is any incident text
        relevant_tweets.append({
            'event_name': tweet.get('event_name', ''),
            'description': incident_text,
            'time': tweet.get('created_at', ''),
            'location': tweet.get('location', '')
        })

# Save the filtered incidents to a JSON file
with open('filtered_incidents.json', 'w') as f:
    json.dump(relevant_tweets, f, indent=4)

print("Filtered incidents have been saved to 'filtered_incidents.json'.")

