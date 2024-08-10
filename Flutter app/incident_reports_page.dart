import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For classic icons
import 'alert_provider.dart';

class IncidentReportsPage extends StatelessWidget {
  final String eventTitle;
  final String eventDate;
  final String eventLocation;
  final int numberOfAttendees;
  final int numberOfIncidents;
  final List<Map<String, String>> incidents;
  final List<String> preventiveMeasures;

  IncidentReportsPage({
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    required this.numberOfAttendees,
    required this.numberOfIncidents,
    required this.incidents,
    required this.preventiveMeasures,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for alerts and show a dialog when an alert is triggered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final alertMessage = Provider.of<AlertProvider>(context).alertMessage;
      if (alertMessage != null) {
        _showIncidentDialog(context, alertMessage);
        Provider.of<AlertProvider>(context, listen: false).clearAlert();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Incident Reports'),
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event, color: Colors.blue),
                SizedBox(width: 8),
                Text('Event: $eventTitle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.date_range, color: Colors.blue),
                SizedBox(width: 8),
                Text('Date: $eventDate', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 8),
                Text('Location: $eventLocation', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.people, color: Colors.blue),
                SizedBox(width: 8),
                Text('Number of Attendees: $numberOfAttendees', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Text('Number of Incidents: $numberOfIncidents', style: TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.blue),
                SizedBox(width: 8),
                Text('Incidents:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            ...incidents.map((incident) {
              return ListTile(
                leading: Icon(FontAwesomeIcons.bullhorn, color: Colors.orange),
                title: Text(incident['description'] ?? 'No description'),
                subtitle: Text('${incident['time']} at ${incident['location']}'),
              );
            }).toList(),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.shield, color: Colors.blue),
                SizedBox(width: 8),
                Text('Preventive Measures:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            ...preventiveMeasures.map((measure) {
              return ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(measure),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog alert in the center of the screen
  void _showIncidentDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('Alert'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
