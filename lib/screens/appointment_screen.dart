import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  final String? doctorName;
  const AppointmentScreen({Key? key, this.doctorName}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedType = 'teleconsultation';
  String _selectedDoctor = 'Dr. Sharma';

  @override
  void initState() {
    super.initState();
    if (widget.doctorName != null) {
      _selectedDoctor = widget.doctorName!;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
        backgroundColor: Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Date Selection
            Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.blue),
                title: Text('Select Date'),
                subtitle: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () => _selectDate(context),
              ),
            ),
            SizedBox(height: 16),

            // Time Selection
            Card(
              child: ListTile(
                leading: Icon(Icons.access_time, color: Colors.green),
                title: Text('Select Time'),
                subtitle: Text(_selectedTime.format(context)),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () => _selectTime(context),
              ),
            ),
            SizedBox(height: 16),

            // Appointment Type
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Appointment Type',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      value: _selectedType,
                      items: ['teleconsultation', 'in_person']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(
                                    type.replaceAll('_', ' ').toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedType = value.toString()),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Doctor Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Doctor',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      value: _selectedDoctor,
                      items: [
                        'Dr. Sharma',
                        'Dr. Patel',
                        'Dr. Kumar',
                        'Dr. Gupta',
                        'Dr. Rajesh Kumar',
                        'Dr. Priya Singh',
                        'Dr. Amit Sharma'
                      ]
                          .toSet() // Use a Set to remove duplicates
                          .toList()
                          .map((doc) =>
                              DropdownMenuItem(value: doc, child: Text(doc)))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedDoctor = value.toString()),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Book Button
            ElevatedButton(
              onPressed: () => _bookAppointment(context),
              child: Text(
                'Book Appointment',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _bookAppointment(BuildContext context) {
    final appointmentDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Appointment Booked!'),
        content: Text(
          'Your appointment with $_selectedDoctor is scheduled for ${appointmentDateTime.day}/${appointmentDateTime.month}/${appointmentDateTime.year} at ${_selectedTime.format(context)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
