import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimbelhub/theme/theme_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home, 'Beranda', true),
          _buildNavItem(context, Icons.headset_mic, 'Promo', false),
          _buildNavItem(context, Icons.favorite_border, 'Favorit', false),
          _buildNavItem(context, Icons.chat_bubble_outline, 'Chat', false),
          _buildNavItem(context, Icons.person_outline, 'Saya', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isActive) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final color = isActive 
      ? Colors.blue 
      : (isDarkMode ? Colors.white70 : Colors.black54);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }
}



