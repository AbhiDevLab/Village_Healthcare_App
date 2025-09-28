import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _villageController,
              decoration: InputDecoration(
                labelText: 'Village',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('Login with Mobile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (_mobileController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _villageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Temporarily store details in provider
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.loginWithMobile(
      _mobileController.text,
      _nameController.text,
      _villageController.text,
    );

    // Show OTP dialog
    _showOtpDialog(context);
  }

  void _showOtpDialog(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    final auth = Provider.of<AuthProvider>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text('Enter OTP'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('An OTP has been sent to ${_mobileController.text}.'),
            SizedBox(height: 16),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: Text('Verify'),
            onPressed: () async {
              final otp = otpController.text;
              if (otp.isEmpty) {
                // You might want to show a small error here
                return;
              }

              final success = await auth.verifyOtpAndLogin(otp);

              if (success) {
                // The Consumer in main.dart will handle navigation.
                // We just need to close the dialog.
                if (Navigator.of(ctx).canPop()) {
                  Navigator.of(ctx).pop();
                }
              } else {
                // Show error if OTP is incorrect
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(auth.error ?? 'Invalid OTP'),
                      backgroundColor: Colors.red),
                );
                // Optionally close the dialog on failure too
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
