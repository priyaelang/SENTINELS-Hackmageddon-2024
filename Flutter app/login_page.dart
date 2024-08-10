import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Simulate login logic, replace with actual authentication
    if (_usernameController.text.isNotEmpty && _passwordController.text == "password") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: _usernameController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  void _signup() {
    Navigator.pushNamed(context, '/signup');
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: TextStyle(fontSize: 24)),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: _forgotPassword,
              child: Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: _signup,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String _generatedVerificationCode = '123456'; // Simulated verification code
  bool _isCodeSent = false;
  bool _isVerified = false;

  void _sendVerificationCode() {
    // Simulate sending the verification code
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification code sent to ${_emailController.text}')),
    );
    setState(() {
      _isCodeSent = true;
    });
  }

  void _verifyCode() {
    if (_verificationCodeController.text == _generatedVerificationCode) {
      setState(() {
        _isVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification successful! Please reset your password.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid verification code')),
      );
    }
  }

  void _resetPassword() {
    if (_isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset successful! Please log in with your new password.')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please verify your email first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Forgot Password', style: TextStyle(fontSize: 24)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            if (_isCodeSent) ...[
              TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(labelText: 'Verification Code'),
              ),
              ElevatedButton(
                onPressed: _verifyCode,
                child: Text('Verify Code'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: _sendVerificationCode,
                child: Text('Send Verification Code'),
              ),
            ],
            if (_isVerified) ...[
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Reset Password'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
