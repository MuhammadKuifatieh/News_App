import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../core/config/droppable_pro_max.dart';
import '../../../data/models/news_response.dart';
import '../../../data/repositories/news_repository_implement.dart';
import '../../../domain/usecases/get_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final _perPage = 10;
  final getNews = GetNews(NewsRepositoryImplement());

  NewsBloc() : super(const NewsState()) {
    on<GetNewsEvent>(
      _mapGetRepoState,
      transformer: droppableProMax(),
    );
  }
  FutureOr<void> _mapGetRepoState(
      GetNewsEvent event, Emitter<NewsState> emit) async {
    if (state.newsStatus == NewsStatus.init || event.isReload) {
      emit(state.copyWith(
        newsStatus: NewsStatus.loading,
        query: event.query,
        news: [],
      ));
      final result = await getNews(
        GetNewsParams(
          page: 1,
          perPage: _perPage,
          query: state.query,
        ),
      );
      result.fold(
        (l) => emit(state.copyWith(
          newsStatus: NewsStatus.falied,
        )),
        (r) => emit(
          state.copyWith(
            newsStatus: NewsStatus.succ,
            news: r.articles,
            isEndPage: r.articles!.length < _perPage,
          ),
        ),
      );
    } else if (!state.isEndPage) {
      emit(state.copyWith(
        newsStatus: NewsStatus.loading,
      ));
      final result = await getNews(
        GetNewsParams(
          page: state.news.length ~/ _perPage + 1,
          perPage: _perPage,
          query: state.query,
        ),
      );
      result.fold(
        (l) => emit(state.copyWith(
          newsStatus: NewsStatus.falied,
        )),
        (r) => emit(
          state.copyWith(
            newsStatus: NewsStatus.succ,
            news: List.of(state.news)..addAll(r.articles!),
            isEndPage: r.articles!.length < _perPage,
          ),
        ),
      );
    }
  }
}
