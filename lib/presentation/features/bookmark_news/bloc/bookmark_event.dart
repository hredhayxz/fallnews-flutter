import 'package:equatable/equatable.dart';
import 'package:fallnews/data/models/news_data_model.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddBookmarkEvent extends BookmarkEvent {
  final Articles article;

  AddBookmarkEvent(this.article);

  @override
  List<Object?> get props => [article];
}

class RemoveBookmarkEvent extends BookmarkEvent {
  final String articleId;

  RemoveBookmarkEvent(this.articleId);

  @override
  List<Object?> get props => [articleId];
}

class FetchBookmarksEvent extends BookmarkEvent {}
