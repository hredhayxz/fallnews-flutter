import 'package:equatable/equatable.dart';
import 'package:fallnews/data/models/news_data_model.dart';

abstract class NewsState extends Equatable {
  final List<Articles> articles;
  final bool hasReachedMax;

  const NewsState({this.articles = const [], this.hasReachedMax = false});

  @override
  List<Object?> get props => [articles, hasReachedMax];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
  const NewsLoading({super.articles = const [], super.hasReachedMax});
}

class NewsLoaded extends NewsState {
  const NewsLoaded({required super.articles, required super.hasReachedMax});
}

class NewsError extends NewsState {
  final String message;

  const NewsError(
    this.message, {
    super.articles = const [],
    super.hasReachedMax,
  });

  @override
  List<Object?> get props => [message, articles];
}
