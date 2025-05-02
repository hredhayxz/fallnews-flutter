import 'package:equatable/equatable.dart';
import 'package:fallnews/data/models/news_data_model.dart';

abstract class BookmarkState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<Articles> bookmarks;

  BookmarkLoaded(this.bookmarks);

  @override
  List<Object?> get props => [bookmarks];
}

class BookmarkError extends BookmarkState {
  final String message;

  BookmarkError(this.message);

  @override
  List<Object?> get props => [message];
}
