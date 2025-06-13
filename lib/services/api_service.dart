import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

class ApiService {
  // Ganti dengan URL API Laravel Anda
  // Untuk emulator Android, gunakan 10.0.2.2 sebagai localhost
  // Untuk perangkat fisik, gunakan IP address komputer Anda
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  
  // Untuk iOS simulator atau Chrome, gunakan:
  // static const String baseUrl = 'http://localhost:8000/api';
  
  final _storage = const FlutterSecureStorage();

  // Mendapatkan token dari secure storage
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // Menyimpan token ke secure storage
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  // Menghapus token dari secure storage
  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }

  // Headers untuk request dengan token
  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Register user
// Register user
Future<Map<String, dynamic>> register({
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  try {
    debugPrint('Sending registration data to: $baseUrl/register');
    debugPrint('Data: ${jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    })}');
    
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      }),
    );

    debugPrint('Registration response status: ${response.statusCode}');
    debugPrint('Registration response body: ${response.body}');

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (responseData['success'] == true) {
        // Tidak perlu menyimpan token setelah registrasi
        // karena pengguna akan login terlebih dahulu
        
        return {
          'success': true,
          'message': responseData['message'],
          'user': {
            'id': responseData['data']['id'] ?? 0,
            'name': responseData['data']['name'],
            'email': email,
          },
        };
      }
    }
    
    return {
      'success': false,
      'message': responseData['message'] ?? 'Terjadi kesalahan',
      'errors': responseData['errors'],
    };
  } catch (e) {
    debugPrint('Register error: $e');
    return {
      'success': false,
      'message': 'Terjadi kesalahan: $e',
    };
  }
}

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          // Simpan token
          await saveToken(responseData['data']['token']);
          
          return {
            'success': true,
            'message': responseData['message'],
            'user': {
              'name': responseData['data']['name'],
              'email': email,
            },
          };
        }
      }
      
      return {
        'success': false,
        'message': responseData['message'] ?? 'Login gagal',
      };
    } catch (e) {
      debugPrint('Login error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Logout user
  Future<Map<String, dynamic>> logout() async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Hapus token
        await deleteToken();
        
        return {
          'success': true,
          'message': responseData['message'] ?? 'Logout berhasil',
        };
      }
      
      return {
        'success': false,
        'message': responseData['message'] ?? 'Logout gagal',
      };
    } catch (e) {
      debugPrint('Logout error: $e');
      // Tetap hapus token meskipun terjadi error
      await deleteToken();
      return {
        'success': true,
        'message': 'Logout berhasil',
      };
    }
  }

  // Get user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final user = User.fromJson(userData);
        
        return {
          'success': true,
          'user': user,
        };
      }
      
      return {
        'success': false,
        'message': 'Gagal mendapatkan profil pengguna',
      };
    } catch (e) {
      debugPrint('Get user profile error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}