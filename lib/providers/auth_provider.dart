import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  // Additional fields from the new code
  String? _mobileNumber;
  String? _userName;
  String? _village;
  bool _isLoggedIn = false;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // New getters
  String? get mobileNumber => _mobileNumber ?? _user?.phone;
  String? get userName => _userName ?? _user?.name;
  String? get village => _village ?? _user?.village;
  bool get isLoggedIn => _isLoggedIn || _user != null;

  // Existing OTP login method
  Future<bool> loginWithOTP(String phone) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Mock login - in real app, verify OTP with backend
      _user = User(
        id: '1',
        name: 'Village User',
        phone: phone,
        email: 'user@village.com',
        role: 'patient',
        village: 'Sample Village',
      );

      // Also set the new fields for compatibility
      _mobileNumber = phone;
      _userName = 'Village User';
      _village = 'Sample Village';
      _isLoggedIn = true;

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', _user!.toJson().toString());

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Login failed: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // NEW: Login with mobile number (without OTP - for direct login)
  Future<void> loginWithMobile(
      String mobile, String name, String village) async {
    _mobileNumber = mobile;
    _userName = name;
    _village = village;
    _isLoggedIn = true;

    // Also create a User object for compatibility
    _user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      phone: mobile,
      email: '',
      role: 'patient',
      village: village,
    );

    // Save to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', _user!.toJson().toString());

    notifyListeners();
  }

  // Logout - combined version
  Future<void> logout() async {
    _user = null;
    _mobileNumber = null;
    _userName = null;
    _village = null;
    _isLoggedIn = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }

  // Auto login check - enhanced version
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      try {
        // Parse user data (you'll need to implement proper JSON parsing)
        // For now, using mock data
        _user = User(
          id: '1',
          name: 'Village User',
          phone: '9876543210',
          email: 'user@village.com',
          role: 'patient',
          village: 'Sample Village',
        );
        _isLoggedIn = true;
        notifyListeners();
        return true;
      } catch (e) {
        // If parsing fails, clear the invalid data
        await prefs.remove('user');
        return false;
      }
    }
    return false;
  }
}
