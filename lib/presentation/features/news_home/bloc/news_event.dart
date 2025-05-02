import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsEvent extends NewsEvent {
  final int page;
  final bool isRefresh;

  const FetchNewsEvent({required this.page, this.isRefresh = false});

  @override
  List<Object?> get props => [page, isRefresh];
}
