import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF3498DB);
  static const Color secondary = Color(0xFF2980B9);
  static const Color categoryButton = Color(0xFF90CAF9);
  static const Color cardBackground = Color(0xFFBBDEFB);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color starColor = Color(0xFFFFC107);
}

class AppConstants {
  static const String appName = 'BimbelHub';
  static const String appTagline = 'mencari bimbel terdekat, termurah, efisien, dll';
  static const String searchHint = 'Jl Sememi Jaya 6-E no.73';
  static const String headerText = 'CARI BIMBEL SEKITARMU\nDENGAN HARGA IDEALMU';
  static const String idealQuestion = 'seperti apa bimbel idealmu?';
  static const String topRatedTitle = 'Bimbel dengan Rating Terbaik';
  static const String idealTitle = 'Bimbel Idealmu';
  
  static const List<Map<String, dynamic>> categories = [
    {'title': 'Bimbel Pas', 'icon': Icons.description},
    {'title': 'Terdekat', 'icon': Icons.location_on},
    {'title': 'Andalan', 'icon': Icons.emoji_events},
  ];
  
  static const List<Map<String, dynamic>> tutoringCenters = [
    {
      'name': 'Ruangguru - BimBel No.1',
      'description': 'online dan offline',
      'rating': '4.9',
      'logo': 'ruangguru_logo.png',
    },
    {
      'name': 'Aulad Gemilang Indonesia',
      'description': 'Bimbel terbaikmu',
      'rating': '4.5',
      'logo': 'agi_logo.png',
    },
  ];
  
  static const List<Map<String, dynamic>> navItems = [
    {'title': 'Beranda', 'icon': Icons.home},
    {'title': 'Promo', 'icon': Icons.local_offer},
    {'title': 'Favorit', 'icon': Icons.favorite_border},
    {'title': 'Chat', 'icon': Icons.chat_bubble_outline},
    {'title': 'Saya', 'icon': Icons.person_outline},
  ];
}
