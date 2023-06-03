import 'package:dartz/dartz.dart';

import '../config/typedef.dart';
import '../error/failures.dart';

abstract class UseCase<Type, P extends Params> {
  Future<Either<Failure, Type>> call(P params);
}

mixin Params {
  Body getBody() => {};

  QueryParams getParams() => {
        "apiKey": "17bf9f1a5c9f47bda2038c4aca881d49",
        "domains": "techcrunch.com,thenextweb.com",
      };
}

class NoParams with Params {}
