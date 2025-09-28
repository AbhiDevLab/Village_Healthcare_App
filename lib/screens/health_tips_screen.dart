import 'package:flutter/material.dart';

class HealthTipsScreen extends StatelessWidget {
  HealthTipsScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> healthTips = [
    {
      'title': 'Drink Clean Water',
      'description':
          'Always drink boiled or filtered water to prevent water-borne diseases.',
      'icon': '💧'
    },
    {
      'title': 'Balanced Diet',
      'description':
          'Eat a variety of fruits, vegetables, grains, and proteins daily.',
      'icon': '🍎'
    },
    {
      'title': 'Hygiene',
      'description': 'Wash hands regularly with soap to prevent infections.',
      'icon': '🧼'
    },
    {
      'title': 'Regular Exercise',
      'description':
          'Aim for at least 30 minutes of moderate exercise most days of the week.',
      'icon': '🏃'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Tips')),
      body: ListView.builder(
        itemCount: healthTips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Text(
                healthTips[index]['icon']!,
                style: TextStyle(fontSize: 30),
              ),
              title: Text(
                healthTips[index]['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(healthTips[index]['description']!),
            ),
          );
        },
      ),
    );
  }
}
