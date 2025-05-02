import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallnews/core/network/dio_client.dart';
import 'package:fallnews/core/utils/connectivity_checker.dart';
import 'package:fallnews/presentation/features/bookmark_news/repo/bookmark_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> diSetup() async {
  sl.registerLazySingleton<ConnectivityChecker>(() => ConnectivityChecker());
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => BookmarkRepository(sl(), sl()));
}
