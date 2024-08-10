import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_provider.dart';

class AlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Provider.of<AlertProvider>(context, listen: false)
                  .addAlert("New alert added manually!");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AlertProvider>(
          builder: (context, alertProvider, child) {
            return ListView(
              children: <Widget>[
                _buildSectionTitle('Active Alerts'),
                ...alertProvider.alerts.map((alert) {
                  return _buildAlertCard(
                    context,
                    icon: Icons.notification_important,
                    title: alert,
                    description: "Location XYZ",
                    timestamp: "Timestamp: ${DateTime.now()}",
                    status: "Status: Ongoing",
                    color: Colors.redAccent,
                  );
                }).toList(),
                SizedBox(height: 20),
                _buildSectionTitle('Past Alerts'),
                _buildAlertCard(
                  context,
                  icon: Icons.check_circle_outline,
                  title: "Crowd Dispersed",
                  description: "Area: Main Hall",
                  timestamp: "Timestamp: 2023-08-07 05:30 PM",
                  status: "Status: Resolved",
                  color: Colors.green,
                ),
                _buildAlertCard(
                  context,
                  icon: Icons.check_circle_outline,
                  title: "Incident Resolved",
                  description: "Area: West Gate",
                  timestamp: "Timestamp: 2023-08-07 02:15 PM",
                  status: "Status: Resolved",
                  color: Colors.green,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AlertProvider>(context, listen: false)
              .addAlert("New alert from FAB!");
        },
        child: Icon(Icons.add_alert),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAlertCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String timestamp,
    required String status,
    required Color color,
  }) {
    return Card(
      color: color.withOpacity(0.1),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(timestamp),
            Text(status),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: color),
        onTap: () {
          // Implement navigation to detailed alert view
        },
      ),
    );
  }
}
