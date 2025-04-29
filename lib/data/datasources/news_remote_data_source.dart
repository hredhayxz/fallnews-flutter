import 'package:dio/dio.dart';
import 'package:fallnews/core/network/endpoints.dart';
import 'package:fallnews/data/models/news_data_model.dart';

class NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSource(this.dio);

  Future<NewsDataModel> getAllNews({required int page}) async {
    final response = await dio.get(
      '',
      queryParameters: {
        'q': 'tesla',
        'sortBy': 'publishedAt',
        'page': page,
        'pageSize': 10,
        'apiKey': apiKey,
      },
    );

    return NewsDataModel.fromJson(response.data ?? {});
  }
}
