import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'appointment_screen.dart';
import 'telemedicine_screen.dart';
import 'health_records_screen.dart';
import 'emergency_screen.dart';
import 'health_tips_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Village Healthcare'),
        backgroundColor: Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Welcome, ${user?.name ?? 'User'}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Village: ${user?.village ?? 'Unknown'}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),

            // Features Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    'Book Appointment',
                    Icons.calendar_today,
                    Colors.blue,
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AppointmentScreen())),
                  ),
                  _buildFeatureCard(
                    'Telemedicine',
                    Icons.video_call,
                    Colors.green,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TelemedicineScreen())),
                  ),
                  _buildFeatureCard(
                    'Health Records',
                    Icons.medical_services,
                    Colors.orange,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HealthRecordsScreen())),
                  ),
                  _buildFeatureCard(
                    'Emergency',
                    Icons.emergency,
                    Colors.red,
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EmergencyScreen())),
                  ),
                  _buildFeatureCard(
                    'Health Tips',
                    Icons.article,
                    Colors.purple,
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HealthTipsScreen())),
                  ),
                  _buildFeatureCard(
                    'My Profile',
                    Icons.person,
                    Colors.teal,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProfileScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.1), color.withOpacity(0.3)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Feature coming soon!')),
    );
  }

  void _handleEmergency(BuildContext context) {
    // This can be replaced by direct navigation if preferred
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => EmergencyScreen()));
  }
}
