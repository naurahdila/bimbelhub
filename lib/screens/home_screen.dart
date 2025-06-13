import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimbelhub/utils/constants.dart';
import 'package:bimbelhub/screens/package_screen.dart';
import 'package:bimbelhub/screens/favorites_screen.dart';
import 'package:bimbelhub/screens/profile_screen.dart';
import 'package:bimbelhub/screens/promo_screen.dart';
import 'package:bimbelhub/screens/chat_screen.dart';
import 'package:bimbelhub/screens/category_screen.dart';
import 'package:bimbelhub/theme/theme_provider.dart';
import 'package:bimbelhub/providers/favorites_provider.dart';
import 'package:bimbelhub/providers/chat_provider.dart';
import 'package:bimbelhub/providers/auth_provider.dart';
import 'package:bimbelhub/models/favorite_package.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildHomeContent(),
      const PromoScreen(),
      const FavoritesScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF4A9DFF),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            activeIcon: Icon(Icons.local_offer),
            label: 'Promo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Saya',
          ),
        ],
      ),
    );
  }
  
  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildChatQuestion(),
            _buildCategoryButtons(),
            _buildTopRatedSection(),
            _buildIdealSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A9DFF), Color(0xFF2D8BFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DETEKSI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.black54, size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Jl Sememi Jaya 6-E no.73',
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A9DFF).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bolt, color: Color(0xFF4A9DFF), size: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'CARI BIMBEL SEKITARMU\nDENGAN HARGA IDEALMU',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildChatQuestion() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = 3; // Switch to chat tab
          _pageController.jumpToPage(3);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.chat_bubble_outline, color: Colors.black54),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'seperti apa bimbel idealmu?',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF4A9DFF).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.school, color: Color(0xFF4A9DFF), size: 18),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryButtons() {
    final categories = [
      {
        'title': 'Bimbel Pas',
        'icon': Icons.check_circle_outline,
        'screen': CategoryType.pas,
      },
      {
        'title': 'Terdekat',
        'icon': Icons.location_on_outlined,
        'screen': CategoryType.terdekat,
      },
      {
        'title': 'Andalan',
        'icon': Icons.emoji_events_outlined,
        'screen': CategoryType.andalan,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: categories.map((category) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      type: category['screen'] as CategoryType,
                      title: category['title'] as String,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF8BC4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      color: Colors.black87,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildTopRatedSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bimbel dengan Rating Terbaik',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTutoringCard(
                  name: 'Ruangguru',
                  description: 'Bimbel No.1 online dan offline',
                  rating: 4.9,
                  logoType: 'ruangguru',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTutoringCard(
                  name: 'Aulad Gemilang Indonesia',
                  description: 'Bimbel terbaikmu',
                  rating: 4.5,
                  logoType: 'agi',
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTutoringCard({
    required String name,
    required String description,
    required double rating,
    required String logoType,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (_) => const PackageScreen())
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Container(
              height: 40,
              alignment: Alignment.center,
              child: logoType == 'ruangguru'
                  ? Image.asset('assets/images/ruanggurU.png', 
                      errorBuilder: (context, error, stackTrace) => 
                          Text('ruangguru', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 16)))
                  : Image.asset('assets/images/AGI.png',
                      errorBuilder: (context, error, stackTrace) => 
                          Text('AGI', style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 16))),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildIdealSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bimbel Idealmu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade100),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Center(
              child: Text(
                'Star Class',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
