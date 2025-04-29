import 'package:fallnews/core/network/dio_client.dart';
import 'package:fallnews/core/utils/connectivity_checker.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> diSetup() async {
  sl.registerLazySingleton<ConnectivityChecker>(() => ConnectivityChecker());
  sl.registerLazySingleton<DioClient>(() => DioClient());
}
