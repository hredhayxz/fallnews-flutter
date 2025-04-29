import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNews extends NewsEvent {
  final int page;

  LoadNews(this.page);

  @override
  List<Object?> get props => [page];
}
