import 'package:dartz/dartz.dart';

import '../error/failures.dart';

typedef FromJson<T> = T Function(String body);

typedef QueryParams = Map<String, String>;

typedef Body = Map<String, dynamic>;

typedef DataResponse<T> = Future<Either<Failure, T>>;
