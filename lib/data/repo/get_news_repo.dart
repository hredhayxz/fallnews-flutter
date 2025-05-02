import 'package:either_dart/either.dart';
import 'package:fallnews/core/di/dependency_injection_service.dart';
import 'package:fallnews/core/network/dio_client.dart';
import 'package:fallnews/core/network/endpoints.dart';
import 'package:fallnews/data/models/news_data_model.dart';

class GetNewsRepo {
  final _dioClient = sl.get<DioClient>();

  Future<Either<String, NewsDataModel>> getNews({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _dioClient.get(
        '/everything',
        queryParameters: {
          'q': 'tesla',
          'sortBy': 'publishedAt',
          'page': page,
          'pageSize': pageSize,
          'apiKey': apiKey,
        },
      );

      final newsData = NewsDataModel.fromJson(response.data);

      return Right(newsData);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
