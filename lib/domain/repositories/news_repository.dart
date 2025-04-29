import 'package:fallnews/data/models/news_data_model.dart';

abstract class NewsRepository {
  Future<NewsDataModel> getAllNews({required int page});
}
