import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimbelhub/theme/theme_provider.dart';
import 'package:bimbelhub/providers/auth_provider.dart';
import 'package:bimbelhub/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section
            Container(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Profile picture
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color.fromARGB(255, 102, 182, 247),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // User info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authProvider.user?.name ?? 'Pengguna',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          authProvider.user?.email ?? 'email@example.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Edit button
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      // Edit profile action
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Account section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Akun',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.history,
                    title: 'Aktivitasku',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.local_offer,
                    title: 'Promo',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.payment,
                    title: 'Cara Pembayaran',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.help,
                    title: 'Pusat Bantuan',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.location_on,
                    title: 'Alamat Favorit',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.security,
                    title: 'Keamanan Akun',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.settings,
                    title: 'Pengaturan Akun',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.language,
                    title: 'Pilihan Bahasa',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                    ),
                    onTap: () async {
                      final result = await authProvider.logout();
                      
                      if (!context.mounted) return;
                      
                      if (result['success']) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result['message']),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Info section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Info Lainnya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.info,
                    title: 'Ketentuan Bimbel',
                    isDarkMode: isDarkMode,
                  ),
                  _buildDivider(isDarkMode),
                  _buildMenuItem(
                    context,
                    icon: Icons.star,
                    title: 'Beri Kami Nilai',
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isDarkMode,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
      ),
      onTap: () {
        // Handle menu item tap
      },
    );
  }
  
  Widget _buildDivider(bool isDarkMode) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
    );
  }
}