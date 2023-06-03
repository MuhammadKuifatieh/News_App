import '../../../../core/config/typedef.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/get_api.dart';
import '../models/news_response.dart';

class RemoteNewsDataSource {
  Future<NewsResponse> getNews(QueryParams params) async {
    GetApi<NewsResponse> getApi = GetApi<NewsResponse>(
      uri: ApiVariables.getRepo(params),
      fromJson: newsResponseFromJson,
    );
    final result = await getApi.callRequest();
    return result;
  }
}
