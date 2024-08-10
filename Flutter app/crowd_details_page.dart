import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_provider.dart';

class CrowdDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crowd Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Provider.of<AlertProvider>(context, listen: false)
                  .addAlert("Crowd density has increased!");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildInfoCard(
              context,
              icon: Icons.people,
              title: "Total People",
              subtitle:
                  "Real-time total number of people in the monitored area.",
              data: "Loading...", // Replace with backend data
            ),
            _buildInfoCard(
              context,
              icon: Icons.density_medium,
              title: "Crowd Density",
              subtitle: "Current crowd density percentage.",
              data: "Loading...", // Replace with backend data
            ),
            _buildInfoCard(
              context,
              icon: Icons.warning_amber_rounded,
              title: "Hotspots Detected",
              subtitle: "Number of crowd hotspots currently active.",
              data: "Loading...", // Replace with backend data
            ),
            _buildInfoCard(
              context,
              icon: Icons.report_problem,
              title: "Active Incidents",
              subtitle: "Number of active incidents being monitored.",
              data: "Loading...", // Replace with backend data
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<AlertProvider>(context, listen: false)
              .addAlert("A new crowd hotspot has been detected!");
        },
        child: Icon(Icons.add_alert),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required String data}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing:
            Text(data, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
