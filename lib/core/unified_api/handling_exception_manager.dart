import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../error/failures.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> wrapHandling<T>({
    required Future<T> Function() tryCall,
    Future<T?> Function()? tryCallLocal,
  }) async {
    try {
      final right = await tryCall();
      return Right(right);
    } catch (e) {
      log("<< catch >> error is $e");
      if (tryCallLocal != null) {
        final result = await tryCallLocal();
        if (result != null) {
          return Right(result);
        } else {
          return const Left(ServerFailure(".message"));
        }
      } else {
        return const Left(ServerFailure(".message"));
      }
    }
  }
}
