import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_provider.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'heatmap_page.dart';  // Ensure this is the correct path
import 'crowd_details_page.dart';
import 'alerts_page.dart';
import 'incident_reports_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Provider.of<AlertProvider>(context, listen: false)
                  .addAlert("New alert from settings!");
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Login Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          ListTile(
            title: Text('Home Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(username: 'DefaultUser'),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Signup Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
          ),
          ListTile(
            title: Text('Heatmap Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HeatmapPage()),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.add_alert),
              onPressed: () {
                Provider.of<AlertProvider>(context, listen: false)
                    .addAlert("High temperature detected in Heatmap Page!");
              },
            ),
          ),
          ListTile(
            title: Text('Crowd Details Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrowdDetailsPage()),
              );
            },
          ),
          ListTile(
            title: Text('Alerts Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlertsPage()),
              );
            },
          ),
          ListTile(
            title: Text('Incident Reports Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IncidentReportsPage(
                    eventTitle: 'Music Festival 2024',
                    eventDate: 'August 8, 2024',
                    eventLocation: 'Downtown Park',
                    numberOfAttendees: 5000,
                    numberOfIncidents: 3,
                    incidents: [
                      {
                        'description': 'Overcrowding near stage',
                        'time': '7:30 PM',
                        'location': 'Stage Area'
                      },
                      {
                        'description': 'Lost child',
                        'time': '8:00 PM',
                        'location': 'Food Court'
                      },
                      {
                        'description': 'Medical emergency',
                        'time': '9:00 PM',
                        'location': 'Entrance Gate'
                      },
                    ],
                    preventiveMeasures: [
                      'Increased security at stage area',
                      'Announced lost child over PA system',
                      'Deployed medical team at entrance gate',
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
