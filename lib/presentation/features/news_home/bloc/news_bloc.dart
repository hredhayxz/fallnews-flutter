import 'package:fallnews/core/di/dependency_injection_service.dart';
import 'package:fallnews/core/utils/connectivity_checker.dart';
import 'package:fallnews/data/local/local_db.dart';
import 'package:fallnews/data/repo/get_news_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_event.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_state.dart';
import 'package:fallnews/data/models/news_data_model.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsRepo _repository;
  final int _pageSize = 20;
  final ConnectivityChecker di = sl.get<ConnectivityChecker>();

  NewsBloc() : _repository = GetNewsRepo(), super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      if (state is NewsLoading && !event.isRefresh) return;

      try {
        if (event.isRefresh) {
          emit(const NewsLoading());
        } else if (state is NewsLoaded && (state as NewsLoaded).hasReachedMax) {
          return;
        } else if (state is NewsInitial) {
          emit(const NewsLoading());
        }

        final result = await _repository.getNews(
          page: event.page,
          pageSize: _pageSize,
        );

        await result.fold(
          (failure) async {
            if (await di.hasInternetConnection()) {
              emit(
                NewsError(
                  failure,
                  articles: _getCurrentArticles(),
                  hasReachedMax: state.hasReachedMax,
                ),
              );
            } else {
              final cachedNews = LocalDB.homeNews;
              if (cachedNews.isNotEmpty) {
                emit(
                  NewsLoaded(
                    articles: cachedNews,
                    hasReachedMax: state.hasReachedMax,
                  ),
                );
              }
            }
          },
          (newsData) {
            final newArticles = newsData.articles ?? [];

            final updatedArticles =
                event.isRefresh
                    ? newArticles
                    : [..._getCurrentArticles(), ...newArticles];

            final hasReachedMax = newArticles.length < _pageSize;

            LocalDB.homeNews = updatedArticles;

            emit(
              NewsLoaded(
                articles: updatedArticles,
                hasReachedMax: hasReachedMax,
              ),
            );
          },
        );
      } catch (e) {
        final cachedNews = LocalDB.homeNews;
        if (await di.hasInternetConnection()) {
          emit(
            NewsError(
              e.toString(),
              articles: _getCurrentArticles(),
              hasReachedMax: state.hasReachedMax,
            ),
          );
        } else if (cachedNews.isNotEmpty) {
          emit(
            NewsLoaded(
              articles: cachedNews,
              hasReachedMax: state.hasReachedMax,
            ),
          );
        }
      }
    });
  }

  List<Articles> _getCurrentArticles() {
    if (state is NewsLoaded) {
      return (state as NewsLoaded).articles;
    } else if (state is NewsError) {
      return (state as NewsError).articles;
    }
    return [];
  }
}
