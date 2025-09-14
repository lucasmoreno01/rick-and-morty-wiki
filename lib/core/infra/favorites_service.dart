import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _key = 'favorite_characters';

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    return ids.map(int.parse).toList();
  }

  Future<void> toggleFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    if (ids.contains(id.toString())) {
      ids.remove(id.toString());
    } else {
      ids.add(id.toString());
    }
    await prefs.setStringList(_key, ids);
  }

  Future<bool> isFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    return ids.contains(id.toString());
  }
}
