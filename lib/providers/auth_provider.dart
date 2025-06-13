import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  bool _isInitialized = false; // Tambahkan flag untuk mencegah multiple initialization

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  // Memeriksa status autentikasi saat aplikasi dimulai
  Future<void> checkAuthStatus() async {
    if (_isInitialized) return; // Hindari multiple initialization
    
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _apiService.getToken();

      if (token != null) {
        final result = await _apiService.getUserProfile();

        if (result['success']) {
          _user = result['user'];
          _isAuthenticated = true;
        } else {
          // Token tidak valid, hapus token
          await _apiService.deleteToken();
          _isAuthenticated = false;
        }
      } else {
        _isAuthenticated = false;
      }
    } catch (e) {
      debugPrint('Check auth status error: $e');
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      _isInitialized = true; // Set flag setelah inisialisasi
      notifyListeners();
    }
  }

  // Register user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      return result;
    } catch (e) {
      debugPrint('Register provider error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.login(
        email: email,
        password: password,
      );

      if (result['success']) {
        await getUserProfile();
      }

      return result;
    } catch (e) {
      debugPrint('Login provider error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout user
  Future<Map<String, dynamic>> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.logout();

      if (result['success']) {
        _user = null;
        _isAuthenticated = false;
      }

      return result;
    } catch (e) {
      debugPrint('Logout provider error: $e');
      // Tetap reset state meskipun terjadi error
      _user = null;
      _isAuthenticated = false;
      return {
        'success': true,
        'message': 'Logout berhasil',
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get user profile
  Future<void> getUserProfile() async {
    try {
      final result = await _apiService.getUserProfile();

      if (result['success']) {
        _user = result['user'];
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
      }
    } catch (e) {
      debugPrint('Get user profile provider error: $e');
      _isAuthenticated = false;
    }

    notifyListeners();
  }
}
