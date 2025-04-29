import 'package:fallnews/core/network/dio_client.dart';
import 'package:fallnews/core/network/endpoints.dart';
import 'package:fallnews/data/models/news_data_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsDataModel> getNews({required int page});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final DioClient client;

  NewsRemoteDataSourceImpl(this.client);

  @override
  Future<NewsDataModel> getNews({required int page}) async {
    print('jfsbdjicbnslvndsndk $page');
    final response = await client.get(
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
    return NewsDataModel.fromJson(response.data);
  }
}
