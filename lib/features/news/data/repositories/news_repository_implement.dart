import 'package:news_app/features/news/data/datasources/remote_news_data_source.dart';

import '../../../../core/config/typedef.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/news_response.dart';

class NewsRepositoryImplement
    with HandlingExceptionManager
    implements NewsRepository {
  final remoteNews = RemoteNewsDataSource();
  @override
  DataResponse<NewsResponse> getNews(QueryParams params) async {
    return await wrapHandling<NewsResponse>(
      tryCall: () async {
        final result = await remoteNews.getNews(params);
        return result;
      },
    );
  }
}
