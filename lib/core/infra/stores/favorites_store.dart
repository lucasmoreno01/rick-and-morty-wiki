import 'package:flutter/material.dart';
import '../favorites_service.dart';

class FavoritesStore extends ChangeNotifier {
  final FavoritesService _service;
  List<int> _favorites = [];

  FavoritesStore(this._service);

  List<int> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await _service.getFavorites();
    notifyListeners();
  }

  bool isFavorite(int id) => _favorites.contains(id);

  Future<void> toggleFavorite(int id) async {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    await _service.saveFavorites(_favorites);
    notifyListeners();
  }
}
