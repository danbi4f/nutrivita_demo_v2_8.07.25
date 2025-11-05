import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class StreamUseCase<Result, Params> {
  Stream<Either<Failure, Result>> call(Params params);
}


class Params extends Equatable {
  final int fdcId;

  const Params({required this.fdcId});

  @override
  List<Object> get props => [fdcId];
}