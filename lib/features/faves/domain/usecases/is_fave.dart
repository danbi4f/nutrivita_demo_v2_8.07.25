import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class IsFave implements UseCase<bool, IdParams> {
  final FavesRepository repository;

  IsFave(this.repository);

  @override
  Future<Either<Failure, bool>> call(IdParams params) async {
    return await repository.isFave(params.fdcId);
  }
}
