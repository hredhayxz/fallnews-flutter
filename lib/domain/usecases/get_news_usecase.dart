import 'package:either_dart/either.dart';
import 'package:fallnews/data/models/news_data_model.dart';
import 'package:fallnews/domain/repositories/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<Either<String, NewsDataModel>> call({required int page}) {
    return repository.getAllNews(page: page);
  }
}
