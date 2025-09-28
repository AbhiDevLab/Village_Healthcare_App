import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildEmergencyButton(
                'Call Ambulance', Icons.local_hospital, Colors.red, 'tel:108'),
            SizedBox(height: 16),
            _buildEmergencyButton('Emergency Contact', Icons.contact_emergency,
                Colors.orange, 'tel:102'),
            SizedBox(height: 16),
            _buildEmergencyButton(
                'Nearest Hospital', Icons.location_on, Colors.blue, null),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyButton(
      String text, IconData icon, Color color, String? url) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: color, size: 36),
        title: Text(text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onTap: url != null ? () => _launchURL(url) : null,
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Could not launch URL
    }
  }
}
