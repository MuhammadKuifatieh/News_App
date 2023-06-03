import 'package:dartz/dartz.dart';

import '../../../../core/config/typedef.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/news_response.dart';
import '../repositories/news_repository.dart';

class GetNews implements UseCase<NewsResponse, GetNewsParams> {
  final NewsRepository newsRepository;

  GetNews(this.newsRepository);
  @override
  Future<Either<Failure, NewsResponse>> call(GetNewsParams params) async {
    return await newsRepository.getNews(params.getParams());
  }
}

class GetNewsParams with Params {
  final int page;
  final int perPage;
  final String? query;

  GetNewsParams({
    required this.page,
    required this.perPage,
    this.query,
  });
  @override
  QueryParams getParams() => super.getParams()
    ..addAll(
      {
        "page": page.toString(),
        "pageSize": perPage.toString(),
        if (query != null) 'q': query!,
      },
    );
}
