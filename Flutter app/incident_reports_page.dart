import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class IncidentReportsPage extends StatefulWidget {
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
  _IncidentReportsPageState createState() => _IncidentReportsPageState();
}

class _IncidentReportsPageState extends State<IncidentReportsPage> {
  Future<List<Map<String, String>>> loadIncidents() async {
    try {
      final jsonString = await rootBundle.loadString('assets/filtered_incidents.json');
      final List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((item) => Map<String, String>.from(item)).toList();
    } catch (e) {
      print("Error loading incidents: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incident Reports'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: loadIncidents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No incidents found'));
          }

          final incidents = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  widget.eventTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  widget.eventDate,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Location'),
                  subtitle: Text(widget.eventLocation),
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Number of Attendees'),
                  subtitle: Text('${widget.numberOfAttendees} attendees'),
                ),
                ListTile(
                  leading: Icon(Icons.report),
                  title: Text('Number of Incidents'),
                  subtitle: Text('${widget.numberOfIncidents} incidents occurred'),
                ),
                Divider(),
                Text(
                  'List of Incidents',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                ...incidents.map((incident) {
                  return ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text(incident['description']!),
                    subtitle: Text(
                        'Time: ${incident['time']}, Location: ${incident['location']}'),
                  );
                }).toList(),
                Divider(),
                Text(
                  'Preventive Measures Taken',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                ...widget.preventiveMeasures.map((measure) {
                  return ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text(measure),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding new alert
        },
        child: Icon(Icons.add_alert),
        backgroundColor: Colors.red,
      ),
    );
  }
}
