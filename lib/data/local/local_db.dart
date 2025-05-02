import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fallnews/data/models/news_data_model.dart';

class LocalDB {
  static late Box _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

  // User Data
  static set userData(dynamic user) => _box.put('userData', jsonEncode(user));

  static dynamic get userData => jsonDecode(_box.get('userData') ?? '{}');

  // Home News (List<Articles>)
  static set homeNews(List<Articles> news) {
    final newsJson = news.map((e) => e.toJson()).toList();
    _box.put('allHomeNews', jsonEncode(newsJson));
  }

  static List<Articles> get homeNews {
    final data = _box.get('allHomeNews');
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => Articles.fromJson(e)).toList();
  }

  // Bookmarked News (List<Articles>)
  static set bookMarkNews(List<Articles> news) {
    final newsJson = news.map((e) => e.toJson()).toList();
    _box.put('allBookmarked', jsonEncode(newsJson));
  }

  static List<Articles> get bookMarkNews {
    final data = _box.get('allBookmarked');
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => Articles.fromJson(e)).toList();
  }
}
