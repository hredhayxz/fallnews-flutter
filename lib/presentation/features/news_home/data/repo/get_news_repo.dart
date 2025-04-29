import 'package:either_dart/either.dart';
import 'package:fallnews/core/di/dependency_injection_service.dart';
import 'package:fallnews/core/network/dio_client.dart';
import 'package:fallnews/core/network/endpoints.dart';
import 'package:fallnews/data/models/news_data_model.dart';

class GetNewsRepo {
  final _dioClient = sl.get<DioClient>();

  Future<Either<String, NewsDataModel>> getNews({required int page}) async {
    try {
      final response = await _dioClient.get(
        '/everything',
        queryParameters: {
          'q': 'tesla',
          'from': '2025-03-29',
          'sortBy': 'publishedAt',
          'page': page,
          'pageSize': 10,
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
