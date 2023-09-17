import 'package:dartz/dartz.dart';

import '../failures/failure.dart';

abstract class UseCasesWithParams<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithoutParams<Type>{
  Future<Either<Failure, Type>> call();
}