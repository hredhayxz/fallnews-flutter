import 'package:fallnews/core/network/dio_client.dart';
import 'package:fallnews/data/datasources/news_remote_data_source.dart';
import 'package:fallnews/data/repositories/news_repository_impl.dart';
import 'package:fallnews/domain/repositories/news_repository.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> diSetup() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(sl()));
  sl.registerFactory(() => NewsBloc(sl()));
}
