import 'package:fallnews/data/models/news_data_model.dart';

import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<NewsDataModel> getAllNews({required int page}) {
    // TODO: implement getAllNews
    throw UnimplementedError();
  }
}
