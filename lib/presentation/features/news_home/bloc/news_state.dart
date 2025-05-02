import 'package:equatable/equatable.dart';
import 'package:fallnews/data/models/news_data_model.dart';

abstract class NewsState extends Equatable {
  final List<Articles> articles;
  final bool hasReachedMax;
  final int totalResults;

  const NewsState({
    this.articles = const [],
    this.hasReachedMax = false,
    this.totalResults = 0,
  });

  @override
  List<Object?> get props => [articles, hasReachedMax, totalResults];
}

class NewsInitial extends NewsState {
  const NewsInitial()
    : super(articles: const [], hasReachedMax: false, totalResults: 0);
}

class NewsLoading extends NewsState {
  const NewsLoading({
    super.articles = const [],
    super.hasReachedMax = false,
    super.totalResults = 0,
  });
}

class NewsLoaded extends NewsState {
  const NewsLoaded({
    required super.articles,
    required super.hasReachedMax,
    required super.totalResults,
  });
}

class NewsError extends NewsState {
  final String message;

  const NewsError(
    this.message, {
    super.articles = const [],
    super.hasReachedMax = false,
    super.totalResults = 0,
  });

  @override
  List<Object?> get props => [message, articles, hasReachedMax, totalResults];
}
