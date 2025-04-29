import 'package:flutter_dotenv/flutter_dotenv.dart';
String baseUrl = dotenv.env['BASE_URL']!;
String apiKey = dotenv.env['API_KEY']!;
class Endpoints {
  Endpoints._();
  static String getAllNews(String parcelId) =>
      "/rider/parcels/ride/detail/$parcelId";
}
