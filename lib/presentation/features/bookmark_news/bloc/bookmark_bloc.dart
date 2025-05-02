import 'package:fallnews/presentation/features/bookmark_news/repo/bookmark_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final BookmarkRepository _repository;

  BookmarkBloc(this._repository) : super(BookmarkInitial()) {
    on<AddBookmarkEvent>((event, emit) async {
      emit(BookmarkLoading());
      final result = await _repository.addBookmark(event.article);
      result.fold(
        (error) => emit(BookmarkError(error)),
        (_) => add(FetchBookmarksEvent()),
      );
    });

    on<RemoveBookmarkEvent>((event, emit) async {
      emit(BookmarkLoading());
      final result = await _repository.removeBookmark(event.articleId);
      result.fold(
        (error) => emit(BookmarkError(error)),
        (_) => add(FetchBookmarksEvent()),
      );
    });

    on<FetchBookmarksEvent>((event, emit) async {
      emit(BookmarkLoading());
      final result = await _repository.getBookmarks();
      result.fold(
        (error) => emit(BookmarkError(error)),
        (bookmarks) => emit(BookmarkLoaded(bookmarks)),
      );
    });
  }
}
