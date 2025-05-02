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

  NewsBloc() : _repository = GetNewsRepo(), super(const NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      if (state is NewsLoading && !event.isRefresh) return;

      try {
        if (event.isRefresh) {
          emit(const NewsLoading());
        } else if (state is NewsInitial) {
          emit(const NewsLoading());
        }

        final result = await _repository.getNews(
          page: event.page,
          pageSize: _pageSize,
        );

        await result.fold(
          (failure) async {
            final currentTotal = state.totalResults;
            if (await di.hasInternetConnection()) {
              emit(
                NewsError(
                  failure,
                  articles: _getCurrentArticles(),
                  hasReachedMax: state.hasReachedMax,
                  totalResults: currentTotal,
                ),
              );
            } else {
              final cachedNews = LocalDB.homeNews;
              if (cachedNews.isNotEmpty) {
                emit(
                  NewsLoaded(
                    articles: cachedNews,
                    hasReachedMax: state.hasReachedMax,
                    totalResults: currentTotal,
                  ),
                );
              }
            }
          },
          (newsData) {
            final newArticles = newsData.articles ?? [];
            final totalResults = newsData.totalResults ?? 0;

            final updatedArticles =
                event.isRefresh
                    ? newArticles
                    : [..._getCurrentArticles(), ...newArticles];

            // Only append new articles if they exist
            final hasReachedMax = newArticles.isEmpty;

            if (newArticles.isNotEmpty) {
              LocalDB.homeNews = updatedArticles;
            }

            emit(
              NewsLoaded(
                articles: updatedArticles,
                hasReachedMax: hasReachedMax,
                totalResults: totalResults,
              ),
            );
          },
        );
      } catch (e) {
        final currentTotal = state.totalResults;
        final cachedNews = LocalDB.homeNews;
        if (await di.hasInternetConnection()) {
          emit(
            NewsError(
              e.toString(),
              articles: _getCurrentArticles(),
              hasReachedMax: state.hasReachedMax,
              totalResults: currentTotal,
            ),
          );
        } else if (cachedNews.isNotEmpty) {
          emit(
            NewsLoaded(
              articles: cachedNews,
              hasReachedMax: state.hasReachedMax,
              totalResults: currentTotal,
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
