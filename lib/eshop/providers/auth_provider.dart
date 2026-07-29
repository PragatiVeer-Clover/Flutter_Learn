import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _userName;
  String? _userEmail;
  bool get isLoggedIn => _userName != null;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  // Simulated login — accepts any non-empty credentials
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isNotEmpty && password.length >= 6) {
      _userName = email.split('@').first;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      _userName = name;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }
}
