import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'heatmap_page.dart';
import 'crowd_details_page.dart';
import 'alerts_page.dart';
import 'incident_reports_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          _buildSettingsOption(
            context,
            title: 'View Incident Reports',
            onTap: () => _navigateToIncidentReports(context),
          ),
          // Add more settings options here if needed
        ],
      ),
    );
  }

  // Method to build each settings option
  Widget _buildSettingsOption(BuildContext context, {required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }

  // Method to navigate to the Incident Reports page
  void _navigateToIncidentReports(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IncidentReportsPage(
          eventTitle: 'Music Festival 2024',  // Example event title
          eventDate: 'August 8, 2024',       // Example event date
          eventLocation: 'Central Park',      // Example location
          numberOfAttendees: 1500,            // Example number of attendees
          numberOfIncidents: 3,               // Example number of incidents
          incidents: [
            {
              'description': 'Overcrowding near the entrance',
              'time': '08:30 PM',
              'location': 'Entrance Gate'
            },
            {
              'description': 'Medical emergency',
              'time': '09:15 PM',
              'location': 'Stage Area'
            },
            {
              'description': 'Lost child found',
              'time': '10:00 PM',
              'location': 'Food Court'
            },
          ],  // Example incidents
          preventiveMeasures: [
            'Increased security presence at the entrance',
            'First aid stations set up near the stage',
            'Announced missing child over the PA system',
          ],  // Example preventive measures
        ),
      ),
    );
  }
}
