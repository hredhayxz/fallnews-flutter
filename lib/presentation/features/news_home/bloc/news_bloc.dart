import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fallnews/domain/usecases/get_news_usecase.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_event.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;

  int _currentPage = 1;
  final int _pageSize = 4;

  NewsBloc(this.getNewsUseCase) : super(NewsInitial()) {
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

        final result = await getNewsUseCase(page: _currentPage);

        result.fold(
          (failure) {
            emit(NewsError(failure, articles: state.articles));
          },
          (newsData) {
            final newArticles = newsData.articles ?? [];

            final allArticles =
                event.isRefresh
                    ? newArticles
                    : [...state.articles, ...newArticles];

            final hasReachedMax = newArticles.length < _pageSize;

            _currentPage++;

            emit(
              NewsLoaded(articles: allArticles, hasReachedMax: hasReachedMax),
            );
          },
        );
      } catch (e) {
        emit(NewsError(e.toString(), articles: state.articles));
      }
    });
  }
}
