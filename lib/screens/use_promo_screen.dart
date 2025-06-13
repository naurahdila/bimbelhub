import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimbelhub/theme/theme_provider.dart';
import 'package:bimbelhub/screens/package_screen.dart';

class UsePromoScreen extends StatelessWidget {
  const UsePromoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Gunakan Promomu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTutoringCard(
                context,
                name: 'Ruangguru - BimBel No.1',
                logoType: 'ruangguru',
                rating: 4.9,
                distance: '16 km',
                address: 'Jl. Kusuma Bangsa No.74',
                price: 'Mulai 4.000/hari',
                isDarkMode: isDarkMode,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PackageScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildTutoringCard(
                context,
                name: 'Aulad Gemilang Indonesia - Bimbel terbaikmu',
                logoType: 'agi',
                rating: 4.5,
                distance: '2 km',
                address: 'Jl. Pondok Benowo Indah',
                price: 'Mulai 8.000/hari',
                isDarkMode: isDarkMode,
                onTap: () {
                  // Navigate to AGI package screen if needed
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTutoringCard(
    BuildContext context, {
    required String name,
    required String logoType,
    required double rating,
    required String distance,
    required String address,
    required String price,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Logo container
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: logoType == 'ruangguru'
                    ? Image.asset(
                        'assets/images/ruangguru.png',
                        height: 60,
                      )
                    : Image.asset(
                        'assets/images/agi.png',
                        height: 60,
                      ),
              ),
            ),
            // Info container
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$rating',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        distance,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}