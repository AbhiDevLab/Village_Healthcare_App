import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

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

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    
    if (userData != null) {
      // Parse user data (simplified)
      _user = User(
        id: '1',
        name: 'Village User',
        phone: '9876543210',
        email: 'user@village.com',
        role: 'patient',
        village: 'Sample Village',
      );
      notifyListeners();
      return true;
    }
    return false;
  }
}