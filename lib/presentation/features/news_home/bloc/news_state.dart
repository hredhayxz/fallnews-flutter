import 'package:equatable/equatable.dart';
import 'package:fallnews/data/models/news_data_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsDataModel news;

  NewsLoaded(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
