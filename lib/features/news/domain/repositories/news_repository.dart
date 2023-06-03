import '../../../../core/config/typedef.dart';
import '../../data/models/news_response.dart';

abstract class NewsRepository {
  DataResponse<NewsResponse> getNews(QueryParams params);
}
