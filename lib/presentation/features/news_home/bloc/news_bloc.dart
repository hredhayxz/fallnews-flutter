import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fallnews/presentation/features/news_home/data/repo/get_news_repo.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_event.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_state.dart';
import 'package:fallnews/data/models/news_data_model.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsRepo _repository;
  int _currentPage = 1;
  final int _pageSize = 4;

  NewsBloc() : _repository = GetNewsRepo(), super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      if (state is NewsLoading && !event.isRefresh) return;

      try {
        if (event.isRefresh) {
          _currentPage = 1;
          emit(const NewsLoading());
        } else if (state is NewsLoaded && (state as NewsLoaded).hasReachedMax) {
          return;
        } else if (state is NewsInitial) {
          emit(const NewsLoading());
        }

        final result = await _repository.getNews(page: _currentPage);

        result.fold(
          (failure) {
            emit(
              NewsError(
                failure,
                articles: _getCurrentArticles(),
                hasReachedMax: state.hasReachedMax,
              ),
            );
          },
          (newsData) {
            final newArticles = newsData.articles ?? [];
            final updatedArticles =
                event.isRefresh
                    ? newArticles
                    : [..._getCurrentArticles(), ...newArticles];

            final hasReachedMax = newArticles.length < _pageSize;

            _currentPage++;

            emit(
              NewsLoaded(
                articles: updatedArticles,
                hasReachedMax: hasReachedMax,
              ),
            );
          },
        );
      } catch (e) {
        emit(
          NewsError(
            e.toString(),
            articles: _getCurrentArticles(),
            hasReachedMax: state.hasReachedMax,
          ),
        );
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
