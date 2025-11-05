import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

abstract class StreamUseCase<Result, Params> {
  Stream<Either<Failure, Result>> call(Params params);
}



class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class IdParams extends Equatable {
  final int fdcId;

  const IdParams({required this.fdcId});

  @override
  List<Object> get props => [fdcId];
}

class FdcIdsParams extends Equatable {
  final List<int> fdcIds;

  const FdcIdsParams({required this.fdcIds});

  @override
  List<Object> get props => [fdcIds];
}
