import 'package:flutter/material.dart';
import 'package:bimbelhub/models/favorite_package.dart';

class FavoritesProvider extends ChangeNotifier {
  List<FavoritePackage> _favorites = [];
  
  List<FavoritePackage> get favorites => _favorites;
  
  void addToFavorites(FavoritePackage package) {
    if (!_favorites.any((element) => element.id == package.id)) {
      _favorites.add(package);
      notifyListeners();
    }
  }
  
  void removeFromFavorites(String packageId) {
    _favorites.removeWhere((element) => element.id == packageId);
    notifyListeners();
  }
  
  bool isFavorite(String packageId) {
    return _favorites.any((element) => element.id == packageId);
  }
  
  void toggleFavorite(FavoritePackage package) {
    if (isFavorite(package.id)) {
      removeFromFavorites(package.id);
    } else {
      addToFavorites(package);
    }
  }
}
