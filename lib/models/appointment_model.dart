class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime dateTime;
  final String type;
  final String status;
  final String? symptoms;
  final String? diagnosis;
  final String? prescription;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateTime,
    required this.type,
    required this.status,
    this.symptoms,
    this.diagnosis,
    this.prescription,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      dateTime: DateTime.parse(json['dateTime']),
      type: json['type'],
      status: json['status'],
      symptoms: json['symptoms'],
      diagnosis: json['diagnosis'],
      prescription: json['prescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'status': status,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'prescription': prescription,
    };
  }
}