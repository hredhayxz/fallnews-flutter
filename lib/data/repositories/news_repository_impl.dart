import 'package:either_dart/either.dart';
import 'package:fallnews/data/datasources/news_remote_data_source.dart';
import 'package:fallnews/data/models/news_data_model.dart';
import 'package:fallnews/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, NewsDataModel>> getAllNews({required int page}) async {
    try {
      final result = await remoteDataSource.getNews(page: page);
      return Right(result);
    } catch (e) {
      return Left('Failed to load news');
    }
  }
}
