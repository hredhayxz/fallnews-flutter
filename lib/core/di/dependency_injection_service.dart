import 'package:fallnews/core/network/dio_client.dart';
import 'package:fallnews/data/local/local_db.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> diSetup() async {
  await LocalDB().initializeHive().then(
    (_) => sl.registerLazySingleton<LocalDB>(() => LocalDB()),
  );

  sl.registerLazySingleton<DioClient>(() => DioClient());
}
