import 'package:fallnews/core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> diSetup() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
}
