part of 'news_bloc.dart';

enum NewsStatus { init, loading, succ, falied }

class NewsState {
  final List<ArticleModel> news;
  final NewsStatus newsStatus;
  final bool isEndPage;
  final String? query;
  const NewsState({
    this.query,
    this.news = const [],
    this.isEndPage = false,
    this.newsStatus = NewsStatus.init,
  });

  NewsState copyWith({
    String? query,
    bool removeQuery = false,
    List<ArticleModel>? news,
    NewsStatus? newsStatus,
    bool? isEndPage,
  }) {
    return NewsState(
      query: removeQuery ? null : query ?? this.query,
      news: news ?? this.news,
      newsStatus: newsStatus ?? this.newsStatus,
      isEndPage: isEndPage ?? this.isEndPage,
    );
  }
}
