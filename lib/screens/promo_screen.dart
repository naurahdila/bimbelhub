import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimbelhub/theme/theme_provider.dart';
import 'package:bimbelhub/screens/use_promo_screen.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 8),
            const Text(
              'Promo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
              _buildPromoCard(
                context,
                title: 'VOUCHER DISKON',
                amount: 'Rp 20.000',
                expiry: '15 November 2024',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              _buildPromoCard(
                context,
                title: 'DISKON 10%',
                amount: 'SPESIAL DARI BCA',
                expiry: '15 November 2024',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              _buildPromoCard(
                context,
                title: 'VOUCHER DISKON',
                amount: 'Rp 20.000',
                expiry: '20 November 2024',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              _buildPromoCard(
                context,
                title: 'VOUCHER DISKON',
                amount: 'Rp 15.000',
                expiry: '25 November 2024',
                isDarkMode: isDarkMode,
              ),
              _buildPromoCard(
                context,
                title: 'VOUCHER DISKON',
                amount: 'Rp 20.000',
                expiry: '15 November 2024',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              _buildPromoCard(
                context,
                title: 'DISKON 10%',
                amount: 'SPESIAL DARI BCA',
                expiry: '15 November 2024',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              _buildPromoCard(
                context,
                title: 'VOUCHER DISKON',
                amount: 'Rp 20.000',
                expiry: '20 November 2024',
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              _buildPromoCard(
                context,
                title: 'VOUCHER DISKON',
                amount: 'Rp 15.000',
                expiry: '25 November 2024',
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPromoCard(
    BuildContext context, {
    required String title,
    required String amount,
    required String expiry,
    required bool isDarkMode,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[200],
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.black87),
                const SizedBox(width: 4),
                Text(
                  'Berlaku hingga $expiry',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsePromoScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Pakai',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}