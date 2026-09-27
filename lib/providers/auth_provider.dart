import 'package:flutter/material.dart';
import '../models/models.dart';
import '../core/enums/enums.dart';
import '../services/mock_data_service.dart';

/// Authentication state management
class AuthProvider extends ChangeNotifier {
  final MockDataService _mockData = MockDataService();

  UserModel? _user;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  bool _isOnboardingComplete = false;
  String? _error;
  UserRole _activeRole = UserRole.customer;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get isOnboardingComplete => _isOnboardingComplete;
  String? get error => _error;
  UserRole get activeRole => _activeRole;
  bool get isProfessionalMode => _activeRole == UserRole.professional;

  void setOnboardingComplete() {
    _isOnboardingComplete = true;
    notifyListeners();
  }

  void switchRole(UserRole role) {
    _activeRole = role;
    notifyListeners();
  }

  Future<bool> login(String phone, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _user = _mockData.currentUser;
    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> register({
    required String fullName,
    required String phone,
    String? email,
    required String city,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _user = UserModel(
      id: 'new_user_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName,
      phone: phone,
      email: email,
      city: city,
      createdAt: DateTime.now(),
    );
    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> verifyOtp(String otp) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
    return otp.length == 6;
  }

  Future<void> logout() async {
    _user = null;
    _isLoggedIn = false;
    _activeRole = UserRole.customer;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Demo: auto-login for testing
  void demoLogin() {
    _user = _mockData.currentUser;
    _isLoggedIn = true;
    _isOnboardingComplete = true;
    notifyListeners();
  }
}
