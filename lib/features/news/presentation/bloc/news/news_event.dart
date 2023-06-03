part of 'news_bloc.dart';

abstract class NewsEvent {
  const NewsEvent();
}

class GetNewsEvent extends NewsEvent with EventWithReload {
  final String? query;
  @override
  final bool isReload;
  GetNewsEvent({
    this.query,
    this.isReload = false,
  });
}
