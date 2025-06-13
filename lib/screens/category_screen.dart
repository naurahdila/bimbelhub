import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimbelhub/theme/theme_provider.dart';
import 'package:bimbelhub/screens/package_screen.dart';

enum CategoryType {
  pas,
  terdekat,
  andalan,
  terbaru,
}

class CategoryScreen extends StatelessWidget {
  final CategoryType type;
  final String title;

  const CategoryScreen({
    Key? key,
    required this.type,
    required this.title,
  }) : super(key: key);

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
            Text(
              'Bimbel $title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTutoringItem(
            context,
            name: 'Ruangguru - BimBel No.1',
            address: 'Jl. Kusuma Bangsa No.74',
            rating: 4.9,
            logoType: 'ruangguru',
            info: type == CategoryType.terdekat || type == CategoryType.terbaru
                ? '${type == CategoryType.terbaru ? '16 km' : '100 M'}'
                : 'Mulai 4.000/hari',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PackageScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildTutoringItem(
            context,
            name: 'Aulad Gemilang Indonesia - Bimbel terbaikmu',
            address: 'Jl. Pondok Benowo Indah',
            rating: 4.5,
            logoType: 'agi',
            info: type == CategoryType.terdekat || type == CategoryType.terbaru
                ? '${type == CategoryType.terbaru ? '2 km' : '2 km'}'
                : 'Mulai 8.000/hari',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildTutoringItem(
            context,
            name: 'Star Class',
            address: 'Jl. Sememi Selatan Baru 1',
            rating: 4.3,
            logoType: 'star',
            info: type == CategoryType.terdekat
                ? '100 M'
                : 'Mulai 5.000/hari',
            onTap: () {},
          ),
          if (type == CategoryType.terdekat || type == CategoryType.terbaru)
            const SizedBox(height: 16),
          if (type == CategoryType.terdekat || type == CategoryType.terbaru)
            _buildTutoringItem(
              context,
              name: 'Ruangguru - BimBel No.1',
              address: 'Jl. Sememi Selatan Baru 1',
              rating: 4.9,
              logoType: 'ruangguru',
              info: '3 km',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PackageScreen()),
              ),
            ),
        ],
      ),
    );
  }

  Widget _getCategoryIcon(CategoryType type) {
    switch (type) {
      case CategoryType.pas:
        return const Icon(Icons.check_circle_outline);
      case CategoryType.terdekat:
        return const Icon(Icons.location_on_outlined);
      case CategoryType.andalan:
        return const Icon(Icons.emoji_events_outlined);
      case CategoryType.terbaru:
        return const Icon(Icons.new_releases_outlined);
    }
  }

  Widget _buildTutoringItem(
    BuildContext context, {
    required String name,
    required String address,
    required double rating,
    required String logoType,
    required String info,
    required VoidCallback onTap,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Logo area
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: Center(
                child: _getLogo(logoType),
              ),
            ),
            // Info area
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      info,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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

  Widget _getLogo(String logoType) {
    switch (logoType) {
      case 'ruangguru':
        return Image.asset(
          'assets/images/ruangguru.png',
          height: 60,
          fit: BoxFit.contain,
        );
      case 'agi':
        return Image.asset(
          'assets/images/agi.png',
          height: 60,
          fit: BoxFit.contain,
        );
      case 'star':
        return const Text(
          'Star Class',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        );
      default:
        return const SizedBox();
    }
  }
}