import 'package:flutter/material.dart';
import 'appointment_screen.dart';

class TelemedicineScreen extends StatelessWidget {
  const TelemedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telemedicine'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildDoctorCard(context, 'Dr. Rajesh Kumar', 'General Physician',
              'Available', Icons.video_call),
          _buildDoctorCard(context, 'Dr. Priya Singh', 'Pediatrician', 'Busy',
              Icons.video_call),
          _buildDoctorCard(context, 'Dr. Amit Sharma', 'Dermatologist',
              'Available', Icons.video_call),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, String name, String specialty,
      String status, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(name),
        subtitle: Text(specialty),
        trailing: Chip(
          label: Text(status),
          backgroundColor: status == 'Available'
              ? Colors.green.shade100
              : Colors.orange.shade100,
        ),
        onTap: status == 'Available'
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentScreen(doctorName: name),
                  ),
                );
              }
            : null,
      ),
    );
  }
}
