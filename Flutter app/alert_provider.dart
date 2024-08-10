import 'package:flutter/material.dart';

class AlertProvider with ChangeNotifier {
  String? _alertMessage;
  bool _isAlertVisible = false;
  List<String> _alerts = []; // Property to track visibility

  String? get alertMessage => _alertMessage;
  bool get isAlertVisible => _isAlertVisible;
  List<String> get alerts => _alerts;

  // Method to show alert
  void showAlert(String message) {
    _alertMessage = message;
    _isAlertVisible = true;
    notifyListeners();
  }

  // Method to hide alert
  void hideAlert() {
    _isAlertVisible = false;
    notifyListeners();
  }

  // Method to clear the alert message
  void clearAlert() {
    _alertMessage = null;
    _isAlertVisible = false;
    notifyListeners();
  }

  void addAlert(String alertMessage) {
    _alerts.add(alertMessage);
    notifyListeners();
  }
}
