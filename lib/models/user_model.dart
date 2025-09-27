class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final String village;
  final DateTime? dateOfBirth;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.village,
    this.dateOfBirth,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
      village: json['village'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
      'village': village,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'profileImage': profileImage,
    };
  }
}