import 'package:flutter/material.dart';

class HealthRecordsScreen extends StatelessWidget {
  HealthRecordsScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> records = [
    {'date': '2024-01-15', 'condition': 'Fever', 'medication': 'Paracetamol'},
    {'date': '2024-01-10', 'condition': 'Headache', 'medication': 'Ibuprofen'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Records')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewRecord(context),
        child: Icon(Icons.add),
        tooltip: 'Add New Record',
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: records.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.medical_services_outlined,
                  color: Theme.of(context).primaryColor),
              title: Text(records[index]['condition']!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Date: ${records[index]['date']}'),
              trailing: Text(records[index]['medication']!),
            ),
          );
        },
      ),
    );
  }

  void _addNewRecord(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add new record functionality coming soon!')),
    );
  }
}
