import 'package:flutter/material.dart';
import 'heatmap_page.dart';
import 'crowd_details_page.dart';
import 'alerts_page.dart';
import 'incident_reports_page.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages the user can navigate to
  final List<Widget> _widgetOptions = [
    HeatmapPage(),
    CrowdDetailsPage(),
    AlertsPage(),
    _buildIncidentReportsPage(),
  ];

  @override
  void initState() {
    super.initState();

    // Display the alert dialog after a delay (simulating a new incident)
    Future.delayed(Duration(seconds: 2), () {
      _showIncidentDialog("New incident reported at Location XYZ!");
    });
  }

  // Handler for bottom navigation bar taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Logout function that navigates back to the login page
  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  // Function to show a dialog alert in the center of the screen
  void _showIncidentDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.username}!"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Heatmap',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Crowd Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Incident Reports',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showIncidentDialog("New incident reported at Location XYZ!");
        },
        child: Icon(Icons.add_alert),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Static method to build the Incident Reports Page
  static Widget _buildIncidentReportsPage() {
    return IncidentReportsPage(
      eventTitle: 'Music Festival 2024', // Example event title
      eventDate: 'August 8, 2024',       // Example event date
      eventLocation: 'Downtown Park',    // Example location
      numberOfAttendees: 5000,           // Example number of attendees
      numberOfIncidents: 3,              // Example number of incidents
      incidents: [
        {
          'description': 'Overcrowding near stage',
          'time': '7:30 PM',
          'location': 'Stage Area'
        },
        {
          'description': 'Lost child',
          'time': '8:00 PM',
          'location': 'Entrance'
        },
        {
          'description': 'Minor injury',
          'time': '9:15 PM',
          'location': 'Food Court'
        },
      ],  // Example incidents
      preventiveMeasures: [
        'Increased security near stage',
        'Established a lost and found booth',
        'Deployed first aid stations around the event area',
      ],  // Example preventive measures
    );
  }
}
