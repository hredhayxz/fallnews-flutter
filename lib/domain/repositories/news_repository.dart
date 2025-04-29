import 'package:either_dart/either.dart';
import 'package:fallnews/data/models/news_data_model.dart';

abstract class NewsRepository {
  Future<Either<String, NewsDataModel>> getAllNews({required int page});
}
