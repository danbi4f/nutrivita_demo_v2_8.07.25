import 'package:dartz/dartz.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/repositories/faves_repository.dart';

class RemoveFaveUseCase implements UseCase<void, IdParams> {
  final FavesRepository repository;

  RemoveFaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(IdParams params) async {
    try {
      final data = await repository.removeFave(params.fdcId);
      return Right(data);
    } catch (_) {
      return Left(DatabaseFailure());
    }
  }
}

