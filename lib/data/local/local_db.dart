import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDB {
  late Box _box;

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

  // Store user data
  void setUserData(dynamic user) {
    _box.put('userData', jsonEncode(user));
  }

  // Get user data
  dynamic getUserData() {
    return jsonDecode(_box.get('userData') ?? '{}');
  }

  // Store home news data
  void setHomeNews(dynamic news) {
    _box.put('allHomeNews', jsonEncode(news));
  }

  // Get home news data
  dynamic getHomeNews() {
    return jsonDecode(_box.get('allHomeNews') ?? '{}');
  }

  // Store bookmarked news data
  void setBookMarkNews(dynamic news) {
    _box.put('allBookmarked', jsonEncode(news));
  }

  // Get bookmarked news data
  dynamic getBookMarkNews() {
    return jsonDecode(_box.get('allBookmarked') ?? '{}');
  }
}
